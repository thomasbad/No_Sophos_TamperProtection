ECHO OFF
CLS
Title No Sophos TP
Color 17

:MENU2
ECHO ..............................................................................................
ECHO .
ECHO      88b 88  dP"Yb      .dP"Y8  dP"Yb  88""Yb 88  88  dP"Yb  .dP"Y8     888888 88""Yb 
ECHO      88Yb88 dP   Yb     `Ybo." dP   Yb 88__dP 88  88 dP   Yb `Ybo."       88   88__dP 
ECHO      88 Y88 Yb   dP     o.`Y8b Yb   dP 88"""  888888 Yb   dP o.`Y8b       88   88"""  
ECHO      88  Y8  YbodP      8bodP'  YbodP  88     88  88  YbodP  8bodP'       88   88     
ECHO .
ECHO ..............................................................................................
ECHO .
ECHO ...............................................
ECHO Remember You Should run this as Admin under WIN PE
ECHO This process needs to do twice to ensure it is totally loaded by SOPHOS
ECHO Now Please Input the Drive Letter of the system you need to modify
ECHO ...............................................
SET DRIVELETTER=
SET /P DRIVELETTER=Please Input the Drive Letter of the system you need to modify and Press ENTER:


:MENU
CLS
ECHO ..............................................................................................
ECHO .
ECHO      88b 88  dP"Yb      .dP"Y8  dP"Yb  88""Yb 88  88  dP"Yb  .dP"Y8     888888 88""Yb 
ECHO      88Yb88 dP   Yb     `Ybo." dP   Yb 88__dP 88  88 dP   Yb `Ybo."       88   88__dP 
ECHO      88 Y88 Yb   dP     o.`Y8b Yb   dP 88"""  888888 Yb   dP o.`Y8b       88   88"""  
ECHO      88  Y8  YbodP      8bodP'  YbodP  88     88  88  YbodP  8bodP'       88   88     
ECHO .
ECHO ..............................................................................................
ECHO .
ECHO ...............................................
ECHO PRESS 1 or 2 to select your task, or q to EXIT.
ECHO Please ensure the tool is run under WIN PE or safe mode with admin right to work.
ECHO ...............................................
ECHO .
ECHO 1 - Disable Sophos InterX tamper protection
ECHO 2 - Enable Sophos InterX tamper protection
ECHO q - Exit the tool
ECHO.
SET INPUT=
SET /P INPUT=Please select a number then press ENTER:
IF /I '%INPUT%'=='1' GOTO DISTP
IF /I '%INPUT%'=='2' GOTO ENTP
IF /I '%INPUT%'=='q' GOTO QUIT

ECHO ============INVALID INPUT============
ECHO -------------------------------------
ECHO Please select a number from the Main
echo Menu or select 'q' to quit.
ECHO -------------------------------------
ECHO ======PRESS ANY KEY TO CONTINUE======

PAUSE > NUL
GOTO MENU


:DISTP
CLS
reg load HKLM\TEMPSYSTEM %DRIVELETTER%:\Windows\System32\config\SYSTEM
reg load HKLM\TEMPSOFTWARE %DRIVELETTER%:\Windows\System32\config\SOFTWARE
reg add "HKEY_LOCAL_MACHINE\TEMPSYSTEM\ControlSet001\Services\Sophos MCS Agent" /v Start /t REG_DWORD /d 0x00000004 /f
reg add "HKEY_LOCAL_MACHINE\TEMPSYSTEM\ControlSet001\Services\Sophos Endpoint Defense\TamperProtection\Config" /v SAVEnabled /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\TEMPSYSTEM\ControlSet001\Services\Sophos Endpoint Defense\TamperProtection\Config" /v SEDEnabled /t REG_DWORD /d 0 /f
reg add "HKEY_LOCAL_MACHINE\TEMPSOFTWARE\WOW6432Node\Sophos\SAVService\TamperProtection" /v Enabled /t REG_DWORD /d 0 /f
reg unload HKLM\TEMPSYSTEM
reg unload HKLM\TEMPSOFTWARE
ECHO ===================COMPLETED===================
ECHO -----------------------------------------------
ECHO Sophos Tamper Protection disabled.
echo Press any key to reboot the PC.
ECHO -----------------------------------------------
ECHO ===========PRESS ANY KEY TO CONTINUE===========
pause > NUL
cls
shutdown -r -t 00
EXIT

:ENTP
CLS
reg load HKLM\TEMPSYSTEM %DRIVELETTER%:\Windows\System32\config\SYSTEM
reg load HKLM\TEMPSOFTWARE %DRIVELETTER%:\Windows\System32\config\SOFTWARE
reg add "HKEY_LOCAL_MACHINE\TEMPSYSTEM\ControlSet001\Services\Sophos MCS Agent" /v Start /t REG_DWORD /d 0x00000002 /f
reg add "HKEY_LOCAL_MACHINE\TEMPSYSTEM\ControlSet001\Services\Sophos Endpoint Defense\TamperProtection\Config" /v SAVEnabled /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\TEMPSYSTEM\ControlSet001\Services\Sophos Endpoint Defense\TamperProtection\Config" /v SEDEnabled /t REG_DWORD /d 1 /f
reg add "HKEY_LOCAL_MACHINE\TEMPSOFTWARE\WOW6432Node\Sophos\SAVService\TamperProtection" /v Enabled /t REG_DWORD /d 1 /f
reg unload HKLM\TEMPSYSTEM
reg unload HKLM\TEMPSOFTWARE
ECHO ===================COMPLETED===================
ECHO -----------------------------------------------
ECHO Sophos Tamper Protection enabled.
echo Press any key to reboot the PC.
ECHO -----------------------------------------------
ECHO ===========PRESS ANY KEY TO CONTINUE===========
pause > NUL
cls
shutdown -r -t 00
EXIT

:QUIT
EXIT
