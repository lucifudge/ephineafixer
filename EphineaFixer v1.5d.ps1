# EphineaFixer by lucifudge
# v1.5d 03/03/2022
$host.UI.RawUI.BackgroundColor = "DarkMagenta"
$host.UI.RawUI.ForegroundColor = "Green"
"
EphineaFixer v1.5d for Windows 10"
$host.UI.RawUI.ForegroundColor = "Yellow"

"                                                  


                                          @@                                    
                                        @,,,*@*                                 
                     .@&               @**,,,,@@                                
                   @@,,,@@,           @@(*,,,,.@                                
                   @@,,,,,.@/          %@(*,,,.@                                
                   @@*,,,.*@(           @@**,,@@                                
                    @@/,,,,@@           @@**,@@                                 
                      @@/**,.@@    @@@@@@&/**@                                  
                        @@/***@@@,,,,,***/****@@@                               
                          @@&/*****,,,,**(/******,@@  KOI Koi! 
                         @@****(*****,******,,,,,,,*@@                          
                        @@/********,,,,,,,,,,,,   .*,*@@                        
                       @@/**,**,,,,,,,,,,,,,,        ***@@                      
                      /@/**,     ,,,,,,,,***     ((# ,*@@@@@@@@                 
                      @@(/../&&&%  *****,****  (%     *@@ @/&%%@@@              
                     /@(//*.&&&&&%# ***#//****  .   ,**@@@*,,******@@@          
                     @@@@@/,./*(*/. **@##/##(**********@@/****/*/***,**@&       
                         @@(/,.. *****%##((,(*******/*******/(((((/**@@         
                          @@#/(///****///************@*///////(///*/@@@         
                           @@(#((*//////////*********(((((#%%@@@@@@@            
                            @/@@@(***/*/**,,,,,,*****(((//@@@                   
                              @@/**////,...    . ..,*//(**@.                    
                            @@*****#//,...         .,,*((*@@                    
                         @@,,,,,**##(/,..           ...///@@                    
                      @@@,,,,****/%#(*,......        ...,@@                     
                     @@&#%,,,****(##/*,....        ....,@@                      
                      @@@//****//@@&(**,,.........,,*.%@  /                     
                        @@/**/((@@  @@@@*///.@@@@@@@@&@@@@@@                    
                         @@**@@         @@%&@      @@@@&@@@                     
                           @@            @&&@@       @@@@                       
                                        @@&%%@@                                 
                                       @###/((,@@   
"
# minimize powershell windows when they open (may cause console errors)
$t = '[DllImport("user32.dll")] public static extern bool ShowWindow(int handle, int state);'
add-type -name win -member $t -namespace native
[native.win]::ShowWindow(([System.Diagnostics.Process]::GetCurrentProcess() | Get-Process).MainWindowHandle, 0)


# launch another instance of powershell with elevated permissions
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }


# suppress errors in powershell console, necessary for os usernames with unicode chars due to admin relaunch snippet
$ErrorActionPreference = 'silentlycontinue'

# Change color back to DarkMagenta to mask any verbose text going forward
$host.UI.RawUI.ForegroundColor = "DarkMagenta"



################################################################################
# Add any registry keys and folders that don't exist (defaults sourced from install.reg)
# Used to fix portable installs or if game was installed by a different Windows user 
################################################################################

### check if default folders for keys exist, if they don't then save a variable to show message box at end
###  also if they dont exist make the folder
if(-NOT (Test-Path -LiteralPath "HKCU:\Software\SonicTeam")){ $wefixedsomething="1" };
if((Test-Path -LiteralPath "HKCU:\Software\SonicTeam") -ne $true) {  New-Item "HKCU:\Software\SonicTeam" -force -ea SilentlyContinue };

if(-NOT (Test-Path -LiteralPath "HKCU:\Software\SonicTeam\PSOBB")){ $wefixedsomething="1" };
if((Test-Path -LiteralPath "HKCU:\Software\SonicTeam\PSOBB") -ne $true) {  New-Item "HKCU:\Software\SonicTeam\PSOBB" -force -ea SilentlyContinue };

if(-NOT (Test-Path -LiteralPath "HKCU:\Software\SonicTeam\PSOBB\Ephinea")){ $wefixedsomething="1" };
if((Test-Path -LiteralPath "HKCU:\Software\SonicTeam\PSOBB\Ephinea") -ne $true) {  New-Item "HKCU:\Software\SonicTeam\PSOBB\Ephinea" -force -ea SilentlyContinue };

# [HKEY_CURRENT_USER\Software\SonicTeam\PSOBB] 
New-ItemProperty -LiteralPath 'HKCU:\Software\SonicTeam\PSOBB' -Name 'CTRLBUF' -Value ([byte[]](0x02,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x01,0x00,0x00,0x00)) -PropertyType Binary  -ea SilentlyContinue;

New-ItemProperty -LiteralPath 'HKCU:\Software\SonicTeam\PSOBB' -Name 'GRAPHICCTRL' -Value ([byte[]](0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00)) -PropertyType Binary  -ea SilentlyContinue;

New-ItemProperty -LiteralPath 'HKCU:\Software\SonicTeam\PSOBB' -Name 'SOUNDCTRL' -Value ([byte[]](0x01,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x01,0x00,0x00,0x00)) -PropertyType Binary  -ea SilentlyContinue;

New-ItemProperty -LiteralPath 'HKCU:\Software\SonicTeam\PSOBB' -Name 'FONT_JPN' -Value "Tahoma" -PropertyType String  -ea SilentlyContinue;

New-ItemProperty -LiteralPath 'HKCU:\Software\SonicTeam\PSOBB' -Name 'ACCOUNT_CHECK' -Value 0 -PropertyType DWord  -ea SilentlyContinue;

New-ItemProperty -LiteralPath 'HKCU:\Software\SonicTeam\PSOBB' -Name 'WINDOW_MODE' -Value 1 -PropertyType DWord  -ea SilentlyContinue;

New-ItemProperty -LiteralPath 'HKCU:\Software\SonicTeam\PSOBB' -Name 'FOCUS_SOUND' -Value 1 -PropertyType DWord  -ea SilentlyContinue;

New-ItemProperty -LiteralPath 'HKCU:\Software\SonicTeam\PSOBB' -Name 'WORD_WRAP' -Value 1 -PropertyType DWord  -ea SilentlyContinue;

New-ItemProperty -LiteralPath 'HKCU:\Software\SonicTeam\PSOBB' -Name 'ACCOUNT' -Value "" -PropertyType String  -ea SilentlyContinue;

New-ItemProperty -LiteralPath 'HKCU:\Software\SonicTeam\PSOBB' -Name 'PASSWORD' -Value "" -PropertyType String  -ea SilentlyContinue;

New-ItemProperty -LiteralPath 'HKCU:\Software\SonicTeam\PSOBB' -Name 'INSTALL' -Value 1 -PropertyType DWord  -ea SilentlyContinue;

New-ItemProperty -LiteralPath 'HKCU:\Software\SonicTeam\PSOBB' -Name 'CLIENT_CODE' -Value 14 -PropertyType DWord  -ea SilentlyContinue;

New-ItemProperty -LiteralPath 'HKCU:\Software\SonicTeam\PSOBB' -Name 'BILLING_SITE' -Value "https://ephinea.pioneer2.net" -PropertyType String  -ea SilentlyContinue;

New-ItemProperty -LiteralPath 'HKCU:\Software\SonicTeam\PSOBB' -Name 'OldCheck' -Value 1 -PropertyType DWord  -ea SilentlyContinue;

New-ItemProperty -LiteralPath 'HKCU:\Software\SonicTeam\PSOBB' -Name 'EXT0' -Value 2 -PropertyType DWord  -ea SilentlyContinue;

New-ItemProperty -LiteralPath 'HKCU:\Software\SonicTeam\PSOBB' -Name 'OFFICIAL_SITE' -Value "https://ephinea.pioneer2.net" -PropertyType String  -ea SilentlyContinue;

New-ItemProperty -LiteralPath 'HKCU:\Software\SonicTeam\PSOBB' -Name 'ACCOUNT_CTRL' -Value ([byte[]](0x3d,0xaa,0xd0,0x6e,0xae,0x64,0xcd,0x48)) -PropertyType Binary  -ea SilentlyContinue;

New-ItemProperty -LiteralPath 'HKCU:\Software\SonicTeam\PSOBB\Ephinea' -Name 'CLASSIC_FULLSCREEN' -Value 0 -PropertyType DWord  -ea SilentlyContinue;

# [HKEY_CURRENT_USER\Software\SonicTeam\PSOBB\Ephinea]

New-ItemProperty -LiteralPath 'HKCU:\Software\SonicTeam\PSOBB\Ephinea' -Name 'CLASSIC_FULLSCREEN' -Value 0 -PropertyType DWord  -ea SilentlyContinue;

New-ItemProperty -LiteralPath 'HKCU:\Software\SonicTeam\PSOBB\Ephinea' -Name 'IME' -Value 0 -PropertyType DWord  -ea SilentlyContinue;

New-ItemProperty -LiteralPath 'HKCU:\Software\SonicTeam\PSOBB\Ephinea' -Name 'CHARACTER_BANK' -Value 0 -PropertyType DWord  -ea SilentlyContinue;


#show message box if any missing default registry folders got restored
If ($wefixedsomething -eq 1){
Add-Type -AssemblyName System.Windows.Forms
    $return = [System.Windows.Forms.Messagebox]::Show("Found and repaired missing PSO`r`nregistry keys with default values.")}
########################################################################


########################################################################
# get screen saver time in seconds
$screensaverinseconds = Get-Wmiobject win32_desktop | where name -match $env:USERNAME

# check if screensaver is on
$ssonoroff = $screensaverinseconds.ScreenSaverActive

# set variable $ssmin to minutes (converted from seconds above)
$ssmin = $screensaverinseconds.ScreenSaverTimeout / 60

# if screensaver is on and set for less than 15 mins, show a warning and add variable for clipboard log
if ($ssonoroff -eq $true -and $ssmin -lt 15 ) {
Add-Type -AssemblyName System.Windows.Forms
    $return = [System.Windows.Forms.Messagebox]::Show("Your Windows screensaver is set to trigger at $ssmin minutes of being idle.`r`n`r`nWhen screensaver appears, PSO will crash with a Direct3D error.`r`n`r`nConsider disabling the screensaver or raising the time if it is too low.")	
	}
if ($ssonoroff -eq $true) {
$ssclipboard = "Windows screensaver is set to $ssmin minutes"
	} elseif ($ssonoroff -eq $false) {
$ssclipboard = "Windows screensaver is off"
	}

########################################################################


# check for layers key, create it if it doesn't exist. don't use force, it overwrites. required to save DEP strings or nothing happens.
if (!(test-path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers')){
New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers'
}

# assign the state of uac dimming to $uacdim
if (test-path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System) {
$uacdim = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System") | Select-Object -ExpandProperty PromptOnSecureDesktop Version}
	

# check for existence of install path in registry, save as $psopath and enable some buttons if exists
if (test-path HKLM:\Software\WOW6432Node\EphineaPSO) {
	$psopath = (Get-ItemProperty "HKLM:\Software\WOW6432Node\EphineaPSO") | Select-Object -ExpandProperty Install_Dir Version
        $yesbuttonon = $true 
		$disablerefreshs = $false
		    $appwizpath = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"    
}
ElseIf (test-path HKLM:\SOFTWARE\EphineaPSO) {
	$psopath = (Get-ItemProperty "HKLM:\SOFTWARE\EphineaPSO") | Select-Object -ExpandProperty Install_Dir Version
       $yesbuttonon = $true
	   $appwizpath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*"  
	   $disablerefreshs = $false
}
else {
    $psopath = "Cannot find EphineaPSO folder."
    $yesbuttonon = $false
    $manualmode = $true
	$autowloff = $true
	$disablerefreshs = $true
	}{}

####################### WINDOW MODE AND CLASSIC FULLSCREEN ########################

### on startup, check if window mode is on (1), as it causes crashing if on and alt tabbing
if (test-path HKCU:\Software\SonicTeam\PSOBB) {$windowmode = (Get-ItemProperty "HKCU:\Software\SonicTeam\PSOBB") | Select-Object -ExpandProperty WINDOW_MODE }
### on startup, check if classic_fullscreen is on (1), as it causes crashing if on and alt tabbing
if (test-path HKCU:\Software\SonicTeam\PSOBB\Ephinea) {$classicfullscreen = (Get-ItemProperty "HKCU:\Software\SonicTeam\PSOBB\Ephinea") | Select-Object -ExpandProperty CLASSIC_FULLSCREEN }

### ask user to turn off windowed and classic full screen if both are on
if ($windowmode -eq 1 -and $classicfullscreen -eq 1){
$wmcf = new-object -comobject wscript.shell
$windowmodequestion1 = $wmcf.popup("Window Mode and Classic Fullscreen are activated in your PSO settings, which will cause crashing when switching windows or using ALT+TAB. We recommend turning these off, which will enable fullscreen borderless windowed mode.`r`n`r`n(If you want to play windowed, just use 'Window Mode' by itself)`r`n`r`nTurn them both off? (Enables Borderless Windowed)", `
0,"Display Warning",4)} 
		# if you answer yes
              If ($windowmodequestion1 -eq 6) {
              # close ephinea launcher and force change registry value to disable both
$killephinealauncher = Get-Process online
$killephinealauncher | Stop-Process -Force
$killephinealauncher | Wait-Process
        New-ItemProperty -Path HKCU:\Software\SonicTeam\PSOBB -Name WINDOW_MODE -Value 00000000 -force 
  		New-ItemProperty -Path HKCU:\Software\SonicTeam\PSOBB\Ephinea -Name CLASSIC_FULLSCREEN -Value 00000000 -force  }    
              # if you answer no, do nothing
     else {} 

### ask user to turn off classic full screen if it is on but windowed is off
if ($windowmode -eq 0 -and $classicfullscreen -eq 1){
$wmcf = new-object -comobject wscript.shell
$windowmodequestion2 = $wmcf.popup("Classic Fullscreen is activated in your PSO settings, which will cause crashing when switching windows or using ALT+TAB. We recommend turning this off, which will enable fullscreen borderless windowed mode.`r`n`r`nTurn this off? (Enables Borderless Windowed)", `
0,"Display Warning",4)} 
		# if you answer yes
              If ($windowmodequestion2 -eq 6) {
              # close ephinea launcher and force change registry value to disable both
$killephinealauncher = Get-Process online
$killephinealauncher | Stop-Process -Force
$killephinealauncher | Wait-Process
        New-ItemProperty -Path HKCU:\Software\SonicTeam\PSOBB\Ephinea -Name CLASSIC_FULLSCREEN -Value 00000000 -force  }    
              # if you answer no, do nothing
     else {} 


### if adv effect and classic fullscreen are both on, tell the user they are not compatible
if (test-path HKCU:\Software\SonicTeam\PSOBB\Ephinea) {$classicfullscreen = (Get-ItemProperty "HKCU:\Software\SonicTeam\PSOBB\Ephinea") | Select-Object -ExpandProperty CLASSIC_FULLSCREEN }
$advregvalue = (Get-ItemProperty "HKCU:\Software\SonicTeam\PSOBB").GRAPHICCTRL

if ($advregvalue[4] -eq 1 -and $classicfullscreen -eq 1){
	#show message box warning user they aren't compatible
	Add-Type -AssemblyName System.Windows.Forms
    $advconflict = [System.Windows.Forms.Messagebox]::Show("Detected Advanced effect and Classic Fullscreen are both on.`r`nThese are incompatible together and will cause game`r`nbreaking issues.`r`n`r`nClassic Fullscreen will now be disabled.")
	$killephinealauncher = Get-Process online
$killephinealauncher | Stop-Process -Force
$killephinealauncher | Wait-Process
New-ItemProperty -Path HKCU:\Software\SonicTeam\PSOBB\Ephinea -Name CLASSIC_FULLSCREEN -Value 00000000 -force
} 
else {}






########################## IME ###############################
### on startup, check if IME is on (1), as it can cause issues typing and the user may not need it
if (test-path HKCU:\Software\SonicTeam\PSOBB\Ephinea) {$imegamestatus = (Get-ItemProperty "HKCU:\Software\SonicTeam\PSOBB\Ephinea") | Select-Object -ExpandProperty IME }
### check if microsoft IME folder is present 
if (test-path "C:\users\$env:username\appdata\roaming\microsoft\ime") {
	$microsoftimestatus = $true
}
else {
        $microsoftimestatus = $false
}
### check if google IME folder is present
if (test-path "C:\Program Files (x86)\Google\Google Japanese Input") {
	$googleimestatus = $true
}
else {
        $googleimestatus = $false
}
### if IME is enabled in online.exe, check to see if microsoft IME folder present in one or both folders (microsoft or google) and if it isn't then tell them they might not need IME on
if (
  ($imegamestatus -eq 1) -and (
    ($microsoftimestatus -eq 1) -or ($googleimestatus -eq 1)
  )) {
$wmcf = new-object -comobject wscript.shell
$imequestion1 = $wmcf.popup("IME is enabled in Ephinea's Additional Options,`r`nbut I do not detect the presence of an IME on`r`nyour system. IME is only required if typing with`r`nEast Asian characters in-game. Leaving this`r`non will result in not being able to type`r`nEnglish (Latin Alphabet) characters.`r`n`r`nDisable IME in Ephinea? (Recommended)", `
0,"IME Warning",4)} 
		# if you answer yes
              If ($imequestion1 -eq 6) {
              # close ephinea launcher and force change registry value to disable ime
$killephinealauncher = Get-Process online
$killephinealauncher | Stop-Process -Force
$killephinealauncher | Wait-Process
        New-ItemProperty -Path HKCU:\Software\SonicTeam\PSOBB\Ephinea -Name IME -Value 00000000 -force  }    
              # if you answer no, do nothing
     else {} 



########################## UAC ###############################

### on startup, check lets store some variables to determine UAC settings
# tip: if $uacdimstartupcheckvalue1 PromptOnSecureDesktop's dword is 00000001 then dimming is on. if 00000000 dimming is off..
# HOWEVER, dimming will ALWAYS be on if $uacdimstartupcheckvalue2's ConsentPromptBehaviorAdmin dword is 00000002 because this means the uac slider is maxed out [ex: (always notify me when: ...)], so this value trumps PromptOnSecureDesktop's dword
$uacdimstartupcheckvalue1 = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System") | Select-Object -ExpandProperty PromptOnSecureDesktop

# tip: if ConsentPromptBehaviorAdmin's dword is 00000002 then UAC is set to maximum setting, thus dimming will ALWAYS be on regardless of PromptOnSecureDesktop's dword. if set to 00000005 then UAC would be on default or lower.
$uacdimstartupcheckvalue2 = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System") | Select-Object -ExpandProperty ConsentPromptBehaviorAdmin


### on startup, check if uac slider is maxed and pop up a message box if it is..
if ($uacdimstartupcheckvalue2 -eq 2){

$a = new-object -comobject wscript.shell
$startupdimquestion1 = $a.popup("This Windows setting makes the screen dim slightly`r`nwhen opening certain programs, which will crash PSO`r`nwith a Direct3D device error. In order to disable`r`ndimming, we will need to change UAC to notify`r`nyou only when apps try to make changes to your`r`ncomputer (this is the default setting).`r`n`r`nWould you like to disable UAC dimming?", `
0,"WARNING: UAC set to Always Notify",4)} 
			# if you answer yes
              If ($startupdimquestion1 -eq 6) {
              # force change registry value to disable dimming
              New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 00000005 -force 
				New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name PromptOnSecureDesktop -Value 00000000 -force 
			  			  $a.popup("Screen dimming disabled." , `
              0,"WARNING: UAC set to Always Notify",0) }
              
              # if you answer no, do nothing
              else {} 

### on startup, check if uac dimming value set to default (but also make sure UAC isn't on MAX to avoid redundant message boxes from startupdimquestion1) and pop up a message box if it is..
if ($uacdimstartupcheckvalue1 -eq 1 -and $uacdimstartupcheckvalue2 -notin 2, 0){

$a = new-object -comobject wscript.shell
$startupdimquestion2 = $a.popup("This Windows setting makes the screen dim slightly`r`nwhen opening certain programs, which will crash PSO`r`nwith a Direct3D device error. This dimming can be safely `r`ndisabled without any impact on your computer`'s security,`r`nas no other UAC settings will be changed.`r`n`r`nWould you like to disable UAC dimming?", `
0,"WARNING: Default UAC Detected",4)} 
			# if you answer yes
              If ($startupdimquestion2 -eq 6) {
              # force change registry value to disable dimming
              New-ItemProperty -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name PromptOnSecureDesktop -Value 00000000 -force 
			  			  $a.popup("Screen dimming disabled." , `
              0,"WARNING: Default UAC Detected",0) }
              
              # if you answer no, do nothing
              else {} 


####################### FORM GUI ########################


Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()
# form menu gui
$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = '640,428'
$Form.text                       = "EphineaFixer v1.5d for Windows 10"
$Form.BackColor                  = "#ffffff"
$Form.TopMost                    = $false
$Form.FormBorderStyle 	    	 = 'Fixed3D'
$Form.MaximizeBox 		         = $false
$Form.StartPosition = 'CenterScreen'

# whitelist button gui
$yes                             = New-Object system.Windows.Forms.Button
$yes.BackColor                   = "#c45454"
$yes.text                        = "AUTO
WHITELIST"
$yes.width                       = 140
$yes.height                      = 58
$yes.visible                     = $yesbuttonon
$yes.location                    = New-Object System.Drawing.Point(35,110)
$yes.Font                        = 'Courier New,13'
$yes.ForeColor                   = "#ffffff"
$yes.Add_MouseHover({ yesmousehover })
$yes.Add_MouseLeave({ yesmouseleave })
function yesmousehover { $yes.BackColor = "#292d33" }
function yesmouseleave { $yes.BackColor = "#c45454" }
$whitelisttooltip                = New-Object system.Windows.Forms.ToolTip
$whitelisttooltip.ToolTipTitle   = ""
$whitelisttooltip.SetToolTip($yes,'Automatically whitelist PSO in Windows Defender and DEP')
$Form.controls.AddRange(@($yes))

# whitelist disabled button gui
$wldisabled                      = New-Object system.Windows.Forms.Button
$wldisabled.BackColor            = "#c0c0c0"
$wldisabled.text                 = "AUTO
WHITELIST
(disabled)"
$wldisabled.width                = 140
$wldisabled.height               = 58
$wldisabled.visible              = $autowloff
$wldisabled.location             = New-Object System.Drawing.Point(35,110)
$wldisabled.Font                 = 'Courier New,11'
$wldisabled.ForeColor            = "#ffffff"
$whitelisttooltip2                = New-Object system.Windows.Forms.ToolTip
$whitelisttooltip2.ToolTipTitle   = ""
$whitelisttooltip2.SetToolTip($wldisabled,'Unable to locate PSO directory, please use MANUAL WHITELIST.')
$Form.controls.AddRange(@($wldisabled))

# manual mode button gui
$no                              = New-Object system.Windows.Forms.Button
$no.BackColor                    = "#c45454"
$no.text                         = "MANUAL 
WHITELIST"
$no.width                        = 140
$no.height                       = 58
$no.location                     = New-Object System.Drawing.Point(35,181)
$no.Font                         = 'Courier New,13'
$no.ForeColor                    = "#ffffff"
$no.Add_MouseHover({ manualmousehover })
$no.Add_MouseLeave({ manualmouseleave })
function manualmousehover { $no.BackColor = "#292d33" }
function manualmouseleave { $no.BackColor = "#c45454" }
$manualtooltip                = New-Object system.Windows.Forms.ToolTip
$manualtooltip.ToolTipTitle   = ""
$manualtooltip.SetToolTip($no,'Manually select PSO folder (instead of using AUTO WHITELIST)')
$Form.controls.AddRange(@($no))


# exclusions/blocked paths button gui
$blockedpaths                              = New-Object system.Windows.Forms.Button
$blockedpaths.BackColor                    = "#c45454"
$blockedpaths.text                         = "VIEW
EXCLUSIONS"
$blockedpaths.width                        = 140
$blockedpaths.height                       = 58
$blockedpaths.location                     = New-Object System.Drawing.Point(35,252)
$blockedpaths.Font                         = 'Courier New,13'
$blockedpaths.ForeColor                    = "#ffffff"
$blockedpaths.Add_MouseHover({ blockedpathsmousehover })
$blockedpaths.Add_MouseLeave({ blockedpathsmouseleave })
function blockedpathsmousehover { $blockedpaths.BackColor = "#292d33" }
function blockedpathsMouseLeave { $blockedpaths.BackColor = "#c45454" }
$exclusionstooltip            = New-Object system.Windows.Forms.ToolTip
$exclusionstooltip.ToolTipTitle   = ""
$exclusionstooltip.SetToolTip($blockedpaths,'View existing DEP and Defender exclusions.')
$Form.controls.AddRange(@($blockedpaths))

# exclusions REFRESH button gui
$backbutton                            = New-Object system.Windows.Forms.Button
$backbutton.BackColor                  = "#c45454"
$backbutton.text                       = "REFRESH"
$backbutton.width                      = 90
$backbutton.height                     = 25
$backbutton.visible                    = $true
$backbutton.location                   = New-Object System.Drawing.Point(205,380)
$backbutton.Font                       = 'Courier New,13'
$backbutton.ForeColor                  = "#ffffff"
$backbutton.visible = $false
$backbutton.Add_MouseHover({ backbuttonmousehover })
$backbutton.Add_MouseLeave({ backbuttonmouseleave })
function backbuttonmousehover { $backbutton.BackColor = "#292d33" }
function backbuttonMouseLeave { $backbutton.BackColor = "#c45454" }
$refreshbuttontooltip            = New-Object system.Windows.Forms.ToolTip
$refreshbuttontooltip.ToolTipTitle   = ""
$refreshbuttontooltip.SetToolTip($backbutton,'Refresh existing DEP and Defender exclusions.')
$Form.controls.AddRange(@($backbutton))

# exclusions COPY button gui
$copytoclipboardbutton                            = New-Object system.Windows.Forms.Button
$copytoclipboardbutton.BackColor                  = "#c45454"
$copytoclipboardbutton.text                       = "Copy Diagnostics To Clipboard"
$copytoclipboardbutton.width                      = 260
$copytoclipboardbutton.height                     = 25
$copytoclipboardbutton.visible                    = $true
$copytoclipboardbutton.location                   = New-Object System.Drawing.Point(355,380)
$copytoclipboardbutton.Font                       = 'Courier New,10'
$copytoclipboardbutton.ForeColor                  = "#ffffff"
$copytoclipboardbutton.visible = $false
$copytoclipboardbutton.Add_MouseHover({ copytoclipboardbuttonmousehover })
$copytoclipboardbutton.Add_MouseLeave({ copytoclipboardbuttonmouseleave })
function copytoclipboardbuttonmousehover { $copytoclipboardbutton.BackColor = "#292d33" }
function copytoclipboardbuttonMouseLeave { $copytoclipboardbutton.BackColor = "#c45454" }
$clipboardtooltip            = New-Object system.Windows.Forms.ToolTip
$clipboardtooltip.ToolTipTitle   = ""
$clipboardtooltip.SetToolTip($copytoclipboardbutton,'Copy exclusions and other settings to clipboard.')
$Form.controls.AddRange(@($copytoclipboardbutton))

# exclusions question mark ? assist button gui
$assistbutton                            = New-Object system.Windows.Forms.Button
$assistbutton.BackColor                  = "#c45454"
$assistbutton.text                       = "s"
$assistbutton.width                      = 25
$assistbutton.height                     = 25
$assistbutton.visible                    = $false
$assistbutton.location                   = New-Object System.Drawing.Point(304,110)
$assistbutton.Font                       = 'Webdings,13'
$assistbutton.ForeColor                  = "#ffffff"
$assistbutton.visible = $false
$assistbutton.Add_MouseHover({ assistbuttonmousehover })
$assistbutton.Add_MouseLeave({ assistbuttonmouseleave })
function assistbuttonmousehover { $assistbutton.BackColor = "#292d33" }
function assistbuttonMouseLeave { $assistbutton.BackColor = "#c45454" }
$assistbuttontooltip            = New-Object system.Windows.Forms.ToolTip
$assistbuttontooltip.ToolTipTitle   = ""
$assistbuttontooltip.SetToolTip($assistbutton,'Opens Help window.')
$Form.controls.AddRange(@($assistbutton))

# help button gui
$help                            = New-Object system.Windows.Forms.Button
$help.BackColor                  = "#c45454"
$help.text                       = "GITHUB"
$help.width                      = 140
$help.height                     = 58
$help.visible                    = $true
$help.location                   = New-Object System.Drawing.Point(35,322)
$help.Font                       = 'Courier New,13'
$help.ForeColor                  = "#ffffff"
$help.Add_MouseHover({ helpmousehover })
$help.Add_MouseLeave({ helpmouseleave })
function helpmousehover { $help.BackColor = "#292d33" }
function helpMouseLeave { $help.BackColor = "#c45454" }
$helptooltip            = New-Object system.Windows.Forms.ToolTip
$helptooltip.ToolTipTitle   = ""
$helptooltip.SetToolTip($help,'Opens web browser to EphineaFixer github.')
$Form.controls.AddRange(@($help))

# red text of whether or not install path was found in registry
$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "$psopath"
$Label1.AutoSize                 = $false
$Label1.width                    = 370
$Label1.height                   = 65
$Label1.location                 = New-Object System.Drawing.Point(205,114)
$Label1.Font                     = 'Microsoft Sans Serif,10,style=bold'
$Label1.ForeColor                = "#ff0000"

# black text of game path found automatically
$Label2                          = New-Object system.Windows.Forms.Label
$Label2.text                     = "Game path found! 

Press 'AUTO WHITELIST' to exclude in 
Windows Defender and DEP."
$Label2.AutoSize                 = $true
$Label2.width                    = 65
$Label2.height                   = 10
$Label2.visible                  = $yesbuttonon
$Label2.location                 = New-Object System.Drawing.Point(205,200)
$Label2.Font                     = 'Microsoft Sans Serif,12,style=Bold'

# safety disclaimer (on when game path found)
$safedisclaimer                          = New-Object system.Windows.Forms.Label
$safedisclaimer.text                     = "
             Note: 
              You may safely whitelist multiple times, 
               no duplicate exclusions will be created."
$safedisclaimer.AutoSize                 = $true
$safedisclaimer.width                    = 65
$safedisclaimer.height                   = 10
$safedisclaimer.visible                  = $yesbuttonon
$safedisclaimer.location                 = New-Object System.Drawing.Point(205,310)
$safedisclaimer.Font                     = 'Microsoft Sans Serif,10,style=Italic'

# safety disclaimer (on when game path not found)
$safedisclaimer2                          = New-Object system.Windows.Forms.Label
$safedisclaimer2.text                     = "
             Note: 
              You may safely whitelist multiple times, 
               no duplicate exclusions will be created."
$safedisclaimer2.AutoSize                 = $true
$safedisclaimer2.width                    = 65
$safedisclaimer2.height                   = 10
$safedisclaimer2.visible                  = $manualmode
$safedisclaimer2.location                 = New-Object System.Drawing.Point(205,310)
$safedisclaimer2.Font                     = 'Microsoft Sans Serif,10,style=Italic'

# black text of game path not found automatically
$Label3                          = New-Object system.Windows.Forms.Label
$Label3.text                     = "Unable to locate game directory.
Use MANUAL WHITELIST to locate EphineaPSO install."
$Label3.AutoSize                 = $true
$Label3.width                    = 25
$Label3.height                   = 10
$Label3.visible                  = $manualmode
$Label3.location                 = New-Object System.Drawing.Point(205,185)
$Label3.Font                     = 'Microsoft Sans Serif,10,style=Bold'



# header (ephinea)
$header                          = New-Object system.Windows.Forms.Label
$header.text                     = "EphineaFixer"
$header.AutoSize                 = $true
$header.width                    = 25
$header.height                   = 5
$header.location                 = New-Object System.Drawing.Point(120,3)
$header.Font                     = 'Microsoft JhengHei UI,33'
$header.ForeColor				 = "#4c4a48"
$header.BackColor 				 = [System.Drawing.Color]::Transparent

# header2 (pso whitelister)
$header2                          = New-Object system.Windows.Forms.Label
$header2.text                     = "Settings Repair and Whitelist Tool"
$header2.AutoSize                 = $true
$header2.width                    = 25
$header2.height                   = 10
$header2.location                 = New-Object System.Drawing.Point(127,64)
$header2.Font                     = 'Verdana,13,style=Italic'
$header2.ForeColor				  = "#c65452"
$header2.BackColor 				  = [System.Drawing.Color]::Transparent

# graybarbottom (ephineapso whitelister footer)
$graybarbottom                   = New-Object system.Windows.Forms.Label
$graybarbottom.ForeColor         = "#7f7f7f"
$graybarbottom.text              = "EphineaFixer v1.5d"
$graybarbottom.BackColor         = "#292d33"
$graybarbottom.width             = 648
$graybarbottom.height            = 20
$graybarbottom.location          = New-Object System.Drawing.Point(0,410)
$graybarbottom.Font              = 'Calibri,8'

# EXCLUSIONS header above tables
$exclusionzheader                          = New-Object system.Windows.Forms.Label
$exclusionzheader.text                     = "Exclusions"
$exclusionzheader.AutoSize                 = $true
$exclusionzheader.width                    = 888
$exclusionzheader.height                   = 888
$exclusionzheader.visible                  = $false
$exclusionzheader.location                 = New-Object System.Drawing.Point(200,110)
$exclusionzheader.Font                     = 'Microsoft Sans Serif,13,style=Bold'



# check for existence of flag image, otherwise don't show it
if (test-path $psopath\teamflag\flag.bmp) {
	$flagbmp = $true
}
else {
        $flagbmp = $false
}

# use ephinea launcher's gui icon for form
		$ELIcon = [system.drawing.icon]::ExtractAssociatedIcon("$psopath\online.exe")
		$Form.Icon = $ELIcon
		
# picture from ephinea folder 
$PictureBox1                     = New-Object system.Windows.Forms.PictureBox
$PictureBox1.width               = 65
$PictureBox1.height              = 65
$PictureBox1.location            = New-Object System.Drawing.Point(45,15)
$PictureBox1.imageLocation       = "$psopath\teamflag\flag.bmp"
$PictureBox1.visible			 = $flagbmp
$PictureBox1.SizeMode            = [System.Windows.Forms.PictureBoxSizeMode]::zoom
$Form.controls.AddRange(@($Button1,$PictureBox1))






# variable form controls
$Form.controls.AddRange(@($yes,$no,$Label1,$Label2,$Label3,$wldisabled,$help,$blockedpaths,$header,$header2,$graybarbottom,$exclusionsbox,$blockedpaths,$backbutton,$exclusionzheader,$copytoclipboardbutton,$safedisclaimer,$safedisclaimer2,$deptooltip1,$assistbutton,$dllpath))

# defining functions for button click variables
$yes.Add_Click({ yes })
$no.Add_Click({ no })
$help.Add_Click({ helpclicked })
$blockedpaths.Add_Click({ exclusionsclicked })
$copytoclipboardbutton.Add_Click({ copytoclipboardbuttonclicked })
$backbutton.Add_Click({ backclicked })
$assistbutton.Add_Click( {assistbuttonclicked })


# refresh button to refresh registry exclusions when clicked
function backclicked { 

 #if we find a PSO regkey, check for ephinea.dll to see if AV removed it
if (Test-Path -LiteralPath "$psopath\ephinea.dll" -PathType Leaf) {
    $dllpath = "$psopath\ephinea.dll" }
	
	else {
	$dllpath = "Unable to find ephinea.dll in $psopath`r`nIf path is correct, your antivirus may have removed ephinea.dll`r`nIf you have already whitelisted, try running Ephinea launcher to redownload ephinea.dll"
	}

$exclusionsbox1.text  = 
 "[REFRESHING]"
$exclusionsbox2.text  = 
 "[REFRESHING]"
$exclusionsbox3.text  = 
 "[REFRESHING]"
Start-Sleep -Milliseconds 500
$exclusionsbox1.text  = "DEP Exclusions: `r`n
$(Get-Item 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers' | Select-Object -ExpandProperty Property  | out-string;)"
$exclusionsbox2.text  = "Windows Defender Folder & File Exclusions: `r`n
$(Get-Item 'HKLM:\SOFTWARE\Microsoft\Windows Defender\Exclusions\Paths' | Select-Object -ExpandProperty Property  | out-string;)"
$exclusionsbox3.text  = "DLL presence:`r`n$dllpath"

}

# stores gpu name and resolutions
$gpuname = (Get-WmiObject -Class Win32_VideoController).Name;
$cblinebreak = ""
$cbfullres = @((Get-WmiObject -Class Win32_VideoController).CurrentHorizontalResolution  
(Get-WmiObject -Class Win32_VideoController).CurrentVerticalResolution)



### copy logs to clipboard when copy is clicked
function copytoclipboardbuttonclicked {
# save list of AV as variable $antivirusproducts
$osusername=$env:computername
$AntiVirusProducts = Get-WmiObject -Namespace "root\SecurityCenter2" -Class AntiVirusProduct  -ComputerName $osusername
# variable $avdetection will report if defender is on or off and which AV are installed
$avdetection = if((get-process "MsMpEng" -ea SilentlyContinue) -eq $Null){ 
        echo "(Windows Defender is off)
Detected AV software installed: "$AntiVirusProducts.displayname"
Please whitelist your EphineaPSO folder in your AV software."}
else{ 
    echo "(Windows Defender is on)
Detected AV software installed: "$AntiVirusProducts.displayname""}



$killephinealauncher = Get-Process online
$killephinealauncher | Stop-Process -Force
$killephinealauncher | Wait-Process
$cbexclusionsbox1  = "DEP Exclusions:`r`n$(Get-Item 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers' | Select-Object -ExpandProperty Property  | out-string;)"
$cbexclusionsbox2  = "Windows Defender Folder & File Exclusions:`r`n$(Get-Item 'HKLM:\SOFTWARE\Microsoft\Windows Defender\Exclusions\Paths' | Select-Object -ExpandProperty Property  | out-string;)"
$cbexclusionsbox3  = "DLL presence:`r`n$dllpath"
#EphineaFixer version
$version = "EphineaFixer v1.5d"
# discord graves
$discordgrave = "``````"
# store os version as a variable for use with clipboard diagnostics
$osversionvariable = "Windows $([System.Environment]::OSVersion.Version.Major)"
# stores $cbclassicfullscreenstatus with status of classic fullscreen
if (test-path HKCU:\Software\SonicTeam\PSOBB\Ephinea) {$cbclassicfullscreen = (Get-ItemProperty "HKCU:\Software\SonicTeam\PSOBB\Ephinea") | Select-Object -ExpandProperty CLASSIC_FULLSCREEN }
if ($cbclassicfullscreen -eq 1){
$cbclassicfullscreenstatus = "Classic Fullscreen is on"} else
{$cbclassicfullscreenstatus = "Classic Fullscreen is off"}
# stores $cbwindowedstatus with status of windowed mode
if (test-path HKCU:\Software\SonicTeam\PSOBB) {$cbwindowed = (Get-ItemProperty "HKCU:\Software\SonicTeam\PSOBB") | Select-Object -ExpandProperty WINDOW_MODE }
if ($cbwindowed -eq 1){
$cbwindowedstatus = "Windowed mode is on"} else
{$cbwindowedstatus = "Windowed mode is off"}
# stores $cbimestatus with status of ime mode
if (test-path HKCU:\Software\SonicTeam\PSOBB\Ephinea) {$cbime = (Get-ItemProperty "HKCU:\Software\SonicTeam\PSOBB\Ephinea") | Select-Object -ExpandProperty IME }
if ($cbime -eq 1){
$cbimestatus = "IME is on"} else
{$cbimestatus = "IME is off"}
# stores $cbadvancedeffectstatus with status of advanced effect
$cbadvancedeffectstat = (Get-ItemProperty "HKCU:\Software\SonicTeam\PSOBB").GRAPHICCTRL
if ($cbadvancedeffectstat[4] -eq 1){
$cbadvancedeffectstatus = "Advanced Effect is on"}else
{$cbadvancedeffectstatus = "Advanced Effect is off"}
#store uac status as $cbuacdimstartupcheckvalue3
$cbuacdimstartupcheckvalue1 = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System") | Select-Object -ExpandProperty PromptOnSecureDesktop
$cbuacdimstartupcheckvalue2 = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System") | Select-Object -ExpandProperty ConsentPromptBehaviorAdmin
if ($cbuacdimstartupcheckvalue1 -eq 0 -and $cbuacdimstartupcheckvalue2 -eq 0){
$cbuacdimstartupcheckvalue3 = "UAC is disabled, crash-causing dimming will not occur"}
              else {} 
if ($cbuacdimstartupcheckvalue1 -eq 0 -and $cbuacdimstartupcheckvalue2 -eq 5){
$cbuacdimstartupcheckvalue3 = "UAC is on with dimming off, crash-causing dimming will not occur"}
              else {} 
if ($cbuacdimstartupcheckvalue1 -eq 1 -and $cbuacdimstartupcheckvalue2 -eq 5){
$cbuacdimstartupcheckvalue3 = "UAC is on the default setting, crash-causing dimming will occur"}
              else {} 
if ($cbuacdimstartupcheckvalue1 -eq 1 -and $cbuacdimstartupcheckvalue2 -eq 2){
$cbuacdimstartupcheckvalue3 = "UAC is on the highest setting,  crash-causing dimming will occur"}
              else {} 
# stores cpu priority as $cbcpupriority2
$cbcpupriority = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\psobb.exe\PerfOptions").CpuPriorityClass
if ($cbcpupriority -eq 3){
$cbcpupriority2 = "PSOBB.exe using High CPU Priority`r`n"}else
{$cbcpupriority2 = "PSOBB.exe NOT using CPU Priority`r`n"}



($discordgrave, $version, $osversionvariable, $avdetection, $cbuacdimstartupcheckvalue3, $ssclipboard, $cbcpupriority2, $cbclassicfullscreenstatus, $cbadvancedeffectstatus, $cbwindowedstatus, $cbimestatus, $cblinebreak, $cbexclusionsbox1, $cbexclusionsbox2, $cbexclusionsbox3, $discordgrave | Set-Clipboard)
$oReturn=[System.Windows.Forms.Messagebox]::Show("Copied to clipboard!")
}

# hide main screen stuff when clicking exclusions and turn on exclusions page
function exclusionsclicked {  
$label2.visible = $false
$label1.visible = $false
$Label3.visible = $false
$autowloff = $false
$exclusionsbox1.visible = $true
$exclusionsbox2.visible = $true
$exclusionsbox3.visible = $true
$exclusionzheader.visible = $true
$copytoclipboardbutton.visible = $true
$safedisclaimer.visible = $false
$safedisclaimer2.visible = $false
$assistbutton.visible = $true
#hide refresh in manual mode, gets too confusing for dll presence
if ($disablerefreshs -eq $false) {$backbutton.visible = $true}else{$backbutton.visible = $false}
}

### exclusions table

$exclusionsbox1                        = New-Object system.Windows.Forms.TextBox
$exclusionsbox1.multiline              = $true
$exclusionsbox1.scrollbars             = 'both'
$exclusionsbox1.wordwrap               = $false
$exclusionsbox1.readonly               = $true
$exclusionsbox1.text                   = "DEP Exclusions: `r`n$(Get-Item 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers' | Select-Object -ExpandProperty Property  | out-string;)"
$exclusionsbox1.visible				  = $false
$exclusionsbox1.width                  = 405
$exclusionsbox1.height                 = 75
$exclusionsbox1.location               = New-Object System.Drawing.Point(205,140)
$exclusionsbox1.Font                   = 'Microsoft Sans Serif,10'
$Form.controls.AddRange(@($exclusionsbox1))

$exclusionsbox2                        = New-Object system.Windows.Forms.TextBox
$exclusionsbox2.multiline              = $true
$exclusionsbox2.readonly               = $true
$exclusionsbox2.scrollbars             = 'both'
$exclusionsbox2.wordwrap               = $false
$exclusionsbox2.text                   = "Windows Defender Folder & File Exclusions: `r`n$(Get-Item 'HKLM:\SOFTWARE\Microsoft\Windows Defender\Exclusions\Paths' | Select-Object -ExpandProperty Property  | out-string;)"
$exclusionsbox2.visible				  = $false
$exclusionsbox2.width                  = 405
$exclusionsbox2.height                 = 75
$exclusionsbox2.location               = New-Object System.Drawing.Point(205,220)
$exclusionsbox2.Font                   = 'Microsoft Sans Serif,10'
$Form.controls.AddRange(@($exclusionsbox2))

# if pso path ephinea dll exists, create dllpath for initial dll presence exclusionsbox3 below
if (Test-Path -LiteralPath "$psopath\ephinea.dll" -PathType Leaf) {
   $starterpath = "$psopath\ephinea.dll" }
	else {
	$dllpath = "Unable to find ephinea.dll in $psopath`r`nIf path is correct, your antivirus may have removed ephinea.dll`r`nTry running Ephinea launcher to redownload ephinea.dll"
	}
	
	# if install path exists in registry, check for ephinea.dll and make variable dllpath
if (Test-Path -LiteralPath "$psopath\ephinea.dll" -PathType Leaf) {
    $dllpath = "$psopath\ephinea.dll" }
	else {
	$dllpath = "Unable to find ephinea.dll in $psopath`r`nIf path is correct, your antivirus may have removed ephinea.dll`r`nTry running Ephinea launcher to redownload ephinea.dll"
	}

# this makes a much nicer manual mode startup verbage if they go to exclusions first
if ($autowloff -eq $true) {$eb3toggle = "DLL presence:`r`nPlease use MANUAL WHITELIST to check for ephinea.dll"} else { $eb3toggle = "DLL presence:`r`n$dllpath"}


$exclusionsbox3                        = New-Object system.Windows.Forms.TextBox
$exclusionsbox3.multiline              = $true
$exclusionsbox3.readonly               = $true
$exclusionsbox3.scrollbars             = 'both'
$exclusionsbox3.wordwrap               = $false
$exclusionsbox3.text                   = "$eb3toggle"
$exclusionsbox3.visible				  = $false
$exclusionsbox3.width                  = 405
$exclusionsbox3.height                 = 75
$exclusionsbox3.location               = New-Object System.Drawing.Point(205,302)
$exclusionsbox3.Font                   = 'Microsoft Sans Serif,10'
$Form.controls.AddRange(@($exclusionsbox3))

function assistbuttonclicked { 
 $oReturn=[System.Windows.Forms.Messagebox]::Show('DEP Exclusions: 
Should show the full path to your psobb.exe file:
(EX: C:\Users\USERNAME\EphineaPSO\psobb.exe) 
- Fixes game crashing issues.
 
Windows Defender Folder & File Exclusions:
Should show the full path to your EphineaPSO directory: 
(EX: C:\Users\USERNAME\EphineaPSO\) 
- This may fix "! DLL ERROR !" if Defender is deleting 
ephinea.dll, "Server Full", issues updating, crashing, etc.

DLL presence:
Should show the full path to your ephinea.dll file:
(EX: C:\Users\USERNAME\EphineaPSO\ephinea.dll) 
- If missing, whitelist the EphineaPSO folder in your antivirus
and run online.exe in your EphineaPSO folder to reacquire. 
', 'Exclusions Legend', 'OK', 'Information')
}

# opens URL when clicking help or about
function helpclicked { Start-Process 'https://github.com/lucifudge/ephineafixer' }

# opens manual mode browse dialog
function no { 
    function Find-Folders {
    [Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
    [System.Windows.Forms.Application]::EnableVisualStyles()
    $browse = New-Object System.Windows.Forms.FolderBrowserDialog
    $browse.RootFolder = [System.Environment+SpecialFolder]'MyComputer'
    $browse.ShowNewFolderButton = $false
    $browse.Description = "Select EphineaPSO path and press OK.
    
Default path: C:\User\USERNAME\EphineaPSO\"

    $loop = $true
    while($loop)
    {
        if ($browse.ShowDialog() -eq "OK")
        {
        $loop = $false
       
	   
# MANUAL MODE confirmation and activation

# store selected path as variable manualpathchosen
$manualpathchosen = $browse.SelectedPath
# check if psobb.exe exists in selected folder and add defender and dep exclusions if it does
if (Test-Path -LiteralPath $manualpathchosen\psobb.exe -PathType Leaf) 
{ 
	Add-MpPreference -ExclusionPath $manualpathchosen
	Get-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" | New-ItemProperty -Name $manualpathchosen\psobb.exe -Value DisableNXShowUI
# Add compatibility settings (App DPI, compatibility and Run as Admin)
if((Test-Path -LiteralPath "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers") -ne $true) {  New-Item "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers' -Name $manualpathchosen\online.exe -Value "~ RUNASADMIN HIGHDPIAWARE" -PropertyType String -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers' -Name $manualpathchosen\psobb.exe -Value "~ RUNASADMIN HIGHDPIAWARE" -PropertyType String -Force -ea SilentlyContinue;

# cpu priority question
$a = new-object -comobject wscript.shell 
$intAnswer55 = $a.popup("Would you like PSO to utilize high CPU priority?`r`nThis is recommended to improve performance.

(If not, choose No for PSO to utilize normal CPU priority.)", ` 
0,"CPU Priority",4) 
If ($intAnswer55 -eq 6) { 
             # set psobb.exe to high priority
New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\psobb.exe" -Name 'PerfOptions' -force -ea SilentlyContinue;
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\psobb.exe\PerfOptions" -Name 'CpuPriorityClass' -Value '00000003' -PropertyType DWORD -force -ea SilentlyContinue; 
} else { 
			  # set psobb.exe to normal priority
New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\psobb.exe" -Name 'PerfOptions' -force -ea SilentlyContinue;
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\psobb.exe\PerfOptions" -Name 'CpuPriorityClass' -Value '00000002' -PropertyType DWORD -force -ea SilentlyContinue;
} 
  
  
	# using our manual path, check for ephinea.dll to see if AV removed it
if (Test-Path -LiteralPath "$manualpathchosen\ephinea.dll" -PathType Leaf) { $manualdllpath = "$manualpathchosen\ephinea.dll" }
	else {
$manualdllpath = "Unable to find ephinea.dll in $psopath`r`nIf path is correct, your antivirus may have removed ephinea.dll`r`nTry running Ephinea launcher to redownload ephinea.dll"}

	
	
	
# also, lets refresh exclusions lists in case its in focus
$exclusionsbox1.text  = 
"[REFRESHING]"
$exclusionsbox2.text  = 
"[REFRESHING]"
$exclusionsbox3.text  = 
"[REFRESHING]"
Start-Sleep -Milliseconds 75
$exclusionsbox1.text  = "DEP Exclusions: `r`n
$(Get-Item 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers' | Select-Object -ExpandProperty Property  | out-string;)"
$exclusionsbox2.text  = "Windows Defender Folder & File Exclusions: `r`n
$(Get-Item 'HKLM:\SOFTWARE\Microsoft\Windows Defender\Exclusions\Paths' | Select-Object -ExpandProperty Property  | out-string;)"
$exclusionsbox3.text  = "DLL presence: `r`n
$manualdllpath"
# inform we gucci
	 $oReturn=[System.Windows.Forms.Messagebox]::Show("Added Windows Defender and DEP psobb.exe exclusion for directory:
$manualpathchosen and configured compatibility settings for Application Based DPI Scaling and Run as Admin.

Please VIEW EXCLUSIONS to ensure changes were successful.")
} 
# if psobb.exe does not exist in chosen folders, then do nothing and tell you it wasn't found
elseif (-not (Test-Path -LiteralPath $manualpathchosen\psobb.exe -PathType Leaf))
{
 $oReturn=[System.Windows.Forms.Messagebox]::Show("No action taken - unable to find psobb.exe in directory:
 $manualpathchosen")
}

# elegantly terminate browse menu if cancel is pressed
       
        } else
        {
            $res = [System.Windows.Forms.MessageBox]::Show("Really cancel?", "Select a location", [System.Windows.Forms.MessageBoxButtons]::RetryCancel)
            if($res -eq "Cancel")
            {
                # closes browse menu
                return
            }
        }
    }
    $browse.SelectedPath
    $browse.Dispose()
} Find-Folders
   	
 Add-MpPreference -ExclusionPath $browse.SelectedPath }
 
# AUTO WHITELIST MODE 
# add defender and DEP exception for install path found in registry
function yes { 
Add-MpPreference -ExclusionPath $psopath -Force
Get-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" | New-ItemProperty -Name $psopath\psobb.exe -Value DisableNXShowUI
# Add compatibility settings (App DPI, compatibility and Run as Admin)
if((Test-Path -LiteralPath "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers") -ne $true) {  New-Item "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" -force -ea SilentlyContinue };
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers' -Name $psopath\online.exe -Value "~ RUNASADMIN HIGHDPIAWARE" -PropertyType String -Force -ea SilentlyContinue;
New-ItemProperty -LiteralPath 'HKCU:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers' -Name $psopath\psobb.exe -Value "~ RUNASADMIN HIGHDPIAWARE" -PropertyType String -Force -ea SilentlyContinue;

# if install path exists in registry, check for ephinea.dll
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
if (Test-Path -LiteralPath "$psopath\ephinea.dll" -PathType Leaf) {
    $dllpath = "$psopath\ephinea.dll" }
	else {
	$dllpath = "Unable to find ephinea.dll in $psopath`r`nIf path is correct, your antivirus may have removed ephinea.dll`r`nTry running Ephinea launcher to redownload ephinea.dll"
	}


$a = new-object -comobject wscript.shell 
$intAnswer55 = $a.popup("Would you like PSO to utilize high CPU priority?`r`nThis is recommended to improve performance.

(If not, choose No for PSO to utilize normal CPU priority.)", ` 
0,"CPU Priority",4) 
If ($intAnswer55 -eq 6) { 
             # set psobb.exe to high priority
New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\psobb.exe" -Name 'PerfOptions' -force -ea SilentlyContinue;
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\psobb.exe\PerfOptions" -Name 'CpuPriorityClass' -Value '00000003' -PropertyType DWORD -force -ea SilentlyContinue; 
} else { 
			  # set psobb.exe to normal priority
New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\psobb.exe" -Name 'PerfOptions' -force -ea SilentlyContinue;
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\psobb.exe\PerfOptions" -Name 'CpuPriorityClass' -Value '00000002' -PropertyType DWORD -force -ea SilentlyContinue;
} 
  


 # also, lets refresh exclusions lists in case its in focus
 $exclusionsbox1.text  = 
 "[REFRESHING]"
 $exclusionsbox2.text  = 
 "[REFRESHING]"
 $exclusionsbox3.text  = 
 "[REFRESHING]"
Start-Sleep -Milliseconds 75
$exclusionsbox1.text  = "DEP Exclusions: `r`n
$(Get-Item 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers' | Select-Object -ExpandProperty Property  | out-string;)"
$exclusionsbox2.text  = "Windows Defender Folder & File Exclusions: `r`n
$(Get-Item 'HKLM:\SOFTWARE\Microsoft\Windows Defender\Exclusions\Paths' | Select-Object -ExpandProperty Property  | out-string;)"
$exclusionsbox3.text  = "DLL presence:`r`n$dllpath"
 $oReturn=[System.Windows.Forms.Messagebox]::Show("Added Windows Defender and DEP psobb.exe exclusion for directory:
$psopath and configured compatibility settings for Application Based DPI Scaling, and Run as Admin.

Please VIEW EXCLUSIONS to ensure changes were successful.")
 }




# if not windows 10, issue warning and then close the script
if ([System.Environment]::OSVersion.Version.Major -eq 10) {}
	 else {$oReturn=[System.Windows.Forms.Messagebox]::Show("This tool will only work in Windows 10 and will now close.`r`n`r`nSorry!")
	 Exit
	 }
	 


#############################################################
#these are checks for existence of c++ redist 
$itemlookup = Get-ItemProperty -Path $appwizpath -ErrorAction SilentlyContinue
$x642015installed = $itemlookup -and $itemlookup.DisplayName -like "Microsoft Visual C++ 2015 Redistributable (x64)*"
$x862015installed = $itemlookup -and $itemlookup.DisplayName -like "Microsoft Visual C++ 2015 Redistributable (x86)*"


# if setup files exist in ephinea redist folder, assign them a variable
if (Test-Path -LiteralPath "$psopath\redist\vc_redist.x86.exe" -PathType Leaf) {
$x86setuppresent = "$psopath\redist\vc_redist.x86.exe" }
	else {
	$x86setuppresent = $false
	}
if (Test-Path -LiteralPath "$psopath\redist\vc_redist.x64.exe" -PathType Leaf) {
$x64setuppresent = "$psopath\redist\vc_redist.x64.exe" }
	else {
	$x64setuppresent = $false
	}

# save osarc as true if os is 64-bit
$osarc = [System.Environment]::Is64BitOperatingSystem

#INSTALLERS PRESENT FOR 64-BIT

# if 64-bit OS and x64 C++ 2015 is installed but x86 isn't and installer is present
if ($x86setuppresent -and $x642015installed -and $osarc -and $x862015installed -contains $false ){

$a = new-object -comobject wscript.shell
$intAnswer2 = $a.popup("Microsoft Visual C++ 2015 32-bit does not appear to be installed.
Without it, you may not be able to access the Options menu in the EphineaPSO directory.
Would you like to install it now?", `
0,"Missing Visual C++ 2015 Runtime",4)} 
			# if you answer yes
              If ($intAnswer2 -eq 6) {
              # start the installers, wait for them to finish with the echo command, then say install complete
              & $psopath\redist/vc_redist.x86.exe -argumentlist /install /passive /norestart | echo "Waiting." 
			  $a.popup("Install complete." , `
              0,"Missing Visual C++ 2015",0) }
              
              # if you answer no, do nothing
              else {} 


# turning off 64-bit C++ 2015 redist installers since supposedly they are not needed for pso
<# # if 64-bit OS and x86 C++ 2015 is installed but x64 isn't and installer is present
if ($x862015installed -and $x64setuppresent -and $osarc -and $x642015installed -contains $false ){

$a = new-object -comobject wscript.shell
$intAnswer1 = $a.popup("Microsoft Visual C++ 2015 64-bit does not appear to be installed.
Without it, you may not be able to access the Options menu in the EphineaPSO directory.
Would you like to install it now?", `
0,"Missing Visual C++ 2015 Runtime",4)} 
			# if you answer yes
              If ($intAnswer1 -eq 6) {
              # start the installers, wait for them to finish with the echo command, then say install complete
              & $psopath\redist\vc_redist.x64.exe /install /passive /norestart | echo "Waiting." 
			  			  $a.popup("Install complete." , `
              0,"Missing Visual C++ 2015 Runtime",0) }
              
              # if you answer no, do nothing
              else {} 
 #>
 
 <# # if 64-bit OS and neither x86 or x64 C++ 2015 is installed and installers are present
if ($x64setuppresent -and $x86setuppresent -and $osarc -and $x862015installed -contains $false -and $x642015installed -contains $false ){

$a = new-object -comobject wscript.shell
$intAnswer3 = $a.popup("Microsoft Visual C++ 2015 32-bit and 64-bit do not appear to be installed.
Without them, you may not be able to access the Options menu in the EphineaPSO directory.
Would you like to install them now?", `
0,"Missing Visual C++ 2015 Runtimes",4)} 
			# if you answer yes
              If ($intAnswer3 -eq 6) {
              # start the installers, wait for them to finish with the echo command, then say install complete
              & $psopath\redist/vc_redist.x64.exe -argumentlist /install /passive /norestart | echo "Waiting."
              & $psopath\redist/vc_redist.x86.exe -argumentlist /install /passive /norestart | echo "Waiting." 
			  			  $a.popup("Install complete." , `
              0,"Missing Visual C++ 2015 Runtimes",0) }
              
              # if you answer no, do nothing
              else {}  #>
			  


			  
			  
#INSTALLERS NOT PRESENT FOR 64-BIT
<# # if 64-bit OS and x86 C++ 2015 is installed but x64 isn't and installer is not present
if ($x862015installed -and $osarc -and $x64setuppresent -contains $false -and $x642015installed -contains $false ){

$a = new-object -comobject wscript.shell
$intAnswer4 = $a.popup("Microsoft Visual C++ 2015 64-bit does not appear to be installed.
Without it, you may not be able to access the Options menu in the EphineaPSO directory.
Would you like to visit the web to download it? ( vc_redist.x64.exe ) ", `
0,"Missing Visual C++ 2015 Runtime",4)} 
			# if you answer yes
              If ($intAnswer4 -eq 6) {
                       # open browser to the microsoft website
          Start 'https://www.microsoft.com/en-us/download/details.aspx?id=48145' }      
              # if you answer no, do nothing
              else {}  #>


# if 64-bit OS and x64 C++ 2015 is installed but x86 isn't and installer is not present
if ($x642015installed -and $osarc -and $x862015installed -contains $false -and $x86setuppresent -contains $false){

$a = new-object -comobject wscript.shell
$intAnswer6 = $a.popup("Microsoft Visual C++ 2015 32-bit does not appear to be installed.
Without it, you may not be able to access the Options menu in the EphineaPSO directory.
Would you like to visit the web to download it? ( vc_redist.x86.exe ) ", `
0,"Missing Visual C++ 2015 Runtime",4)} 
			# if you answer yes
              If ($intAnswer6 -eq 6) {
                 # open browser to the microsoft website
          Start 'https://www.microsoft.com/en-us/download/details.aspx?id=48145' }      
              
              # if you answer no, do nothing
              else {} 


<# # if 64-bit OS and neither x86 or x64 C++ 2015 is installed and installers are not present
if ($osarc -and $x862015installed -contains $false -and $x642015installed -contains $false -and $x64setuppresent -contains $false -and $x86setuppresent -contains $false){

$a = new-object -comobject wscript.shell
$intAnswer7 = $a.popup("Microsoft Visual C++ 2015 32-bit and 64-bit do not appear to be installed.
Without them, you will not be able to access the Options menu in the EphineaPSO directory.
Would you like to visit the web to download them? ( vc_redist.x64.exe and vc_redist.x86.exe ) ", `
0,"Missing Visual C++ 2015 Runtimes",4)} 
			# if you answer yes
              If ($intAnswer7 -eq 6) {
          # open browser to the microsoft website
        Start 'https://www.microsoft.com/en-us/download/details.aspx?id=48145' }              
              # if you answer no, do nothing
              else {}  #>
			  


#INSTALLERS PRESENT FOR 32-BIT
# if 32-bit OS and x86 isn't installed and installer is present
if ($x86setuppresent -and $x862015installed -contains $false -and $osarc -contains $false ){

$a = new-object -comobject wscript.shell
$intAnswer8 = $a.popup("Microsoft Visual C++ 2015 32-bit does not appear to be installed.
Without it, you may not be able to access the Options menu in the EphineaPSO directory.
Would you like to install it now?", `
0,"Missing Visual C++ 2015 Runtime",4)} 
			# if you answer yes
              If ($intAnswer8 -eq 6) {
              # start the installers, wait for them to finish with the echo command, then say install complete
              & $psopath\redist/vc_redist.x86.exe -argumentlist /install /passive /norestart | echo "Waiting." 
			  $a.popup("Install complete." , `
              0,"Missing Visual C++ 2015",0) }
              
              # if you answer no, do nothing
              else {} 

#INSTALLERS NOT PRESENT FOR 32-BIT
# if 32-bit OS and x86 isn't installed and installer is not present
if ($x86setuppresent -contains $false -and $x862015installed -contains $false -and $osarc -contains $false ){

$a = new-object -comobject wscript.shell
$intAnswer9 = $a.popup("Microsoft Visual C++ 2015 32-bit does not appear to be installed.
Without it, you may not be able to access the Options menu in the EphineaPSO directory.
Would you like to visit the web to download it? ( vc_redist.x86.exe ) ", `
0,"Missing Visual C++ 2015 Runtime",4)} 
			# if you answer yes
              If ($intAnswer9 -eq 6) {
                 # open browser to the microsoft website
        Start 'https://www.microsoft.com/en-us/download/details.aspx?id=48145' } 
              
              # if you answer no, do nothing
              else {} 
			  			  

#end checks for c++ redist
#################################################




# for gui
[void]$Form.ShowDialog()










