# This tool require administrator right, please allow it to start the tool correctly
# This tool needs to be run under WinPE to load the hive

if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
{  
  $arguments = "& '" +$myinvocation.mycommand.definition + "'"
  Start-Process powershell -Verb runAs -ArgumentList $arguments
  Break
}
$host.UI.RawUI.WindowTitle = "No Sophos TP"


function First-Menu {
    Clear-Host
    Write-Host @'
..............................................................................................

      88b 88  dP"Yb      .dP"Y8  dP"Yb  88""Yb 88  88  dP"Yb  .dP"Y8     888888 88""Yb 
      88Yb88 dP   Yb     `Ybo." dP   Yb 88__dP 88  88 dP   Yb `Ybo."       88   88__dP 
      88 Y88 Yb   dP     o.`Y8b Yb   dP 88"""  888888 Yb   dP o.`Y8b       88   88"""  
      88  Y8  YbodP      8bodP'  YbodP  88     88  88  YbodP  8bodP'       88   88     

..............................................................................................
......................................................................................
 Remember You Should run this as Admin under WIN PE.
 This process needs to do twice to ensure it is totally loaded by SOPHOS.
 Now Please Input the Drive Letter of the system you need to modify.
......................................................................................

'@
$DriveLetter = Read-Host -Prompt 'Please Input the Drive Letter of the system you need to modify and Press ENTER:'
Display-Menu
}

function Display-Menu {
    Clear-Host
    Write-Host @'
..............................................................................................

      88b 88  dP"Yb      .dP"Y8  dP"Yb  88""Yb 88  88  dP"Yb  .dP"Y8     888888 88""Yb 
      88Yb88 dP   Yb     `Ybo." dP   Yb 88__dP 88  88 dP   Yb `Ybo."       88   88__dP 
      88 Y88 Yb   dP     o.`Y8b Yb   dP 88"""  888888 Yb   dP o.`Y8b       88   88"""  
      88  Y8  YbodP      8bodP'  YbodP  88     88  88  YbodP  8bodP'       88   88     

..............................................................................................
......................................................................................
 PRESS 1 or 2 to select your task, or q to EXIT.
 Please ensure the tool is run under WIN PE or safe mode with admin right to work.
......................................................................................

Press 1 - Disable Sophos InterX tamper protection
Press 2 - Enable Sophos InterX tamper protection
Press 0 - Exit the tool
'@
Choice-Forward
}

function Choice-Forward {
$Choice = Read-Host -Prompt 'Input your selection'
switch -Exact ($Choice)
{
    '1' {
        Clear-Host
        DISTP
        '===================COMPLETED==================='
        '-----------------------------------------------'
        '        Sophos Tamper Protection disabled      '
        '     Please reboot the PC to apply the change  '
        '-----------------------------------------------'
        '=============PRESS ANY KEY TO EXIT============='
        Read-Host
        Exit
        }
    '2' {

        ENTP
        '===================COMPLETED==================='
        '-----------------------------------------------'
        '        Sophos Tamper Protection enabled      '
        '     Please reboot the PC to apply the change  '
        '-----------------------------------------------'
        '=============PRESS ANY KEY TO EXIT============='
        Read-Host
        Exit
        }
    '0' {
        Exit
        }
    default {  
        Write-Warning '============INVALID INPUT============'
        Write-Warning '-------------------------------------'
        Write-Warning 'Please select a number from the Main'
        Write-Warning 'Menu [1 or 2], or select [0] to quit.'
        Write-Warning '-------------------------------------'
        Write-Warning '======PRESS ANY KEY TO CONTINUE======'
        Read-Host
        Clear-host
        Display-Menu
        }
    }
}

$InputPath = Test-Path ${DriveLetter}:\Windows\System32\config

function DISTP {
    Clear-Host
    if ($InputPath -eq $false){
        Clear-Host
        Write-Warning '---------Invaild Drive, no config file have been found, please ensure this is the system drive-------------'
        Read-Host
        First-Menu
        }else{
            REG LOAD HKLM\TEMPSYSTEM "${DriveLetter}:\Windows\System32\config\SYSTEM"
            REG LOAD HKLM\TEMPSOFTWARE "${DriveLetter}:\Windows\System32\config\SOFTWARE"
            New-ItemProperty -Path "HKLM:\TEMPSYSTEM\ControlSet001\Services\Sophos MCS Agent" -Name Start -PropertyType DWord -Value "4" -Force
            New-ItemProperty -Path "HKLM:\TEMPSYSTEM\ControlSet001\Services\Sophos Endpoint Defense\TamperProtection\Config" -Name SAVEnabled -PropertyType DWord -Value "0" -Force
            New-ItemProperty -Path "HKLM:\TEMPSYSTEM\ControlSet001\Services\Sophos Endpoint Defense\TamperProtection\Config" -Name SEDEnabled -PropertyType DWord -Value "0" -Force
            New-ItemProperty -Path "HKLM:\TEMPSOFTWARE\WOW6432Node\Sophos\SAVService\TamperProtection" -Name Enabled -PropertyType DWord -Value "0" -Force
            REG UNLOAD HKLM\TEMPSYSTEM
            REG UNLOAD HKLM\TEMPSOFTWARE
        }
    Clear-Host
    Write-Host @'
===================COMPLETED===================
-----------------------------------------------
       Sophos Tamper Protection disabled.
        Press any key to reboot the PC.
-----------------------------------------------
===========PRESS ANY KEY TO CONTINUE===========
'@
    Read-Host
    Exit
}

function ENTP {
    Clear-Host
    if ($InputPath -eq $false){
        Clear-Host
        Write-Warning '---------Invaild Drive, no config file have been found, please ensure this is the system drive-------------'
        Read-Host
        First-Menu
        }else{
            REG LOAD HKLM\TEMPSYSTEM "${DriveLetter}:\Windows\System32\config\SYSTEM"
            REG LOAD HKLM\TEMPSOFTWARE "${DriveLetter}:\Windows\System32\config\SOFTWARE"
            New-ItemProperty -Path "HKLM:\TEMPSYSTEM\ControlSet001\Services\Sophos MCS Agent" -Name Start -PropertyType DWord -Value "2" -Force
            New-ItemProperty -Path "HKLM:\TEMPSYSTEM\ControlSet001\Services\Sophos Endpoint Defense\TamperProtection\Config" -Name SAVEnabled -PropertyType DWord -Value "1" -Force
            New-ItemProperty -Path "HKLM:\TEMPSYSTEM\ControlSet001\Services\Sophos Endpoint Defense\TamperProtection\Config" -Name SEDEnabled -PropertyType DWord -Value "1" -Force
            New-ItemProperty -Path "HKLM:\TEMPSOFTWARE\WOW6432Node\Sophos\SAVService\TamperProtection" -Name Enabled -PropertyType DWord -Value "1" -Force
            REG UNLOAD HKLM\TEMPSYSTEM
            REG UNLOAD HKLM\TEMPSOFTWARE
        }
    Clear-Host
    Write-Host @'
===================COMPLETED===================
-----------------------------------------------
        Sophos Tamper Protection enabled.
         Press any key to reboot the PC.
-----------------------------------------------
===========PRESS ANY KEY TO CONTINUE===========
'@
    Read-Host
    Exit
}

First-Menu
