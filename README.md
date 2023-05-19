# Sophos Tamper Protection Control Bypasser

## What is this?
Disable the Tamper Protection of managed Sophos client without password to work with its services or removal

![NoSophos](https://user-images.githubusercontent.com/20796385/177294557-e7a0f74e-e05e-49d6-8fb0-a37e5ec23209.png)

As a desktop engineer, bigger company means the PC always install things with password locked, and you can't unlock it to get your work done even it is ugent, and you will feel extremely s**ks, like Sophos Endpoint/Intercept X client.

![image](https://github.com/thomasbad/No_Sophos_TamperProtection/assets/20796385/bfd3e184-9ff5-4d36-93ae-592471735a35)

## How to use:
Step 1. Create a WIN PE USB boot disk, whatever you like, like medicat USB or NoName XPE, boot from it

Step 2. Check what is the drive letter of the original system disk being loaded in WIN PE envoriment

Step 3. Run this tool, follow the step

Step 4. Once it reboot and enter to the login screen, login, if it not works, then shutdown and repeat from Step 1 again. It would maximum just needs to do twice.

Step 5. Done, it should be now eiter locked or unlocked, depending on your choice.

## How it works:
This tool is to make this pain away, you just needs to run the tool under safe mode or Win PE envoriment and it will get its' work done.
It actually look into the registry and do thing on:

HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Sophos Endpoint Defense\TamperProtection\Config
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Sophos MCS Agent
HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Sophos\SavService\TamperProtection

If you convert this into exe format, Sophos may have chance to detect and remove it if your current explorer folder contain this file. So please ensure you put it inside a folder and never explore it while the Sophos client is activated. Or just download this things on the computer without Sophos.

## The PowerShell version now working! It said cannot be loaded because running scripts is disabled on this system!
It is caused by the system side. Run your powershell as admin first, then run this command to remove the restriction:
`
Set-ExecutionPolicy Unrestricted
`

## BUG
No time to fix the Drive Letter vaildation check yet, just input the correct the drive letter and it will work.

The GUI version haven't been test yet, but since the code is mostly copy from CLI version, it should works fine. If it doesn't, please let me know.

If you tired to try, CLI Batch one should always works as I tested on Windows 10 and 11
