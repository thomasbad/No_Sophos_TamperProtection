# No_Sophos_TamperProtection
Disable the Tamper Protection of managed Sophos client without password to work with its services or removal

As a desktop engineer, bigger company means the PC always install things with password locked, and you can't unlock it to get your work done even it is ugent, and you will feel extremely s**ks, like Sophos Endpoint/Intercept X client.

This tool is to make this pain away, you just needs to run the tool under safe mode or Win PE envoriment and it will get its' work done.
To re-enable the protection back, it would be better to have a look with the excat reg key location to see the value and amemed it youself under this location:
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Sophos Endpoint Defense\TamperProtection\Config
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Sophos MCS Agent
HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Sophos\SavService\TamperProtection
