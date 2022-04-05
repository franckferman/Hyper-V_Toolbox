<#hyper-v_toolbox
Author: Franck FERMAN - fferman@protonmail.ch
Description: Hyper-V Toolbox is a PowerShell script allowing (among other things) the complete (and advanced) management of virtual machines (with Hyper V). 
Version: 2.0
#>

[string]$script:DefaultWindowTitle=$host.ui.RawUI.WindowTitle

function Check_AdministratorRights
{

[bool]$is_Administrator=(New-Object System.Security.Principal.WindowsPrincipal([System.Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)

	switch($is_Administrator)
	{
    	$True{main}
    	$False{Write-Host "Error, please run the script with Administrator rights." -ForegroundColor darkred;exit}
    	default{Write-Host "Sorry, an unexpected error has been caused." -ForegroundColor darkred;exit}
	}

}

function Ask_YesOrNo
{
	param
    (
    	[string]$title="Confirmation",
		[string]$message="Do you really want to continue?"
    )

    $choiceYes=New-Object System.Management.Automation.Host.ChoiceDescription "&Yes","Yes"
    $choiceNo=New-Object System.Management.Automation.Host.ChoiceDescription "&No","No"
    $options=[System.Management.Automation.Host.ChoiceDescription[]]($choiceYes,$choiceNo)
    $script:Ask_YesOrNo_Result=$host.ui.PromptForChoice($title,$message,$options,1)

}

function main
{

$host.ui.RawUI.WindowTitle="Hyper-V Toolbox - Franck FERMAN"

Clear-Host
Write-Host ""
Write-Host -ForegroundColor darkyellow	"                               _oo0oo_                  "
Write-Host -ForegroundColor darkyellow	"                              o8888888o                 "
Write-Host -ForegroundColor darkyellow	"                              88`" . `"88               "
Write-Host -ForegroundColor darkyellow	"                              (| -_- |)                 "
Write-Host -ForegroundColor darkyellow	"                              0\  =  /0                 "
Write-Host -ForegroundColor darkyellow	"                            ___/`----'\___              "
Write-Host -ForegroundColor darkyellow	"                          .' \\|     |// '.             "
Write-Host -ForegroundColor darkyellow	"                         / \\|||  :  |||// \            "
Write-Host -ForegroundColor darkyellow	"                        / _||||| -:- |||||- \           "
Write-Host -ForegroundColor darkyellow	"                       |   | \\\  -  /// |   |          "
Write-Host -ForegroundColor darkyellow	"                       | \_|  ''\---/''  |_/ |          "
Write-Host -ForegroundColor darkyellow	"                       \  .-\__  '-'  ___/-. /          "
Write-Host -ForegroundColor darkyellow	"                     ___'. .'  /--.--\  `. .'___        "
Write-Host -ForegroundColor darkyellow	"                  .`"`" '<  `.___\_<|>_/___.' >' `"`".  "
Write-Host -ForegroundColor darkyellow	"                 | | :  `- \`.;`\ _ /`;.`/ - ` : | |    "
Write-Host -ForegroundColor darkyellow	"                 \  \ `_.   \_ __\ /__ _/   .-` /  /    "
Write-Host -ForegroundColor darkyellow	"             =====`-.____`.___ \_____/___.-`___.-'===== "
Write-Host -ForegroundColor darkyellow  "                               `=---='                  "
Write-Host ""
Write-Host -ForegroundColor darkyellow "  _  _                      __   __  _____         _ _             	"
Write-Host -ForegroundColor darkyellow " | || |_  _ _ __  ___ _ _ __\ \ / / |_   _|__  ___| | |__  _____ __ "
Write-Host -ForegroundColor darkyellow " | __ | || | '_ \/ -_) '_|___\ V /    | |/ _ \/ _ \ | '_ \/ _ \ \ /	"
Write-Host -ForegroundColor darkyellow " |_||_|\_, | .__/\___|_|      \_/     |_|\___/\___/_|_.__/\___/_\_\	"
Write-Host -ForegroundColor darkyellow "       |__/|_|                                                     	"
Write-Host ""
Write-Host "Hello dear " -NoNewline
Write-Host "$env:UserName " -NoNewline -ForegroundColor green
Write-Host "and welcome to "-NoNewLine
Write-Host "Hyper-V Toolbox"-NonewLine -ForegroundColor green 
Write-Host "."
Write-Host ""
Write-Host "1 - Creation of (blank) virtual machine(s)."
Write-Host "2 - Creation of pre-configured virtual machine(s)."
Write-Host ""
Write-Host "3 - Management of virtual machine(s)."
Write-Host "4 - Management of virtual switche(s)."
Write-Host ""
Write-Host "5 - Resource management and local downloading."
Write-Host ""
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	1{HPV-New_VM-Blank}
    	2{HPV-New_VM-Template}
    	3{HPV-VM_Management}
    	4{HPV-Virtual_Switches_Management}
    	5{Resource_Management}

    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

<# List of download links to resources.
## Microsoft_Windows
# Microsoft_Windows-Entreprise
https://images-data.fra1.digitaloceanspaces.com/client-windows10-entreprise-ltsc.iso
# Microsoft_Windows-Pro
https://images-data.fra1.digitaloceanspaces.com/client-windows10.iso
# Microsoft_Windows-Server_2012
https://images-data.fra1.digitaloceanspaces.com/win_srv-2012.iso
# Microsoft_Windows-Server_2019
https://images-data.fra1.digitaloceanspaces.com/win_srv-2019.iso
## GNU_Linux
# Debian
https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.3.0-amd64-netinst.iso
#Rocky_Linux
https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.5-x86_64-dvd1.iso
https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.5-x86_64-minimal.iso
# Parrot_Security
https://bunny.deb.parrot.sh/parrot/iso/5.0/Parrot-security-5.0_amd64.iso
# Arch_Linux
https://ftp.u-strasbg.fr/linux/distributions/archlinux/iso/2022.04.01/archlinux-2022.04.01-x86_64.iso
# Kali_Linux
https://cdimage.kali.org/kali-images/current/kali-linux-2022.1-live-amd64.iso
https://cdimage.kali.org/kali-images/current/kali-linux-2022.1-installer-amd64.iso
# Ubuntu
https://ubuntu.univ-nantes.fr/ubuntu-cd/22.04/ubuntu-22.04-beta-desktop-amd64.iso
https://ubuntu.univ-nantes.fr/ubuntu-cd/20.04.4/ubuntu-20.04.4-desktop-amd64.iso
https://ubuntu.univ-nantes.fr/ubuntu-cd/18.04.6/ubuntu-18.04.6-desktop-amd64.iso
# pfSense
https://images-data.fra1.digitaloceanspaces.com/pfSense-CE-2.5.1-RELEASE-amd64.iso
#>

function HPV-New_VM-Blank
{
Clear-Host
Write-Host "What type of operating system matches the machine(s) you want to generate?"
Write-Host ""
Write-Host "1 - Microsoft Windows"
Write-Host "2 - GNU/Linux"
Write-Host ""
Write-Host "8 - Go back to the main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	1{HPV-New_VM-Blank-Microsoft_Windows}
    	2{HPV-New_VM-Blank-GNU_Linux}
    
    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-New_VM-Blank-Microsoft_Windows
{
Clear-Host
Write-Host "1 - Microsoft Windows 10 Entreprise (LTSC)"
Write-Host "2 - Microsoft Windows 10 Pro/Home/Education"
Write-Host ""
Write-Host "3 - Microsoft Windows Server 2012"
Write-Host "4 - Microsoft Windows Server 2019"
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	1{HPV-New_VM-Blank-Client-Microsoft_Windows_10-Entreprise_LTSC}
    	2{HPV-New_VM-Blank-Client-Microsoft_Windows_10-Multi}

    	3{HPV-New_VM-Blank-Server-Microsoft_Windows_Server-2012}
    	4{HPV-New_VM-Blank-Server-Microsoft_Windows_Server-2019}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
}

}

function HPV-New_VM-Blank-Template
{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine
Write-Host "The name chosen for the virtual machine is " -NoNewLine 
Write-Host "$VMname" -NoNewLine -ForegroundColor green
Write-Host "."

Ask_YesOrNo "Hyper-V Toolbox - MessageBox function - Franck FERMAN." "Would you like to add a network card to your virtual machine?"

	switch($Ask_YesOrNo_Result)
	{
	1{[bool]$script:UseNetworkCard=$False}
	
	0{
	[bool]$script:UseNetworkCard=$True
	$VMsList=@()
	Get-VMSwitch|ForEach-Object{$VMsList+=$_.Name}
	
	Write-Host "`nOngoing action: " -NoNewLine
	Write-Host "Display the list of virtual switches.`n"
	For($i=0;$i -lt $VMsList.Length;$i++){Write-Host "$i - $($VMsList[$i])"}
	
	[int]$userChoice=Read-Host "`nWhich virtual switch do you want to set up on your virtual machine"
	$VMchoice=$VMsList[$userChoice]
	$script:SwitchName=$VMchoice
	Write-Host "Info: " -NoNewLine
	Write-Host "The chosen virtual switch is " -NoNewLine 
	Write-Host "$SwitchName" -NoNewLine -ForegroundColor green
	Write-Host "."
	}

	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Verification of required resources (and automatic decision making)."
	if(Test-Path $isoPath)
	{
		Write-Host "Info: " -NoNewLine
		Write-Host "The resource corresponding to your request has been identified." -ForegroundColor green
	}else{
		Write-Host "Info: " -NoNewLine
		Write-Host "The corresponding resource could not be identified or an unexpected error was caused during the identification phase." -ForegroundColor darkred
		Write-Host "`nOngoing action: " -NoNewLine
		Write-Host "Automated launch of the download of the corresponding resources.`n" -NoNewLine

			if(Test-Path $isoDest){$null}else{[void](New-Item -Path $isoFolderPath -ItemType Directory -Force)}

	Start-BitsTransfer -Source $isoSrc -Destination $isoDest -DisplayName "Hyper-V_Toolbox - Downloading function - Franck FERMAN." -Description "Download of the corresponding resource in progress."

	if(Test-Path $isoPath){Write-Host "`nInfo: " -NoNewLine;Write-Host "Download successfully completed." -ForegroundColor green}else{Write-Host "`nInfo:" -NoNewLine;Write-Host "An unexpected error was caused." -ForegroundColor darkred;Write-Host "`nOngoing action:" -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor darkred;pause;main}
	}

$RAMgbSizeList=@('1GB','2GB','4GB','8GB')

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Display the list of choices concerning the available RAM on your virtual machine.`n"
For($i=0;$i -lt $RAMgbSizeList.Length;$i++){Write-Host "$i - $($RAMgbSizeList[$i])"}

$userChoice=Read-Host "`nWhat quantity do you want to choose for your virtual machine"
$RAMgbSizeUserChoice=$RAMgbSizeList[$userChoice]
$RAMgbSize=$RAMgbSizeUserChoice
Write-Host "Info: " -NoNewLine
Write-Host "The chosen memory startup bytes is " -NoNewLine
Write-Host "$RAMgbSize" -NoNewLine -ForegroundColor green
Write-Host "."

	switch($RAMgbSize)
	{
    	"1GB"{$script:RAMgbSize=1GB}
    	"2GB"{$script:RAMgbSize=2GB}
    	"4GB"{$script:RAMgbSize=4GB}
    	"8GB"{$script:RAMgbSize=8GB}
	}

$VHDgbSizeList=@('16GB','20GB','32GB','48GB','64GB','80GB','120GB')

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Display of the list of choices regarding the desired hard disk size for your virtual machine.`n"
For($i=0;$i -lt $VHDgbSizeList.Length;$i++){Write-Host "$i - $($VHDgbSizeList[$i])"}

$userChoice=Read-Host "`nWhat size hard drive do you want for your virtual machine"
$VHDgbSizeUserChoice=$VHDgbSizeList[$userChoice]
$VHDgbSize=$VHDgbSizeUserChoice
Write-Host "`nInfo: " -NoNewLine
Write-Host "The chosen hard disk size is " -NoNewLine
Write-Host "$VHDgbSize" -NoNewLine -ForegroundColor green
Write-Host "."

	switch($VHDgbSize)
	{
		"16GB"{$script:VHDgbSize=16GB}
    	"20GB"{$script:VHDgbSize=20GB}
    	"32GB"{$script:VHDgbSize=32GB}
    	"48GB"{$script:VHDgbSize=48GB}
    	"64GB"{$script:VHDgbSize=64GB}
    	"80GB"{$script:VHDgbSize=80GB}
    	"120GB"{$script:VHDgbSize=120GB}
	}

	if(Test-Path $VHDSPath){$null}else{[void](New-Item -Path $VHDSPath -ItemType Directory -Force)}
	if(Test-Path $vmsPath){$null}else{[void](New-Item -Path $vmsPath -ItemType Directory -Force)}

}

function HPV-New_VM-Blank-Client-Microsoft_Windows_10-Entreprise_LTSC
{
[string]$script:isoPath=".\src\Microsoft_Windows\clients\iso\client-windows10-entreprise-ltsc.iso"
[string]$script:isoDest=".\src\Microsoft_Windows\clients\iso"
[string]$script:isoFolderPath=".\src\Microsoft_Windows\clients\iso"
[string]$script:isoSrc="https://images-data.fra1.digitaloceanspaces.com/client-windows10-entreprise-ltsc.iso"

[string]$script:VHDSPath=".\src\Microsoft_Windows\clients\vhds\"
[string]$script:vmsPath=".\src\Microsoft_Windows\clients\vms\"

HPV-New_VM-Blank-Template

	if($UseNetworkCard -eq $True){New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath" -SwitchName $SwitchName}else{New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath"}

Add-VMDvdDrive -VMName $VMName -Path "$isoPath"

$myVM=Get-VMFirmware $VMName
$HDD=$myVM.BootOrder[0]
$PXE=$myVM.BootOrder[1]
$DVD=$myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VM -Name $VMName -AutomaticCheckpointsEnabled $False

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch ($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-Client-Microsoft_Windows_10-Entreprise_LTSC}
    	2{HPV-Copy_VM-Different-Blank-Client-Microsoft_Windows_10-Entreprise_LTSC}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Same-Blank-Client-Microsoft_Windows_10-Entreprise_LTSC
{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine
Write-Host "The name chosen for the virtual machine is " -NoNewLine 
Write-Host "$VMname" -NoNewLine -ForegroundColor green
Write-Host "."

	if($UseNetworkCard -eq $True){New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath" -SwitchName $SwitchName}else{New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath"}

Add-VMDvdDrive -VMName $VMName -Path "$isoPath"

$myVM=Get-VMFirmware $VMName
$HDD=$myVM.BootOrder[0]
$PXE=$myVM.BootOrder[1]
$DVD=$myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VM -Name $VMName -AutomaticCheckpointsEnabled $False

Write-Host ""
Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch ($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-Client-Microsoft_Windows_10-Entreprise_LTSC}
    	2{HPV-Copy_VM-Different-Blank-Client-Microsoft_Windows_10-Entreprise_LTSC}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Different-Blank-Client-Microsoft_Windows_10-Entreprise_LTSC
{
HPV-New_VM-Blank-Client-Microsoft_Windows_10-Entreprise_LTSC
}

function HPV-New_VM-Blank-Client-Microsoft_Windows_10-Multi
{
[string]$script:isoPath=".\src\Microsoft_Windows\clients\iso\client-windows10.iso"
[string]$script:isoDest=".\src\Microsoft_Windows\clients\iso"
[string]$script:isoFolderPath=".\src\Microsoft_Windows\clients\iso"
[string]$script:isoSrc="https://images-data.fra1.digitaloceanspaces.com/client-windows10.iso"

[string]$script:VHDSPath=".\src\Microsoft_Windows\clients\vhds\"
[string]$script:vmsPath=".\src\Microsoft_Windows\clients\vms\"

HPV-New_VM-Blank-Template

	if($UseNetworkCard -eq $True){New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath" -SwitchName $SwitchName}else{New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath"}

Add-VMDvdDrive -VMName $VMName -Path "$isoPath"

$myVM=Get-VMFirmware $VMName
$HDD=$myVM.BootOrder[0]
$PXE=$myVM.BootOrder[1]
$DVD=$myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VM -Name $VMName -AutomaticCheckpointsEnabled $False

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch ($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-Client-Microsoft_Windows_10-Multi}
    	2{HPV-Copy_VM-Different-Blank-Client-Microsoft_Windows_10-Multi}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Same-Blank-Client-Microsoft_Windows_10-Multi
{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine
Write-Host "The name chosen for the virtual machine is " -NoNewLine 
Write-Host "$VMname" -NoNewLine -ForegroundColor green
Write-Host "."

	if($UseNetworkCard -eq $True){New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath" -SwitchName $SwitchName}else{New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath"}

Add-VMDvdDrive -VMName $VMName -Path "$isoPath"

$myVM=Get-VMFirmware $VMName
$HDD=$myVM.BootOrder[0]
$PXE=$myVM.BootOrder[1]
$DVD=$myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VM -Name $VMName -AutomaticCheckpointsEnabled $False

Write-Host ""
Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch ($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-Client-Microsoft_Windows_10-Multi}
    	2{HPV-Copy_VM-Different-Blank-Client-Microsoft_Windows_10-Multi}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Different-Blank-Client-Microsoft_Windows_10-Multi
{
HPV-Copy_VM-Same-Blank-Client-Microsoft_Windows_10-Multi
}

function HPV-New_VM-Blank-Server-Microsoft_Windows_Server-2012
{
[string]$script:isoPath=".\src\Microsoft_Windows\servers\iso\win_srv-2012.iso"
[string]$script:isoDest=".\src\Microsoft_Windows\servers\iso"
[string]$script:isoFolderPath=".\src\Microsoft_Windows\servers\iso"
[string]$script:isoSrc="https://images-data.fra1.digitaloceanspaces.com/win_srv-2012.iso"

[string]$script:VHDSPath=".\src\Microsoft_Windows\servers\vhds\"
[string]$script:vmsPath=".\src\Microsoft_Windows\servers\vms\"

HPV-New_VM-Blank-Template

	if($UseNetworkCard -eq $True){New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath" -SwitchName $SwitchName}else{New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath"}

Add-VMDvdDrive -VMName $VMName -Path "$isoPath"

$myVM=Get-VMFirmware $VMName
$HDD=$myVM.BootOrder[0]
$PXE=$myVM.BootOrder[1]
$DVD=$myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VM -Name $VMName -AutomaticCheckpointsEnabled $False

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch ($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-Server-Microsoft_Windows_Server-2012}
    	2{HPV-Copy_VM-Different-Blank-Server-Microsoft_Windows_Server-2012}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Same-Blank-Server-Microsoft_Windows_Server-2012
{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine
Write-Host "The name chosen for the virtual machine is " -NoNewLine 
Write-Host "$VMname" -NoNewLine -ForegroundColor green
Write-Host "."

	if($UseNetworkCard -eq $True){New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath" -SwitchName $SwitchName}else{New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath"}

Add-VMDvdDrive -VMName $VMName -Path "$isoPath"

$myVM=Get-VMFirmware $VMName
$HDD=$myVM.BootOrder[0]
$PXE=$myVM.BootOrder[1]
$DVD=$myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VM -Name $VMName -AutomaticCheckpointsEnabled $False

Write-Host ""
Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch ($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-Server-Microsoft_Windows_Server-2012}
    	2{HPV-Copy_VM-Different-Blank-Server-Microsoft_Windows_Server-2012}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Different-Blank-Server-Microsoft_Windows_Server-2012
{
HPV-New_VM-Blank-Server-Microsoft_Windows_Server-2012
}

function HPV-New_VM-Blank-Server-Microsoft_Windows_Server-2019
{
[string]$script:isoPath=".\src\Microsoft_Windows\servers\iso\win_srv-2019.iso"
[string]$script:isoDest=".\src\Microsoft_Windows\servers\iso"
[string]$script:isoFolderPath=".\src\Microsoft_Windows\servers\iso"
[string]$script:isoSrc="https://images-data.fra1.digitaloceanspaces.com/win_srv-2019.iso"

[string]$script:VHDSPath=".\src\Microsoft_Windows\servers\vhds\"
[string]$script:vmsPath=".\src\Microsoft_Windows\servers\vms\"

HPV-New_VM-Blank-Template

	if($UseNetworkCard -eq $True){New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath" -SwitchName $SwitchName}else{New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath"}

Add-VMDvdDrive -VMName $VMName -Path "$isoPath"

$myVM=Get-VMFirmware $VMName
$HDD=$myVM.BootOrder[0]
$PXE=$myVM.BootOrder[1]
$DVD=$myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VM -Name $VMName -AutomaticCheckpointsEnabled $False

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch ($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-Server-Microsoft_Windows_Server-2019}
    	2{HPV-Copy_VM-Different-Blank-Server-Microsoft_Windows_Server-2019}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Same-Blank-Server-Microsoft_Windows_Server-2019
{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine
Write-Host "The name chosen for the virtual machine is " -NoNewLine 
Write-Host "$VMname" -NoNewLine -ForegroundColor green
Write-Host "."

	if($UseNetworkCard -eq $True){New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath" -SwitchName $SwitchName}else{New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath"}

Add-VMDvdDrive -VMName $VMName -Path "$isoPath"

$myVM=Get-VMFirmware $VMName
$HDD=$myVM.BootOrder[0]
$PXE=$myVM.BootOrder[1]
$DVD=$myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VM -Name $VMName -AutomaticCheckpointsEnabled $False

Write-Host ""
Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch ($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-Server-Microsoft_Windows_Server-2019}
    	2{HPV-Copy_VM-Different-Blank-Server-Microsoft_Windows_Server-2019}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Different-Blank-Server-Microsoft_Windows_Server-2019
{
HPV-New_VM-Blank-Server-Microsoft_Windows_Server-2019
}

function HPV-New_VM-Blank-GNU_Linux
{
Clear-Host
Write-Host "0 - pfSense (CE, 2.5.1)"
Write-Host ""
Write-Host "1 - Debian (11.3.0)"
Write-Host "2 - Ubuntu, Jammy Jellyfish (LTS, 22.04)"
Write-Host ""
Write-Host "3 - Rocky Linux (Full, 8.5)"
Write-Host "4 - Rocky Linux (Minimal, 8.5)"
Write-Host ""
Write-Host "5 - Parrot Security (5.0)"
Write-Host "6 - Kali (Live, 2022.1)"
Write-Host "7 - Kali (Installer, 2022.1)"
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
		0{HPV-New_VM-Blank-GNU_Linux-pfSense}
    	1{HPV-New_VM-Blank-GNU_Linux-Debian}
    	2{HPV-New_VM-Blank-GNU_Linux-Ubuntu}
    	3{HPV-New_VM-Blank-GNU_Linux-Rocky_Linux-Full}
    	4{HPV-New_VM-Blank-GNU_Linux-Rocky_Linux-Minimal}
    	5{HPV-New_VM-Blank-GNU_Linux-Parrot_Security}
    	6{HPV-New_VM-Blank-GNU_Linux-Kali_Linux-Live}
    	7{HPV-New_VM-Blank-GNU_Linux-Kali_Linux-Installer}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
}

}

function HPV-New_VM-Blank-GNU_Linux-pfSense
{
[string]$script:isoPath=".\src\GNU_Linux\iso\pfSense-CE-2.5.1-RELEASE-amd64.iso"
[string]$script:isoDest=".\src\GNU_Linux\iso"
[string]$script:isoFolderPath=".\src\GNU_Linux\iso"
[string]$script:isoSrc="https://images-data.fra1.digitaloceanspaces.com/pfSense-CE-2.5.1-RELEASE-amd64.iso"

[string]$script:VHDSPath=".\src\GNU_Linux\vhds\"
[string]$script:vmsPath=".\src\GNU_Linux\vms\"

HPV-New_VM-Blank-Template

	if($UseNetworkCard -eq $True){New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath" -SwitchName $SwitchName}else{New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath"}

Add-VMDvdDrive -VMName $VMName -Path "$isoPath"

$myVM=Get-VMFirmware $VMName
$HDD=$myVM.BootOrder[0]
$PXE=$myVM.BootOrder[1]
$DVD=$myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VMMemory $VMName -DynamicMemoryEnabled $False
Set-VMFirmware $VMName -EnableSecureBoot Off
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $False

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch ($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-GNU_Linux-pfSense}
    	2{HPV-Copy_VM-Different-Blank-GNU_Linux-pfSense}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Same-Blank-GNU_Linux-pfSense
{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine
Write-Host "The name chosen for the virtual machine is " -NoNewLine 
Write-Host "$VMname" -NoNewLine -ForegroundColor green
Write-Host "."

	if($UseNetworkCard -eq $True){New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath" -SwitchName $SwitchName}else{New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath"}

Add-VMDvdDrive -VMName $VMName -Path "$isoPath"

$myVM=Get-VMFirmware $VMName
$HDD=$myVM.BootOrder[0]
$PXE=$myVM.BootOrder[1]
$DVD=$myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VMMemory $VMName -DynamicMemoryEnabled $False
Set-VMFirmware $VMName -EnableSecureBoot Off
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $False

Write-Host ""
Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch ($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-GNU_Linux-pfSense}
    	2{HPV-Copy_VM-Different-Blank-GNU_Linux-pfSense}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Different-Blank-GNU_Linux-pfSense
{
HPV-New_VM-Blank-GNU_Linux-pfSense
}

function HPV-New_VM-Blank-GNU_Linux-Debian
{
[string]$script:isoPath=".\src\GNU_Linux\iso\debian-11.3.0-amd64-netinst.iso"
[string]$script:isoDest=".\src\GNU_Linux\iso"
[string]$script:isoFolderPath=".\src\GNU_Linux\iso"
[string]$script:isoSrc="https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.3.0-amd64-netinst.iso"

[string]$script:VHDSPath=".\src\GNU_Linux\vhds\"
[string]$script:vmsPath=".\src\GNU_Linux\vms\"

HPV-New_VM-Blank-Template

	if($UseNetworkCard -eq $True){New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath" -SwitchName $SwitchName}else{New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath"}

Add-VMDvdDrive -VMName $VMName -Path "$isoPath"

$myVM=Get-VMFirmware $VMName
$HDD=$myVM.BootOrder[0]
$PXE=$myVM.BootOrder[1]
$DVD=$myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VMMemory $VMName -DynamicMemoryEnabled $False
Set-VMFirmware $VMName -EnableSecureBoot Off
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $False

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch ($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-GNU_Linux-Debian}
    	2{HPV-Copy_VM-Different-Blank-GNU_Linux-Debian}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Same-Blank-GNU_Linux-Debian
{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine
Write-Host "The name chosen for the virtual machine is " -NoNewLine 
Write-Host "$VMname" -NoNewLine -ForegroundColor green
Write-Host "."

	if($UseNetworkCard -eq $True){New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath" -SwitchName $SwitchName}else{New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath"}

Add-VMDvdDrive -VMName $VMName -Path "$isoPath"

$myVM=Get-VMFirmware $VMName
$HDD=$myVM.BootOrder[0]
$PXE=$myVM.BootOrder[1]
$DVD=$myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VMMemory $VMName -DynamicMemoryEnabled $False
Set-VMFirmware $VMName -EnableSecureBoot Off
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $False

Write-Host ""
Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch ($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-GNU_Linux-Debian}
    	2{HPV-Copy_VM-Different-Blank-GNU_Linux-Debian}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Different-Blank-GNU_Linux-Debian
{
HPV-New_VM-Blank-GNU_Linux-Debian
}

function HPV-New_VM-Blank-GNU_Linux-Ubuntu
{
[string]$script:isoPath=".\src\GNU_Linux\iso\ubuntu-22.04-beta-desktop-amd64.iso"
[string]$script:isoDest=".\src\GNU_Linux\iso"
[string]$script:isoFolderPath=".\src\GNU_Linux\iso"
[string]$script:isoSrc="https://ubuntu.univ-nantes.fr/ubuntu-cd/22.04/ubuntu-22.04-beta-desktop-amd64.iso"

[string]$script:VHDSPath=".\src\GNU_Linux\vhds\"
[string]$script:vmsPath=".\src\GNU_Linux\vms\"

HPV-New_VM-Blank-Template

	if($UseNetworkCard -eq $True){New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath" -SwitchName $SwitchName}else{New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath"}

Add-VMDvdDrive -VMName $VMName -Path "$isoPath"

$myVM=Get-VMFirmware $VMName
$HDD=$myVM.BootOrder[0]
$PXE=$myVM.BootOrder[1]
$DVD=$myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VMMemory $VMName -DynamicMemoryEnabled $False
Set-VMFirmware $VMName -EnableSecureBoot Off
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $False

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch ($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-GNU_Linux-Ubuntu}
    	2{HPV-Copy_VM-Different-Blank-GNU_Linux-Ubuntu}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Same-Blank-GNU_Linux-Ubuntu
{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine
Write-Host "The name chosen for the virtual machine is " -NoNewLine 
Write-Host "$VMname" -NoNewLine -ForegroundColor green
Write-Host "."

	if($UseNetworkCard -eq $True){New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath" -SwitchName $SwitchName}else{New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath"}

Add-VMDvdDrive -VMName $VMName -Path "$isoPath"

$myVM=Get-VMFirmware $VMName
$HDD=$myVM.BootOrder[0]
$PXE=$myVM.BootOrder[1]
$DVD=$myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VMMemory $VMName -DynamicMemoryEnabled $False
Set-VMFirmware $VMName -EnableSecureBoot Off
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $False

Write-Host ""
Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch ($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-GNU_Linux-Ubuntu}
    	2{HPV-Copy_VM-Different-Blank-GNU_Linux-Ubuntu}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Different-Blank-GNU_Linux-Ubuntu
{
HPV-New_VM-Blank-GNU_Linux-Ubuntu
}

function HPV-New_VM-Blank-GNU_Linux-Rocky_Linux-Full
{
[string]$script:isoPath=".\src\GNU_Linux\iso\Rocky-8.5-x86_64-dvd1.iso"
[string]$script:isoDest=".\src\GNU_Linux\iso"
[string]$script:isoFolderPath=".\src\GNU_Linux\iso"
[string]$script:isoSrc="https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.5-x86_64-dvd1.iso"

[string]$script:VHDSPath=".\src\GNU_Linux\vhds\"
[string]$script:vmsPath=".\src\GNU_Linux\vms\"

HPV-New_VM-Blank-Template

	if($UseNetworkCard -eq $True){New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath" -SwitchName $SwitchName}else{New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath"}

Add-VMDvdDrive -VMName $VMName -Path "$isoPath"

$myVM=Get-VMFirmware $VMName
$HDD=$myVM.BootOrder[0]
$PXE=$myVM.BootOrder[1]
$DVD=$myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VMMemory $VMName -DynamicMemoryEnabled $False
Set-VMFirmware $VMName -EnableSecureBoot Off
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $False

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch ($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-GNU_Linux-Rocky_Linux-Full}
    	2{HPV-Copy_VM-Different-Blank-GNU_Linux-Rocky_Linux-Full}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Same-Blank-GNU_Linux-Rocky_Linux-Full
{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine
Write-Host "The name chosen for the virtual machine is " -NoNewLine 
Write-Host "$VMname" -NoNewLine -ForegroundColor green
Write-Host "."

	if($UseNetworkCard -eq $True){New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath" -SwitchName $SwitchName}else{New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath"}

Add-VMDvdDrive -VMName $VMName -Path "$isoPath"

$myVM=Get-VMFirmware $VMName
$HDD=$myVM.BootOrder[0]
$PXE=$myVM.BootOrder[1]
$DVD=$myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VMMemory $VMName -DynamicMemoryEnabled $False
Set-VMFirmware $VMName -EnableSecureBoot Off
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $False

Write-Host ""
Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch ($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-GNU_Linux-Rocky_Linux-Full}
    	2{HPV-Copy_VM-Different-Blank-GNU_Linux-Rocky_Linux-Full}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Different-Blank-GNU_Linux-Rocky_Linux-Full
{
HPV-New_VM-Blank-GNU_Linux-Rocky_Linux-Full
}

function HPV-New_VM-Blank-GNU_Linux-Rocky_Linux-Minimal
{
[string]$script:isoPath=".\src\GNU_Linux\iso\Rocky-8.5-x86_64-minimal.iso"
[string]$script:isoDest=".\src\GNU_Linux\iso"
[string]$script:isoFolderPath=".\src\GNU_Linux\iso"
[string]$script:isoSrc="https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.5-x86_64-minimal.iso"

[string]$script:VHDSPath=".\src\GNU_Linux\vhds\"
[string]$script:vmsPath=".\src\GNU_Linux\vms\"

HPV-New_VM-Blank-Template

	if($UseNetworkCard -eq $True){New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath" -SwitchName $SwitchName}else{New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath"}

Add-VMDvdDrive -VMName $VMName -Path "$isoPath"

$myVM=Get-VMFirmware $VMName
$HDD=$myVM.BootOrder[0]
$PXE=$myVM.BootOrder[1]
$DVD=$myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VMMemory $VMName -DynamicMemoryEnabled $False
Set-VMFirmware $VMName -EnableSecureBoot Off
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $False

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch ($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-GNU_Linux-Rocky_Linux-Minimal}
    	2{HPV-Copy_VM-Different-Blank-GNU_Linux-Rocky_Linux-Minimal}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Same-Blank-GNU_Linux-Rocky_Linux-Minimal
{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine
Write-Host "The name chosen for the virtual machine is " -NoNewLine 
Write-Host "$VMname" -NoNewLine -ForegroundColor green
Write-Host "."

	if($UseNetworkCard -eq $True){New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath" -SwitchName $SwitchName}else{New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath"}

Add-VMDvdDrive -VMName $VMName -Path "$isoPath"

$myVM=Get-VMFirmware $VMName
$HDD=$myVM.BootOrder[0]
$PXE=$myVM.BootOrder[1]
$DVD=$myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VMMemory $VMName -DynamicMemoryEnabled $False
Set-VMFirmware $VMName -EnableSecureBoot Off
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $False

Write-Host ""
Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch ($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-GNU_Linux-Rocky_Linux-Minimal}
    	2{HPV-Copy_VM-Different-Blank-GNU_Linux-Rocky_Linux-Minimal}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Different-Blank-GNU_Linux-Rocky_Linux-Minimal
{
HPV-New_VM-Blank-GNU_Linux-Rocky_Linux-Minimal
}

function HPV-New_VM-Blank-GNU_Linux-Parrot_Security
{
[string]$script:isoPath=".\src\GNU_Linux\iso\Parrot-security-5.0_amd64.iso"
[string]$script:isoDest=".\src\GNU_Linux\iso"
[string]$script:isoFolderPath=".\src\GNU_Linux\iso"
[string]$script:isoSrc="https://bunny.deb.parrot.sh/parrot/iso/5.0/Parrot-security-5.0_amd64.iso"

[string]$script:VHDSPath=".\src\GNU_Linux\vhds\"
[string]$script:vmsPath=".\src\GNU_Linux\vms\"

HPV-New_VM-Blank-Template

	if($UseNetworkCard -eq $True){New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath" -SwitchName $SwitchName}else{New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath"}

Add-VMDvdDrive -VMName $VMName -Path "$isoPath"

$myVM=Get-VMFirmware $VMName
$HDD=$myVM.BootOrder[0]
$PXE=$myVM.BootOrder[1]
$DVD=$myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VMMemory $VMName -DynamicMemoryEnabled $False
Set-VMFirmware $VMName -EnableSecureBoot Off
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $False

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch ($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-GNU_Linux-Parrot_Security}
    	2{HPV-Copy_VM-Different-Blank-GNU_Linux-Parrot_Security}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Same-Blank-GNU_Linux-Parrot_Security
{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine
Write-Host "The name chosen for the virtual machine is " -NoNewLine 
Write-Host "$VMname" -NoNewLine -ForegroundColor green
Write-Host "."

	if($UseNetworkCard -eq $True){New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath" -SwitchName $SwitchName}else{New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath"}

Add-VMDvdDrive -VMName $VMName -Path "$isoPath"

$myVM=Get-VMFirmware $VMName
$HDD=$myVM.BootOrder[0]
$PXE=$myVM.BootOrder[1]
$DVD=$myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VMMemory $VMName -DynamicMemoryEnabled $False
Set-VMFirmware $VMName -EnableSecureBoot Off
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $False

Write-Host ""
Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch ($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-GNU_Linux-Parrot_Security}
    	2{HPV-Copy_VM-Different-Blank-GNU_Linux-Parrot_Security}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Different-Blank-GNU_Linux-Parrot_Security
{
HPV-New_VM-Blank-GNU_Linux-Parrot_Security
}

function HPV-New_VM-Blank-GNU_Linux-Kali_Linux-Live
{
[string]$script:isoPath=".\src\GNU_Linux\iso\kali-linux-2022.1-live-amd64.iso"
[string]$script:isoDest=".\src\GNU_Linux\iso"
[string]$script:isoFolderPath=".\src\GNU_Linux\iso"
[string]$script:isoSrc="https://cdimage.kali.org/kali-images/current/kali-linux-2022.1-live-amd64.iso"

[string]$script:VHDSPath=".\src\GNU_Linux\vhds\"
[string]$script:vmsPath=".\src\GNU_Linux\vms\"

HPV-New_VM-Blank-Template

	if($UseNetworkCard -eq $True){New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath" -SwitchName $SwitchName}else{New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath"}

Add-VMDvdDrive -VMName $VMName -Path "$isoPath"

$myVM=Get-VMFirmware $VMName
$HDD=$myVM.BootOrder[0]
$PXE=$myVM.BootOrder[1]
$DVD=$myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VMMemory $VMName -DynamicMemoryEnabled $False
Set-VMFirmware $VMName -EnableSecureBoot Off
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $False

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch ($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-GNU_Linux-Kali_Linux-Live}
    	2{HPV-Copy_VM-Different-Blank-GNU_Linux-Kali_Linux-Live}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Same-Blank-GNU_Linux-Kali_Linux-Live
{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine
Write-Host "The name chosen for the virtual machine is " -NoNewLine 
Write-Host "$VMname" -NoNewLine -ForegroundColor green
Write-Host "."

	if($UseNetworkCard -eq $True){New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath" -SwitchName $SwitchName}else{New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath"}

Add-VMDvdDrive -VMName $VMName -Path "$isoPath"

$myVM=Get-VMFirmware $VMName
$HDD=$myVM.BootOrder[0]
$PXE=$myVM.BootOrder[1]
$DVD=$myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VMMemory $VMName -DynamicMemoryEnabled $False
Set-VMFirmware $VMName -EnableSecureBoot Off
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $False

Write-Host ""
Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch ($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-GNU_Linux-Kali_Linux-Live}
    	2{HPV-Copy_VM-Different-Blank-GNU_Linux-Kali_Linux-Live}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Different-Blank-GNU_Linux-Kali_Linux-Live
{
HPV-New_VM-Blank-GNU_Linux-Kali_Linux-Live
}

function HPV-New_VM-Blank-GNU_Linux-Kali_Linux-Installer
{
[string]$script:isoPath=".\src\GNU_Linux\iso\kali-linux-2022.1-installer-amd64.iso"
[string]$script:isoDest=".\src\GNU_Linux\iso"
[string]$script:isoFolderPath=".\src\GNU_Linux\iso"
[string]$script:isoSrc="https://cdimage.kali.org/kali-images/current/kali-linux-2022.1-installer-amd64.iso"

[string]$script:VHDSPath=".\src\GNU_Linux\vhds\"
[string]$script:vmsPath=".\src\GNU_Linux\vms\"

HPV-New_VM-Blank-Template

	if($UseNetworkCard -eq $True){New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath" -SwitchName $SwitchName}else{New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath"}

Add-VMDvdDrive -VMName $VMName -Path "$isoPath"

$myVM=Get-VMFirmware $VMName
$HDD=$myVM.BootOrder[0]
$PXE=$myVM.BootOrder[1]
$DVD=$myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VMMemory $VMName -DynamicMemoryEnabled $False
Set-VMFirmware $VMName -EnableSecureBoot Off
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $False

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch ($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-GNU_Linux-Kali_Linux-Installer}
    	2{HPV-Copy_VM-Different-Blank-GNU_Linux-Kali_Linux-Installer}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Same-Blank-GNU_Linux-Kali_Linux-Installer
{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine
Write-Host "The name chosen for the virtual machine is " -NoNewLine 
Write-Host "$VMname" -NoNewLine -ForegroundColor green
Write-Host "."

	if($UseNetworkCard -eq $True){New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath" -SwitchName $SwitchName}else{New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath"}

Add-VMDvdDrive -VMName $VMName -Path "$isoPath"

$myVM=Get-VMFirmware $VMName
$HDD=$myVM.BootOrder[0]
$PXE=$myVM.BootOrder[1]
$DVD=$myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VMMemory $VMName -DynamicMemoryEnabled $False
Set-VMFirmware $VMName -EnableSecureBoot Off
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $False

Write-Host ""
Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch ($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-GNU_Linux-Kali_Linux-Installer}
    	2{HPV-Copy_VM-Different-Blank-GNU_Linux-Kali_Linux-Installer}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Different-Blank-GNU_Linux-Kali_Linux-Installer
{
HPV-New_VM-Blank-GNU_Linux-Kali_Linux-Installer
}

function HPV-New_VM-Template
{
Clear-Host
Write-Host "Info: " -NoNewLine
Write-Host "This feature is currently under development." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to main menu.`n" -ForegroundColor darkred;pause;main
}

function HPV-VM_Management
{
Clear-Host
Write-Host "1 - Display the list of virtual machines."
Write-Host ""
Write-Host "2 - Start one or more virtual machines."
Write-Host "3 - Start all virtual machines."
Write-Host ""
Write-Host "4 - Shut down one or more virtual machines."
Write-Host "5 - Turn off all virtual machines (that are switched on)."
Write-Host ""
Write-Host "6 - Delete (completely, with its hard disk) one or more virtual machines."
Write-Host "7 - ICBM (Intercontinental ballistic missile): Massive destruction, cleaning up by deleting all virtual machines and their data."
Write-Host ""
Write-Host "8 - Go back to the main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	1{HPV-Show_VMs}

    	2{HPV-Start_VM}
    	3{HPV-Start_All_VMs}
    	
    	4{HPV-Shut_Down_VMs}
    	5{HPV-Shut_Down_All_VMs}

    	6{HPV-Remove_VMs}
    	7{HPV-Remove_All_VMs}
    
    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}
}

function HPV-Show_VMs
{
Clear-Host
Write-Host "Ongoing action: " -NoNewLine;Write-Host "Displaying the list of virtual machines.`n"

$Get_VM=Get-VM|Select-Object -Property Name,State,Uptime,Status|Out-Default;pause

Write-Host ""
Write-Host "7 - Return to the virtual machine(s) management menu."
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{   
    	7{HPV-VM_Management}
    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Start_VM
{
Clear-Host
Write-Host "Ongoing action: " -NoNewLine
Write-Host "Displays a list of currently powered-off virtual machines.`n"

$Get_VM=Get-VM|Where{$_.State -eq 'Off'}
$VMsList=@()
$Get_VM|ForEach-Object{$VMsList+=$_.Name}

For($i=0;$i -lt $VMsList.Length;$i++){Write-Host "$i - $($VMsList[$i])"}

$userChoice=Read-Host "`nWhich machine do you want to start"
$VMuserChoice=$VMsList[$userChoice]
$Selected_VM=$VMuserChoice
Write-Host "`nInfo: " -NoNewLine
Write-Host "The selected virtual machine is " -NoNewLine
Write-Host "$Selected_VM" -NoNewLine -ForegroundColor green
Write-Host "."

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Starting the virtual machine." -ForegroundColor green
Start-VM -Name $Selected_VM

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Display the list of currently running virtual machines."
Get-VM|Where{$_.State -eq 'Running'}|Out-Default;pause

Write-Host ""
Write-Host "6 - Boot another virtual machine."
Write-Host ""
Write-Host "7 - Return to the virtual machine(s) management menu."
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
		6{HPV-Start_VM}

    	7{HPV-VM_Management}
    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Start_All_VMs
{
Clear-Host
Write-Host "Ongoing action: " -NoNewLine
Write-Host "Displays a list of currently powered-off virtual machines.`n"

$VMsList=@()

$Get_VM=Get-VM|Where{$_.State -eq 'Off'}
$Get_VM|ForEach-Object{$VMsList+=$_.Name}

ForEach($VM in $VMsList){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Starting the virtual machine " -NoNewLine;Write-Host "$VM" -ForegroundColor green;Start-VM -Name $VM}

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Display the list of currently running virtual machines."
Get-VM|Where{$_.State -eq 'Running'}|Out-Default;pause

Write-Host ""
Write-Host "7 - Return to the virtual machine(s) management menu."
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	7{HPV-VM_Management}
    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Shut_Down_VMs
{
Clear-Host
Write-Host "Ongoing action: " -NoNewLine
Write-Host "Display the list of currently running virtual machines.`n"

$Get_VM=Get-VM|Where{$_.State -eq 'Running'}
$VMsList=@()
$Get_VM|ForEach-Object{$VMsList+=$_.Name}

For($i=0;$i -lt $VMsList.Length;$i++){Write-Host "$i - $($VMsList[$i])"}

$userChoice=Read-Host "`nWhich machine do you want to switch off"
$VMuserChoice=$VMsList[$userChoice]
$Selected_VM=$VMuserChoice
Write-Host "`nInfo: " -NoNewLine
Write-Host "The selected virtual machine is " -NoNewLine
Write-Host "$Selected_VM" -NoNewLine -ForegroundColor green
Write-Host "."

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Switching off of the machine." -ForegroundColor green
Start-VM -Name $Selected_VM -Force

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Displays a list of currently powered-off virtual machines."
Get-VM|Where{$_.State -eq 'Off'}|Out-Default;pause

Write-Host ""
Write-Host "6 - Shut down another virtual machine."
Write-Host ""
Write-Host "7 - Return to the virtual machine(s) management menu."
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
		6{HPV-Shut_Down_VMs}

    	7{HPV-VM_Management}
    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Shut_Down_All_VMs
{
Clear-Host
Write-Host "Ongoing action: " -NoNewLine
Write-Host "Display the list of currently running virtual machines.`n"

$VMsList=@()

$Get_VM=Get-VM|Where{$_.State -eq 'Running'}
$Get_VM|ForEach-Object{$VMsList+=$_.Name}

ForEach($VM in $VMsList){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Switching off of the machine " -NoNewLine;Write-Host "$VM" -ForegroundColor green;Stop-VM -Name $VM -Force}

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Displays a list of currently powered-off virtual machines."
Get-VM|Where{$_.State -eq 'Off'}|Out-Default;pause

Write-Host ""
Write-Host "7 - Return to the virtual machine(s) management menu."
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	7{HPV-VM_Management}
    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Remove_VMs
{
Clear-Host
Write-Host "Ongoing action: " -NoNewLine
Write-Host "Display the list of virtual machines.`n"

$Get_VM=Get-VM
$VMsList=@()
$Get_VM|ForEach-Object{$VMsList+=$_.Name}

For($i=0;$i -lt $VMsList.Length;$i++){Write-Host "$i - $($VMsList[$i])"}

$userChoice=Read-Host "`nWhich machine do you want to delete with its data"
$VMuserChoice=$VMsList[$userChoice]
$Selected_VM=$VMuserChoice
Write-Host "`nInfo: " -NoNewLine
Write-Host "The selected virtual machine is " -NoNewLine
Write-Host "$Selected_VM" -NoNewLine -ForegroundColor green
Write-Host "."

$Is_On=Get-VM -Name $Selected_VM|Where{$_.State -eq 'Running'}
if($Is_On -eq $null){$null}else{Write-Host "`nInfo" -NoNewLine;Write-Host "The machine is obviously currently switched on." -ForegroundColor darkred;Write-Host "`nOngoing action:" -NoNewLine;Write-Host "Switching off of the machine." -ForegroundColor green;Stop-VM -Name $Selected_VM -Force}

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Displays a list of currently powered-off virtual machines."
Get-VM|Where{$_.State -eq 'Off'}|Out-Default;pause

Remove-VM -Name $Selected_VM -Force

$VMPath=Get-ChildItem -Path . -Filter $Selected_VM -Recurse|%{$_.FullName}
[void](Remove-Item -Path $VMPath -Force -Recurse)

$Selected_VHDX=$Selected_VM+".vhdx"
$VHDXPath=Get-ChildItem -Path . -Filter $Selected_VHDX -Recurse|%{$_.FullName}
[void](Remove-Item -Path $VHDXPath -Force -Recurse)

Write-Host ""
Write-Host "6 - Delete another machine."
Write-Host ""
Write-Host "7 - Return to the virtual machine(s) management menu."
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
		6{HPV-Remove_VMs}

    	7{HPV-VM_Management}
    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Remove_All_VMs
{
Clear-Host
Write-Host "Ongoing action: " -NoNewLine
Write-Host "Start the process of deleting virtual machines.`n"

$VMsList=@{}
$Get_VM=Get-VM|Where{$_.State -eq 'Off'}
$VMsList=($Get_VM).Name

ForEach($VM in $VMsList){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Switching off of the machine " -NoNewLine;Write-Host "$VM" -ForegroundColor green;Stop-VM -Name $VM -Force -WarningAction SilentlyContinue}

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Displays a list of currently powered-off virtual machines."
Get-VM|Where{$_.State -eq 'Off'}|Out-Default;Write-Host ""

ForEach($VM in $VMsList){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Removing the virtual machine " -NoNewLine;Write-Host "$VM" -ForegroundColor green;Remove-VM -Name $VM -Force}

$VHDXList=@()
$VHDXPath=Get-ChildItem -Path . -Filter *.vhdx -Recurse|%{$_.FullName}
$VHDXList=$VHDXPath
ForEach($VHDX in $VHDXList){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Deletion of the virtual hard disk " -NoNewLine;Write-Host "$VHDX" -ForegroundColor green;[void](Remove-Item -Path $VHDX -Force -Recurse)}

## TODO: Improve the logic.
[void](Remove-Item -Path ".\src\Microsoft_Windows\clients\vms\*" -Force -Recurse -ErrorAction SilentlyContinue -WarningAction SilentlyContinue -InformationAction SilentlyContinue)

[void](Remove-Item -Path ".\src\Microsoft_Windows\servers\vms\*" -Force -Recurse -ErrorAction SilentlyContinue -WarningAction SilentlyContinue -InformationAction SilentlyContinue)

[void](Remove-Item -Path ".\src\GNU_Linux\vms\*" -Force -Recurse -ErrorAction SilentlyContinue -WarningAction SilentlyContinue -InformationAction SilentlyContinue)

Write-Host ""
Write-Host "6 - Delete another machine."
Write-Host ""
Write-Host "7 - Return to the virtual machine(s) management menu."
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
		6{HPV-Remove_VMs}

    	7{HPV-VM_Management}
    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Virtual_Switches_Management
{
Clear-Host
Write-Host "1 - Display the list of virtual switches."
Write-Host ""
Write-Host "2 - Create a virtual switch."
Write-Host "3 - Delete a virtual switch."
Write-Host ""
Write-Host "8 - Go back to the main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	1{HPV-Show_Virtual_VSwitches}

    	2{HPV-New_VSwitch}
    	3{HPV-Remove_VSwitch}
    
    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Show_Virtual_VSwitches
{
Clear-Host
Write-Host "Ongoing action: " -NonewLine
Write-Host "Display the list of virtual switches.`n"

Get-VMSwitch|Out-Default;pause;Write-Host ""

Write-Host "7 - Return to the virtual switch management menu."
Write-Host "8 - Go back to the main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
		7{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Return to the virtual switch management menu.`n" -ForegroundColor red;pause;HPV-Virtual_Switches_Management}
    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-New_VSwitch
{
Clear-Host
$Switch_Name=Read-Host "What name would you like to choose for your network switch"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for your virtual switch is " -NoNewLine;Write-Host "$Switch_Name" -NoNewLine -ForegroundColor green;Write-Host "."

Write-Host "`nWhat type of virtual switch do you want to create?`n"
Write-Host "1 - Internal"
Write-Host "2 - Private`n"
[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
		1{[string]$Switch_Type="Internal"}
		2{[string]$Switch_Type="Private"}
	}

New-VMSwitch -Name $Switch_Name -SwitchType $Switch_Type|Out-Null

Get-VMSwitch|Select-Object Name,SwitchType|Out-Default

Write-Host "7 - Return to the virtual switch management menu."
Write-Host "8 - Go back to the main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
		7{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Return to the virtual switch management menu.`n" -ForegroundColor red;pause;HPV-Virtual_Switches_Management}
    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Remove_VSwitch
{
Clear-Host
Write-Host "Ongoing action: " -NoNewLine
Write-Host "Displaying the list of virtual switches.`n"

$Get_VSwitches=Get-VMSwitch
$VSwitchesList=@()
$Get_VSwitches|ForEach-Object{$VSwitchesList+=$_.Name}

For($i=0;$i -lt $VSwitchesList.Length;$i++){Write-Host "$i - $($VSwitchesList[$i])"}

$userChoice=Read-Host "`nWhich virtual switch do you want to remove"
$VSwitchChoice=$VSwitchesList[$userChoice]
$Selected_Switch=$VSwitchChoice
Write-Host "`nInfo: " -NoNewLine
Write-Host "The chosen virtual switch is " -NoNewLine
Write-Host "$Selected_Switch" -NoNewLine -ForegroundColor green
Write-Host "."

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Deletion of the virtual switch." -ForegroundColor green
Remove-VMSwitch -Name $Selected_Switch -Force

Write-Host ""
Write-Host "6 - Delete another virtual switch."
Write-Host ""
Write-Host "7 - Return to the virtual switch management menu."
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
		6{HPV-Remove_VSwitch}

    	7{HPV-Virtual_Switches_Management}
    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function Resource_Management
{
Clear-Host
Write-Host "1 - Download all the resources (the advantage is that you will significantly optimize your time when creating new machines because all the resources will already be present and available, there will not be a single second of waiting, the disadvantage is that this downloading step may take a considerable amount of time)."
Write-Host ""
Write-Host "2 - Download resources for creating Windows virtual machines only."
Write-Host "3 - Download resources for creating Linux virtual machines only."
Write-Host ""
Write-Host "4 - Fully customized download program (the founder of Hyper-V Toolbox recommends this solution)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	1{HPV-Download_All_Resources}
    	2{HPV-Download_All_Windows_Resources}
    	3{HPV-Download_All_Linux_Resources}
    	4{HPV-Download_Custom_Resources}
    
    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Download_Base
{
	param
    (
    	[string]$isoPath=".\src\OS\iso\name.iso",
		[string]$isoDest=".\src\OS\iso",
		[string]$isoFolderPath=".\src\Microsoft_Windows\clients\iso",
		[string]$isoSrc="https://name.com/name.iso"
    )

Write-Host "Ongoing action: " -NoNewLine
Write-Host "Verification of required resources (and automatic decision making)."
	if(Test-Path $isoPath)
	{
		Write-Host "Info: " -NoNewLine
		Write-Host "The resource corresponding to your request has been identified." -ForegroundColor green
	}else{
		Write-Host "Info: " -NoNewLine
		Write-Host "The corresponding resource could not be identified or an unexpected error was caused during the identification phase." -ForegroundColor darkred
		Write-Host "`nOngoing action: " -NoNewLine
		Write-Host "Automated launch of the download of the corresponding resources.`n" -NoNewLine

			if(Test-Path $isoDest){$null}else{[void](New-Item -Path $isoFolderPath -ItemType Directory -Force)}

	Start-BitsTransfer -Source $isoSrc -Destination $isoDest -DisplayName "Hyper-V_Toolbox - Downloading function - Franck FERMAN." -Description "Download of the corresponding resource in progress."

	if(Test-Path $isoPath){Write-Host "`nInfo: " -NoNewLine;Write-Host "Download successfully completed." -ForegroundColor green}else{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused." -ForegroundColor darkred;Write-Host "Ongoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor darkred;pause;main}
	}

}

function HPV-Download_All_Resources
{
Clear-Host
Write-Host "Ongoing action: " -NoNewLine
Write-Host "Start the general download process."
Write-Host ""

Write-Host "Ongoing action: " -NoNewLine
Write-Host "Start the Linux resource download process."
Write-Host ""

Write-Host "Ongoing action: " -NoNewLine
Write-Host "Launching the pfSense ISO download process."
Write-Host ""
HPV-Download_Base ".\src\GNU_Linux\iso\pfSense-CE-2.5.1-RELEASE-amd64.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://images-data.fra1.digitaloceanspaces.com/pfSense-CE-2.5.1-RELEASE-amd64.iso"

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Launching the Debian ISO download process."
Write-Host ""
HPV-Download_Base ".\src\GNU_Linux\iso\debian-11.3.0-amd64-netinst.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.3.0-amd64-netinst.iso"

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Launching the Ubuntu ISO download process."
Write-Host ""
HPV-Download_Base ".\src\GNU_Linux\iso\ubuntu-22.04-beta-desktop-amd64.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://ubuntu.univ-nantes.fr/ubuntu-cd/22.04/ubuntu-22.04-beta-desktop-amd64.iso"

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Launching the Rocky Linux (Full) ISO download process."
Write-Host ""
HPV-Download_Base ".\src\GNU_Linux\iso\Rocky-8.5-x86_64-dvd1.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.5-x86_64-dvd1.iso"

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Launching the Rocky Linux (Minimal) ISO download process."
Write-Host ""
HPV-Download_Base ".\src\GNU_Linux\iso\Rocky-8.5-x86_64-minimal.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.5-x86_64-minimal.iso"

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Launching the Parrot Security ISO download process."
Write-Host ""
HPV-Download_Base ".\src\GNU_Linux\iso\Parrot-security-5.0_amd64.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://bunny.deb.parrot.sh/parrot/iso/5.0/Parrot-security-5.0_amd64.iso"

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Launching the Kali Linux Live ISO download process."
Write-Host ""
HPV-Download_Base ".\src\GNU_Linux\iso\kali-linux-2022.1-live-amd64.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://cdimage.kali.org/kali-images/current/kali-linux-2022.1-live-amd64.iso"

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Launching the Kali Linux Installer ISO download process."
Write-Host ""
HPV-Download_Base ".\src\GNU_Linux\iso\kali-linux-2022.1-installer-amd64.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://cdimage.kali.org/kali-images/current/kali-linux-2022.1-installer-amd64.iso"

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Start the Windows resource download process."
Write-Host ""

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Launching the Windows 10 Enterprise ISO download process."
Write-Host ""
HPV-Download_Base ".\src\Microsoft_Windows\clients\iso\client-windows10-entreprise-ltsc.iso" ".\src\Microsoft_Windows\clients\iso" ".\src\Microsoft_Windows\clients\iso" "https://images-data.fra1.digitaloceanspaces.com/client-windows10-entreprise-ltsc.iso"

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Launching the Windows 10 Pro/Home/Education ISO download process."
Write-Host ""
HPV-Download_Base ".\src\Microsoft_Windows\clients\iso\client-windows10.iso" ".\src\Microsoft_Windows\clients\iso" ".\src\Microsoft_Windows\clients\iso" "https://images-data.fra1.digitaloceanspaces.com/client-windows10.iso"

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Launching the Windows Server 2012 ISO download process."
Write-Host ""
HPV-Download_Base ".\src\Microsoft_Windows\servers\iso\win_srv-2012.iso" ".\src\Microsoft_Windows\servers\iso" ".\src\Microsoft_Windows\servers\iso" "https://images-data.fra1.digitaloceanspaces.com/win_srv-2012.iso"

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Launching the Windows Server 2012 ISO download process."
Write-Host ""
HPV-Download_Base ".\src\Microsoft_Windows\servers\iso\win_srv-2019.iso" ".\src\Microsoft_Windows\servers\iso" ".\src\Microsoft_Windows\servers\iso" "https://images-data.fra1.digitaloceanspaces.com/win_srv-2019.iso"

Write-Host ""
Write-Host "7 - Return to the resource management menu."
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	7{Resource_Management}
    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Download_All_Windows_Resources
{
Clear-Host
Write-Host "Ongoing action: " -NoNewLine
Write-Host "Start the Windows resource download process."
Write-Host ""

Write-Host "Ongoing action: " -NoNewLine
Write-Host "Launching the Windows 10 Enterprise ISO download process."
Write-Host ""
HPV-Download_Base ".\src\Microsoft_Windows\clients\iso\client-windows10-entreprise-ltsc.iso" ".\src\Microsoft_Windows\clients\iso" ".\src\Microsoft_Windows\clients\iso" "https://images-data.fra1.digitaloceanspaces.com/client-windows10-entreprise-ltsc.iso"

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Launching the Windows 10 Pro/Home/Education ISO download process."
Write-Host ""
HPV-Download_Base ".\src\Microsoft_Windows\clients\iso\client-windows10.iso" ".\src\Microsoft_Windows\clients\iso" ".\src\Microsoft_Windows\clients\iso" "https://images-data.fra1.digitaloceanspaces.com/client-windows10.iso"

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Launching the Windows Server 2012 ISO download process."
Write-Host ""
HPV-Download_Base ".\src\Microsoft_Windows\servers\iso\win_srv-2012.iso" ".\src\Microsoft_Windows\servers\iso" ".\src\Microsoft_Windows\servers\iso" "https://images-data.fra1.digitaloceanspaces.com/win_srv-2012.iso"

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Launching the Windows Server 2012 ISO download process."
Write-Host ""
HPV-Download_Base ".\src\Microsoft_Windows\servers\iso\win_srv-2019.iso" ".\src\Microsoft_Windows\servers\iso" ".\src\Microsoft_Windows\servers\iso" "https://images-data.fra1.digitaloceanspaces.com/win_srv-2019.iso"

Write-Host ""
Write-Host "7 - Return to the resource management menu."
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	7{Resource_Management}
    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Download_All_Linux_Resources
{
Clear-Host
Write-Host "Ongoing action: " -NoNewLine
Write-Host "Start the Linux resource download process."
Write-Host ""

Write-Host "Ongoing action: " -NoNewLine
Write-Host "Launching the pfSense ISO download process."
Write-Host ""
HPV-Download_Base ".\src\GNU_Linux\iso\pfSense-CE-2.5.1-RELEASE-amd64.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://images-data.fra1.digitaloceanspaces.com/pfSense-CE-2.5.1-RELEASE-amd64.iso"

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Launching the Debian ISO download process."
Write-Host ""
HPV-Download_Base ".\src\GNU_Linux\iso\debian-11.3.0-amd64-netinst.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.3.0-amd64-netinst.iso"

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Launching the Ubuntu ISO download process."
Write-Host ""
HPV-Download_Base ".\src\GNU_Linux\iso\ubuntu-22.04-beta-desktop-amd64.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://ubuntu.univ-nantes.fr/ubuntu-cd/22.04/ubuntu-22.04-beta-desktop-amd64.iso"

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Launching the Rocky Linux (Full) ISO download process."
Write-Host ""
HPV-Download_Base ".\src\GNU_Linux\iso\Rocky-8.5-x86_64-dvd1.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.5-x86_64-dvd1.iso"

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Launching the Rocky Linux (Minimal) ISO download process."
Write-Host ""
HPV-Download_Base ".\src\GNU_Linux\iso\Rocky-8.5-x86_64-minimal.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.5-x86_64-minimal.iso"

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Launching the Parrot Security ISO download process."
Write-Host ""
HPV-Download_Base ".\src\GNU_Linux\iso\Parrot-security-5.0_amd64.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://bunny.deb.parrot.sh/parrot/iso/5.0/Parrot-security-5.0_amd64.iso"

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Launching the Kali Linux Live ISO download process."
Write-Host ""
HPV-Download_Base ".\src\GNU_Linux\iso\kali-linux-2022.1-live-amd64.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://cdimage.kali.org/kali-images/current/kali-linux-2022.1-live-amd64.iso"

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Launching the Kali Linux Installer ISO download process."
Write-Host ""
HPV-Download_Base ".\src\GNU_Linux\iso\kali-linux-2022.1-installer-amd64.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://cdimage.kali.org/kali-images/current/kali-linux-2022.1-installer-amd64.iso"

Write-Host ""
Write-Host "7 - Return to the resource management menu."
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	7{Resource_Management}
    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Download_Custom_Resources
{
Clear-Host
Write-Host "Ongoing action: " -NoNewLine
Write-Host "Launching the customization process."

Ask_YesOrNo "Question" "Would you like to install one or more Microsoft Windows machine(s)?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$DoIuse_Microsoft_Windows=$False}
	
		0{[bool]$DoIuse_Microsoft_Windows=$True

Ask_YesOrNo "Question" "Would you like to install Microsoft Windows Entreprise?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$DoIuse_Microsoft_Windows_Entreprise=$False}

		0{[bool]$DoIuse_Microsoft_Windows_Entreprise=$True}
	}

	Ask_YesOrNo "Question" "Would you like to install Microsoft Windows 10 Pro/Home/Education?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$DoIuse_Microsoft_Windows_Pro=$False}

		0{[bool]$DoIuse_Microsoft_Windows_Pro=$True}
	}

	Ask_YesOrNo "Question" "Would you like to install Microsoft Windows Server 2012?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$DoIuse_Microsoft_Windows_Server_2012=$False}

		0{[bool]$DoIuse_Microsoft_Windows_Server_2012=$True}
	}

	Ask_YesOrNo "Question" "Would you like to install Microsoft Windows Server 2019?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$DoIuse_Microsoft_Windows_Server_2019=$False}

		0{[bool]$DoIuse_Microsoft_Windows_Server_2019=$True}
	}
	
	}

	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}

	}

	Ask_YesOrNo "Question" "Would you like to install one or more GNU/Linux machine(s)?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$DoIuse_GNU_Linux=$False}
	
		0{[bool]$DoIuse_GNU_Linux=$True

	Ask_YesOrNo "Question" "Would you like to install pfSense?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$DoIuse_GNU_Linux_pfSense=$False}

		0{[bool]$DoIuse_GNU_Linux_pfSense=$True}
	}

	Ask_YesOrNo "Question" "Would you like to install Debian?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$DoIuse_GNU_Linux_Debian=$False}

		0{[bool]$DoIuse_GNU_Linux_Debian=$True}
	}

	Ask_YesOrNo "Question" "Would you like to install Ubuntu?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$DoIuse_GNU_Linux_Ubuntu=$False}

		0{[bool]$DoIuse_GNU_Linux_Ubuntu=$True}
	}

	Ask_YesOrNo "Question" "Would you like to install Rocky Linux (Full)?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$DoIuse_GNU_Linux_Rocky_Linux_Full=$False}

		0{[bool]$DoIuse_GNU_Linux_Rocky_Linux_Full=$True}
	}

	Ask_YesOrNo "Question" "Would you like to install Rocky Linux (Minimal)?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$DoIuse_GNU_Linux_Rocky_Linux_Minimal=$False}

		0{[bool]$DoIuse_GNU_Linux_Rocky_Linux_Minimal=$True}
	}

	Ask_YesOrNo "Question" "Would you like to install Parrot Security?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$DoIuse_GNU_Linux_Parrot_Security=$False}

		0{[bool]$DoIuse_GNU_Linux_Parrot_Security=$True}
	}

	Ask_YesOrNo "Question" "Would you like to install Kali Linux (Live)?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$DoIuse_GNU_Linux_Kali_Linux_Live=$False}

		0{[bool]$DoIuse_GNU_Linux_Kali_Linux_Live=$True}
	}

	Ask_YesOrNo "Question" "Would you like to install Kali Linux (Installer)?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$DoIuse_GNU_Linux_Kali_Linux_Installer=$False}

		0{[bool]$DoIuse_GNU_Linux_Kali_Linux_Installer=$True}
	}
	
	}

	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}

	}

if($DoIuse_Microsoft_Windows_Entreprise -eq $True){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Microsoft Windows Entreprise ISO download process.";Write-Host "";HPV-Download_Base ".\src\Microsoft_Windows\clients\iso\client-windows10-entreprise-ltsc.iso" ".\src\Microsoft_Windows\clients\iso" ".\src\Microsoft_Windows\clients\iso" "https://images-data.fra1.digitaloceanspaces.com/client-windows10-entreprise-ltsc.iso"}else{$null}

if($DoIuse_Microsoft_Windows_Pro -eq $True){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Microsoft Windows Pro ISO download process.";Write-Host "";HPV-Download_Base ".\src\Microsoft_Windows\clients\iso\client-windows10.iso" ".\src\Microsoft_Windows\clients\iso" ".\src\Microsoft_Windows\clients\iso" "https://images-data.fra1.digitaloceanspaces.com/client-windows10.iso"}else{$null}

if($DoIuse_Microsoft_Windows_Server_2012 -eq $True){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Microsoft Windows Server 2012 ISO download process.";Write-Host "";HPV-Download_Base ".\src\Microsoft_Windows\servers\iso\win_srv-2012.iso" ".\src\Microsoft_Windows\servers\iso" ".\src\Microsoft_Windows\servers\iso" "https://images-data.fra1.digitaloceanspaces.com/win_srv-2012.iso"}else{$null}

if($DoIuse_Microsoft_Windows_Server_2019 -eq $True){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Microsoft Windows Server 2019 ISO download process.";Write-Host "";HPV-Download_Base ".\src\Microsoft_Windows\servers\iso\win_srv-2019.iso" ".\src\Microsoft_Windows\servers\iso" ".\src\Microsoft_Windows\servers\iso" "https://images-data.fra1.digitaloceanspaces.com/win_srv-2019.iso"}else{$null}

if($DoIuse_GNU_Linux_pfSense -eq $True){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the pfSense ISO download process.";Write-Host "";HPV-Download_Base ".\src\GNU_Linux\iso\pfSense-CE-2.5.1-RELEASE-amd64.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://images-data.fra1.digitaloceanspaces.com/pfSense-CE-2.5.1-RELEASE-amd64.iso"}else{$null}

if($DoIuse_GNU_Linux_Debian -eq $True){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Debian ISO download process.";Write-Host "";HPV-Download_Base ".\src\GNU_Linux\iso\debian-11.3.0-amd64-netinst.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.3.0-amd64-netinst.iso"}else{$null}

if($DoIuse_GNU_Linux_Ubuntu -eq $True){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Ubuntu ISO download process.";Write-Host "";HPV-Download_Base ".\src\GNU_Linux\iso\ubuntu-22.04-beta-desktop-amd64.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://ubuntu.univ-nantes.fr/ubuntu-cd/22.04/ubuntu-22.04-beta-desktop-amd64.iso"}else{$null}

if($DoIuse_GNU_Linux_Rocky_Linux_Full -eq $True){HWrite-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Rocky Linux (Full) ISO download process.";Write-Host "";PV-Download_Base ".\src\GNU_Linux\iso\Rocky-8.5-x86_64-dvd1.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.5-x86_64-dvd1.iso"}else{$null}

if($DoIuse_GNU_Linux_Rocky_Linux_Minimal -eq $True){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Rocky Linux (Minimal) ISO download process.";Write-Host "";HPV-Download_Base ".\src\GNU_Linux\iso\Rocky-8.5-x86_64-minimal.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.5-x86_64-minimal.iso"}else{$null}

if($DoIuse_GNU_Linux_Parrot_Security -eq $True){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Parrot Security ISO download process.";Write-Host "";HPV-Download_Base ".\src\GNU_Linux\iso\Parrot-security-5.0_amd64.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://bunny.deb.parrot.sh/parrot/iso/5.0/Parrot-security-5.0_amd64.iso"}else{$null}

if($DoIuse_GNU_Linux_Kali_Linux_Live -eq $True){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Kali Linux Live ISO download process.";Write-Host "";HPV-Download_Base ".\src\GNU_Linux\iso\kali-linux-2022.1-live-amd64.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://cdimage.kali.org/kali-images/current/kali-linux-2022.1-live-amd64.iso"}else{$null}

if($DoIuse_GNU_Linux_Kali_Linux_Installer -eq $True){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Kali Linux Installer ISO download process.";Write-Host "";HPV-Download_Base ".\src\GNU_Linux\iso\kali-linux-2022.1-installer-amd64.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://cdimage.kali.org/kali-images/current/kali-linux-2022.1-installer-amd64.iso"}else{$null}

Write-Host ""
pause
Write-Host ""
Write-Host "7 - Return to the resource management menu."
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	7{Resource_Management}
    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Sorry, an unexpected error has been caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

Check_AdministratorRights