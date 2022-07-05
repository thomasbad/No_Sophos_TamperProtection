# No_Sophos_TamperProtection
Disable the Tamper Protection of managed Sophos client without password to work with its services or removal

![NoSophos](https://user-images.githubusercontent.com/20796385/177294557-e7a0f74e-e05e-49d6-8fb0-a37e5ec23209.png)

As a desktop engineer, bigger company means the PC always install things with password locked, and you can't unlock it to get your work done even it is ugent, and you will feel extremely s**ks, like Sophos Endpoint/Intercept X client.


This tool is to make this pain away, you just needs to run the tool under safe mode or Win PE envoriment and it will get its' work done.
To re-enable the protection back, it would be better to have a look with the excat reg key location to see the value and amemed it youself under this location:

HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Sophos Endpoint Defense\TamperProtection\Config
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Sophos MCS Agent
HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Sophos\SavService\TamperProtection

If you convert this into exe format, Sophos may have chance to detect and remove it if your current explorer folder contain this file. So please ensure you put it inside a folder and never explore it while the Sophos client is activated if you have complie this into exe format.
