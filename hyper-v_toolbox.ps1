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
    	$true{main}
    	$false{Write-Host "Permission error, run the script with Administrator rights." -ForegroundColor darkred;exit}
    	default{Write-Host "An unexpected error was caused." -ForegroundColor darkred;exit}
	}

}

function Ask_YesOrNo
{
	Param
    (
    	[string]$title,
		[string]$message
    )

    $choiceYes=New-Object System.Management.Automation.Host.ChoiceDescription "&Yes","Yes"
    $choiceNo=New-Object System.Management.Automation.Host.ChoiceDescription "&No","No"
    $options=[System.Management.Automation.Host.ChoiceDescription[]]($choiceYes,$choiceNo)
    [int]$script:Ask_YesOrNo_Result=$host.ui.PromptForChoice($title,$message,$options,1)
}

function Get_Random
{
	Param
    (
    	[int]$FirstValue,
    	[int]$LastValue
    )

Get-Random -Minimum $FirstValue -Maximum $LastValue
}

function Under_Development
{
Clear-Host
Write-Host "Info: " -NoNewLine;Write-Host "This feature is currently under development." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to main menu.`n" -ForegroundColor darkred;pause;main
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
Write-Host "Hello dear " -NoNewline;Write-Host "$env:UserName " -NoNewline -ForegroundColor green;Write-Host "and welcome to "-NoNewLine;Write-Host "Hyper-V Toolbox"-NonewLine -ForegroundColor green;Write-Host "."
Write-Host ""
Write-Host "1 - Creation of (blank) virtual machine(s)."
Write-Host "2 - Creation of pre-configured virtual machine(s)."
Write-Host ""
Write-Host "3 - Management of virtual machine(s)."
Write-Host "4 - Management of virtual switch(es)."
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
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

<# Download links to the different resources.

## Microsoft Windows

# Windows 10 Entreprise
https://depository.fra1.digitaloceanspaces.com/ISO_images/Microsoft_Windows/client-windows10-entreprise-ltsc.iso

# Windows 10 Pro/Home/Education
https://depository.fra1.digitaloceanspaces.com/ISO_images/Microsoft_Windows/client-windows10.iso

# Windows Server 2012
https://depository.fra1.digitaloceanspaces.com/ISO_images/Microsoft_Windows/win_srv-2012.iso

# Windows Server 2016
https://depository.fra1.digitaloceanspaces.com/ISO_images/Microsoft_Windows/win_srv-2016.iso

# Windows Server 2019
https://depository.fra1.digitaloceanspaces.com/ISO_images/Microsoft_Windows/win_srv-2019.iso

## GNU_Linux

# pfSense
https://depository.fra1.digitaloceanspaces.com/ISO_images/GNU_Linux/pfSense-CE-2.5.1-RELEASE-amd64.iso

# Debian
https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.3.0-amd64-netinst.iso

# Rocky Linux
https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.5-x86_64-dvd1.iso
https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.5-x86_64-minimal.iso

https://repo.ialab.dsu.edu/rocky-linux/8.5/isos/x86_64/Rocky-8.5-x86_64-dvd1.iso
https://repo.ialab.dsu.edu/rocky-linux/8.5/isos/x86_64/Rocky-8.5-x86_64-minimal.iso

https://mirror.chpc.utah.edu/pub/rocky/8.5/isos/x86_64/Rocky-8.5-x86_64-dvd1.iso
https://mirror.chpc.utah.edu/pub/rocky/8.5/isos/x86_64/Rocky-8.5-x86_64-minimal.iso

# Arch Linux
https://ftp.u-strasbg.fr/linux/distributions/archlinux/iso/2022.04.05/archlinux-2022.04.05-x86_64.iso

http://archlinux.mirrors.ovh.net/archlinux/iso/2022.04.05/archlinux-2022.04.05-x86_64.iso
https://mir.archlinux.fr/iso/2022.04.05/archlinux-2022.04.05-x86_64.iso
https://mirroir.labhouse.fr/arch/iso/2022.04.05/archlinux-2022.04.05-x86_64.iso

https://mirror.arizona.edu/archlinux/iso/2022.04.05/archlinux-2022.04.05-x86_64.iso
https://mirror.arizona.edu/archlinux/iso/2022.04.05/archlinux-2022.04.05-x86_64.iso
https://mirror.clarkson.edu/archlinux/iso/2022.04.05/archlinux-2022.04.05-x86_64.iso
https://mirror.clarkson.edu/archlinux/iso/2022.04.05/archlinux-2022.04.05-x86_64.iso

# Ubuntu
https://ubuntu.univ-nantes.fr/ubuntu-cd/jammy/ubuntu-22.04-beta-desktop-amd64.iso
https://ubuntu.univ-nantes.fr/ubuntu-cd/focal/ubuntu-20.04.4-desktop-amd64.iso
https://ubuntu.univ-nantes.fr/ubuntu-cd/bionic/ubuntu-18.04.6-desktop-amd64.iso

# Parrot Security
https://bunny.deb.parrot.sh/parrot/iso/5.0/Parrot-security-5.0_amd64.iso

# Kali Linux
https://cdimage.kali.org/kali-images/current/kali-linux-2022.1-live-amd64.iso
https://cdimage.kali.org/kali-images/current/kali-linux-2022.1-installer-amd64.iso
#>

<### ### ### ### ### ### ### ### ### ### ###
### Creation of (blank) virtual machine(s). ###
### ### ### ### ### ### ### ### ### ### ###>

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
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
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
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-New_VM-Blank-Template
{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for the virtual machine is " -NoNewLine ;Write-Host "$VMname" -NoNewLine -ForegroundColor green;Write-Host "."

Ask_YesOrNo "Hyper-V Toolbox - MessageBox function - Franck FERMAN." "Would you like to add a network card to your virtual machine?"

	switch($Ask_YesOrNo_Result)
	{
	1{[bool]$script:UseNetworkCard=$false}
	
	0{
	[bool]$script:UseNetworkCard=$true
	[array]$VMsList=@()
	Get-VMSwitch|ForEach-Object{$VMsList+=$_.Name}
	
	Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Display the list of virtual switches.`n"
	For($i=0;$i -lt $VMsList.Length;$i++){Write-Host "$i - $($VMsList[$i])"}
	
	[int]$userChoice=Read-Host "`nWhich virtual switch do you want to set up on your virtual machine"
	[string]$VMchoice=$VMsList[$userChoice]
	[string]$script:SwitchName=$VMchoice
	Write-Host "Info: " -NoNewLine;Write-Host "The chosen virtual switch is " -NoNewLine;Write-Host "$SwitchName" -NoNewLine -ForegroundColor green;Write-Host "."
	}

	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Verification of required resources (and automatic decision making)."
	if(Test-Path $isoPath)
	{
		Write-Host "Info: " -NoNewLine;Write-Host "The resource corresponding to your request has been identified." -ForegroundColor green
	}else{
		Write-Host "Info: " -NoNewLine;Write-Host "The corresponding resource could not be identified or an unexpected error was caused during the identification phase." -ForegroundColor darkred
		Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Automated launch of the download of the corresponding resources.`n" -NoNewLine

	if(Test-Path $isoDest){$null}else{[void](New-Item -Path $isoFolderPath -ItemType Directory -Force)}

	Start-BitsTransfer -Source $isoSrc -Destination $isoDest -DisplayName "Hyper-V_Toolbox - Downloading function - Franck FERMAN." -Description "Download of the corresponding resource in progress."

	if(Test-Path $isoPath){Write-Host "`nInfo: " -NoNewLine;Write-Host "Download successfully completed." -ForegroundColor green}else{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused." -ForegroundColor darkred;Write-Host "`nOngoing action:" -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor darkred;pause;main}
	}

$RAMgbSizeList=@('1GB','2GB','4GB','8GB')
Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Display the list of choices concerning the available RAM on your virtual machine.`n"
For($i=0;$i -lt $RAMgbSizeList.Length;$i++){Write-Host "$i - $($RAMgbSizeList[$i])"}

[int]$userChoice=Read-Host "`nWhat quantity do you want to choose for your virtual machine"
$RAMgbSizeUserChoice=$RAMgbSizeList[$userChoice]
$RAMgbSize=$RAMgbSizeUserChoice
Write-Host "Info: " -NoNewLine;Write-Host "The chosen memory startup bytes is " -NoNewLine;Write-Host "$RAMgbSize" -NoNewLine -ForegroundColor green;Write-Host "."

    switch($RAMgbSize)
    {
        "1GB"{[Int64]$script:RAMgbSize=1GB}
        "2GB"{[Int64]$script:RAMgbSize=2GB}
        "4GB"{[Int64]$script:RAMgbSize=4GB}
        "8GB"{[Int64]$script:RAMgbSize=8GB}
    }

$VHDgbSizeList=@('16GB','20GB','32GB','48GB','64GB','80GB','120GB')
Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Display of the list of choices regarding the desired hard disk size for your virtual machine.`n"
For($i=0;$i -lt $VHDgbSizeList.Length;$i++){Write-Host "$i - $($VHDgbSizeList[$i])"}

[int]$userChoice=Read-Host "`nWhat size hard drive do you want for your virtual machine"
$VHDgbSizeUserChoice=$VHDgbSizeList[$userChoice]
$VHDgbSize=$VHDgbSizeUserChoice
Write-Host "`nInfo: " -NoNewLine;Write-Host "The chosen hard disk size is " -NoNewLine;Write-Host "$VHDgbSize" -NoNewLine -ForegroundColor green;Write-Host "."

    switch($VHDgbSize)
    {
        "16GB"{[Int64]$script:VHDgbSize=16GB}
        "20GB"{[Int64]$script:VHDgbSize=20GB}
        "32GB"{[Int64]$script:VHDgbSize=32GB}
        "48GB"{[Int64]$script:VHDgbSize=48GB}
        "64GB"{[Int64]$script:VHDgbSize=64GB}
        "80GB"{[Int64]$script:VHDgbSize=80GB}
        "120GB"{[Int64]$script:VHDgbSize=120GB}
    }

	if(Test-Path $VHDSPath){$null}else{[void](New-Item -Path $VHDSPath -ItemType Directory -Force)}
	if(Test-Path $vmsPath){$null}else{[void](New-Item -Path $vmsPath -ItemType Directory -Force)}

}

function HPV-Use_New-VM-Microsoft_Windows
{
	if($UseNetworkCard -eq $true){New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath" -SwitchName $SwitchName}else{New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath"}

Add-VMDvdDrive -VMName $VMName -Path "$isoPath"

$myVM=Get-VMFirmware $VMName
$HDD=$myVM.BootOrder[0]
$PXE=$myVM.BootOrder[1]
$DVD=$myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VM -Name $VMName -AutomaticCheckpointsEnabled $false
}

function HPV-New_VM-Blank-Client-Microsoft_Windows_10-Entreprise_LTSC
{
[string]$script:isoPath=".\src\Microsoft_Windows\clients\iso\client-windows10-entreprise-ltsc.iso"
[string]$script:isoDest=".\src\Microsoft_Windows\clients\iso"
[string]$script:isoFolderPath=".\src\Microsoft_Windows\clients\iso"
[string]$script:isoSrc="https://depository.fra1.digitaloceanspaces.com/ISO_images/Microsoft_Windows/client-windows10-entreprise-ltsc.iso"

[string]$script:VHDSPath=".\src\Microsoft_Windows\clients\vhds\"
[string]$script:vmsPath=".\src\Microsoft_Windows\clients\vms\"

HPV-New_VM-Blank-Template
HPV-Use_New-VM-Microsoft_Windows

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-Client-Microsoft_Windows_10-Entreprise_LTSC}
    	2{HPV-Copy_VM-Different-Blank-Client-Microsoft_Windows_10-Entreprise_LTSC}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Same-Blank-Client-Microsoft_Windows_10-Entreprise_LTSC
{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for the virtual machine is " -NoNewLine ;Write-Host "$VMname" -NoNewLine -ForegroundColor green;Write-Host "."

HPV-Use_New-VM-Microsoft_Windows

Write-Host ""
Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-Client-Microsoft_Windows_10-Entreprise_LTSC}
    	2{HPV-Copy_VM-Different-Blank-Client-Microsoft_Windows_10-Entreprise_LTSC}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
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
[string]$script:isoSrc="https://depository.fra1.digitaloceanspaces.com/ISO_images/Microsoft_Windows/client-windows10.iso"

[string]$script:VHDSPath=".\src\Microsoft_Windows\clients\vhds\"
[string]$script:vmsPath=".\src\Microsoft_Windows\clients\vms\"

HPV-New_VM-Blank-Template
HPV-Use_New-VM-Microsoft_Windows

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-Client-Microsoft_Windows_10-Multi}
    	2{HPV-Copy_VM-Different-Blank-Client-Microsoft_Windows_10-Multi}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Same-Blank-Client-Microsoft_Windows_10-Multi
{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for the virtual machine is " -NoNewLine;Write-Host "$VMname" -NoNewLine -ForegroundColor green;Write-Host "."

HPV-Use_New-VM-Microsoft_Windows

Write-Host ""
Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-Client-Microsoft_Windows_10-Multi}
    	2{HPV-Copy_VM-Different-Blank-Client-Microsoft_Windows_10-Multi}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Different-Blank-Client-Microsoft_Windows_10-Multi
{
HPV-New_VM-Blank-Client-Microsoft_Windows_10-Multi
}

function HPV-New_VM-Blank-Server-Microsoft_Windows_Server-2012
{
[string]$script:isoPath=".\src\Microsoft_Windows\servers\iso\win_srv-2012.iso"
[string]$script:isoDest=".\src\Microsoft_Windows\servers\iso"
[string]$script:isoFolderPath=".\src\Microsoft_Windows\servers\iso"
[string]$script:isoSrc="https://depository.fra1.digitaloceanspaces.com/ISO_images/Microsoft_Windows/win_srv-2012.iso"

[string]$script:VHDSPath=".\src\Microsoft_Windows\servers\vhds\"
[string]$script:vmsPath=".\src\Microsoft_Windows\servers\vms\"

HPV-New_VM-Blank-Template
HPV-Use_New-VM-Microsoft_Windows

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-Server-Microsoft_Windows_Server-2012}
    	2{HPV-Copy_VM-Different-Blank-Server-Microsoft_Windows_Server-2012}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Same-Blank-Server-Microsoft_Windows_Server-2012
{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for the virtual machine is " -NoNewLine;Write-Host "$VMname" -NoNewLine -ForegroundColor green;Write-Host "."

HPV-Use_New-VM-Microsoft_Windows

Write-Host ""
Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-Server-Microsoft_Windows_Server-2012}
    	2{HPV-Copy_VM-Different-Blank-Server-Microsoft_Windows_Server-2012}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
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
[string]$script:isoSrc="https://depository.fra1.digitaloceanspaces.com/ISO_images/Microsoft_Windows/win_srv-2019.iso"

[string]$script:VHDSPath=".\src\Microsoft_Windows\servers\vhds\"
[string]$script:vmsPath=".\src\Microsoft_Windows\servers\vms\"

HPV-New_VM-Blank-Template
HPV-Use_New-VM-Microsoft_Windows

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-Server-Microsoft_Windows_Server-2019}
    	2{HPV-Copy_VM-Different-Blank-Server-Microsoft_Windows_Server-2019}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Same-Blank-Server-Microsoft_Windows_Server-2019
{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for the virtual machine is " -NoNewLine;Write-Host "$VMname" -NoNewLine -ForegroundColor green;Write-Host "."

HPV-Use_New-VM-Microsoft_Windows

Write-Host ""
Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-Server-Microsoft_Windows_Server-2019}
    	2{HPV-Copy_VM-Different-Blank-Server-Microsoft_Windows_Server-2019}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
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
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Use_New-VM-GNU_Linux
{
	if($UseNetworkCard -eq $true){New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath" -SwitchName $SwitchName}else{New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -NewVHDPath "$VHDSPath\$VMName.vhdx" -NewVHDSizeBytes $VHDgbSize -Path "$vmsPath"}

Add-VMDvdDrive -VMName $VMName -Path "$isoPath"

$myVM=Get-VMFirmware $VMName
$HDD=$myVM.BootOrder[0]
$PXE=$myVM.BootOrder[1]
$DVD=$myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VMMemory $VMName -DynamicMemoryEnabled $false
Set-VMFirmware $VMName -EnableSecureBoot Off
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $false
}

function HPV-New_VM-Blank-GNU_Linux-pfSense
{
[string]$script:isoPath=".\src\GNU_Linux\iso\pfSense-CE-2.5.1-RELEASE-amd64.iso"
[string]$script:isoDest=".\src\GNU_Linux\iso"
[string]$script:isoFolderPath=".\src\GNU_Linux\iso"
[string]$script:isoSrc="https://depository.fra1.digitaloceanspaces.com/ISO_images/GNU_Linux/pfSense-CE-2.5.1-RELEASE-amd64.iso"

[string]$script:VHDSPath=".\src\GNU_Linux\vhds\"
[string]$script:vmsPath=".\src\GNU_Linux\vms\"

HPV-New_VM-Blank-Template
HPV-Use_New-VM-GNU_Linux

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-GNU_Linux-pfSense}
    	2{HPV-Copy_VM-Different-Blank-GNU_Linux-pfSense}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Same-Blank-GNU_Linux-pfSense
{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for the virtual machine is " -NoNewLine ;Write-Host "$VMname" -NoNewLine -ForegroundColor green;Write-Host "."

HPV-Use_New-VM-GNU_Linux

Write-Host ""
Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-GNU_Linux-pfSense}
    	2{HPV-Copy_VM-Different-Blank-GNU_Linux-pfSense}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
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
HPV-Use_New-VM-GNU_Linux

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-GNU_Linux-Debian}
    	2{HPV-Copy_VM-Different-Blank-GNU_Linux-Debian}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Same-Blank-GNU_Linux-Debian
{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for the virtual machine is " -NoNewLine ;Write-Host "$VMname" -NoNewLine -ForegroundColor green;Write-Host "."

HPV-Use_New-VM-GNU_Linux

Write-Host ""
Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-GNU_Linux-Debian}
    	2{HPV-Copy_VM-Different-Blank-GNU_Linux-Debian}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
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
[string]$script:isoSrc="https://releases.ubuntu.com/22.04/ubuntu-22.04-desktop-amd64.iso"

[string]$script:VHDSPath=".\src\GNU_Linux\vhds\"
[string]$script:vmsPath=".\src\GNU_Linux\vms\"

HPV-New_VM-Blank-Template
HPV-Use_New-VM-GNU_Linux

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-GNU_Linux-Ubuntu}
    	2{HPV-Copy_VM-Different-Blank-GNU_Linux-Ubuntu}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Same-Blank-GNU_Linux-Ubuntu
{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for the virtual machine is " -NoNewLine ;Write-Host "$VMname" -NoNewLine -ForegroundColor green;Write-Host "."

HPV-Use_New-VM-GNU_Linux

Write-Host ""
Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-GNU_Linux-Ubuntu}
    	2{HPV-Copy_VM-Different-Blank-GNU_Linux-Ubuntu}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
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
[string]$script:isoSrc="http://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.5-x86_64-dvd1.iso"

[string]$script:VHDSPath=".\src\GNU_Linux\vhds\"
[string]$script:vmsPath=".\src\GNU_Linux\vms\"

HPV-New_VM-Blank-Template
HPV-Use_New-VM-GNU_Linux

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-GNU_Linux-Rocky_Linux-Full}
    	2{HPV-Copy_VM-Different-Blank-GNU_Linux-Rocky_Linux-Full}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Same-Blank-GNU_Linux-Rocky_Linux-Full
{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for the virtual machine is " -NoNewLine ;Write-Host "$VMname" -NoNewLine -ForegroundColor green;Write-Host "."

HPV-Use_New-VM-GNU_Linux

Write-Host ""
Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-GNU_Linux-Rocky_Linux-Full}
    	2{HPV-Copy_VM-Different-Blank-GNU_Linux-Rocky_Linux-Full}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
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
[string]$script:isoSrc="http://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.5-x86_64-minimal.iso"

[string]$script:VHDSPath=".\src\GNU_Linux\vhds\"
[string]$script:vmsPath=".\src\GNU_Linux\vms\"

HPV-New_VM-Blank-Template
HPV-Use_New-VM-GNU_Linux

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-GNU_Linux-Rocky_Linux-Minimal}
    	2{HPV-Copy_VM-Different-Blank-GNU_Linux-Rocky_Linux-Minimal}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Same-Blank-GNU_Linux-Rocky_Linux-Minimal
{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for the virtual machine is " -NoNewLine ;Write-Host "$VMname" -NoNewLine -ForegroundColor green;Write-Host "."

HPV-Use_New-VM-GNU_Linux

Write-Host ""
Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-GNU_Linux-Rocky_Linux-Minimal}
    	2{HPV-Copy_VM-Different-Blank-GNU_Linux-Rocky_Linux-Minimal}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
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
[string]$script:isoSrc="http://bunny.deb.parrot.sh/parrot/iso/5.0/Parrot-security-5.0_amd64.iso"

[string]$script:VHDSPath=".\src\GNU_Linux\vhds\"
[string]$script:vmsPath=".\src\GNU_Linux\vms\"

HPV-New_VM-Blank-Template
HPV-Use_New-VM-GNU_Linux

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-GNU_Linux-Parrot_Security}
    	2{HPV-Copy_VM-Different-Blank-GNU_Linux-Parrot_Security}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Same-Blank-GNU_Linux-Parrot_Security
{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for the virtual machine is " -NoNewLine ;Write-Host "$VMname" -NoNewLine -ForegroundColor green;Write-Host "."

HPV-Use_New-VM-GNU_Linux

Write-Host ""
Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-GNU_Linux-Parrot_Security}
    	2{HPV-Copy_VM-Different-Blank-GNU_Linux-Parrot_Security}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
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
[string]$script:isoSrc="http://cdimage.kali.org/kali-images/current/kali-linux-2022.1-live-amd64.iso"

[string]$script:VHDSPath=".\src\GNU_Linux\vhds\"
[string]$script:vmsPath=".\src\GNU_Linux\vms\"

HPV-New_VM-Blank-Template
HPV-Use_New-VM-GNU_Linux

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-GNU_Linux-Kali_Linux-Live}
    	2{HPV-Copy_VM-Different-Blank-GNU_Linux-Kali_Linux-Live}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Same-Blank-GNU_Linux-Kali_Linux-Live
{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for the virtual machine is " -NoNewLine ;Write-Host "$VMname" -NoNewLine -ForegroundColor green;Write-Host "."

HPV-Use_New-VM-GNU_Linux

Write-Host ""
Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-GNU_Linux-Kali_Linux-Live}
    	2{HPV-Copy_VM-Different-Blank-GNU_Linux-Kali_Linux-Live}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
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
[string]$script:isoSrc="http://cdimage.kali.org/kali-images/current/kali-linux-2022.1-installer-amd64.iso"

[string]$script:VHDSPath=".\src\GNU_Linux\vhds\"
[string]$script:vmsPath=".\src\GNU_Linux\vms\"

HPV-New_VM-Blank-Template
HPV-Use_New-VM-GNU_Linux

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-GNU_Linux-Kali_Linux-Installer}
    	2{HPV-Copy_VM-Different-Blank-GNU_Linux-Kali_Linux-Installer}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Same-Blank-GNU_Linux-Kali_Linux-Installer
{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for the virtual machine is " -NoNewLine ;Write-Host "$VMname" -NoNewLine -ForegroundColor green;Write-Host "."

HPV-Use_New-VM-GNU_Linux

Write-Host ""
Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	1{HPV-Copy_VM-Same-Blank-GNU_Linux-Kali_Linux-Installer}
    	2{HPV-Copy_VM-Different-Blank-GNU_Linux-Kali_Linux-Installer}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Different-Blank-GNU_Linux-Kali_Linux-Installer
{
HPV-New_VM-Blank-GNU_Linux-Kali_Linux-Installer
}

<### ### ### ### ### ### ### ### ### ### ### ### ###
### Creation of pre-configured virtual machine(s). ###
### ### ### ### ### ### ### ### ### ### ### ### ###>

function HPV-New_VM-Template
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
    	1{HPV-New_VM-Template-Microsoft_Windows}
    	2{Under_Development}
    
    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-New_VM-Template-Model
{
Clear-Host
[string]$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for the virtual machine is " -NoNewLine ;Write-Host "$VMname" -NoNewLine -ForegroundColor green;Write-Host "."

Ask_YesOrNo "Hyper-V Toolbox - MessageBox function - Franck FERMAN." "Would you like to add a network card to your virtual machine?"

	switch($Ask_YesOrNo_Result)
	{
	1{[bool]$script:UseNetworkCard=$false}
	
	0{
	[bool]$script:UseNetworkCard=$true
	$VMsList=@()
	Get-VMSwitch|ForEach-Object{$VMsList+=$_.Name}
	
	Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Display the list of virtual switches.`n"
	For($i=0;$i -lt $VMsList.Length;$i++){Write-Host "$i - $($VMsList[$i])"}
	
	[int]$userChoice=Read-Host "`nWhich virtual switch do you want to set up on your virtual machine"
	$VMchoice=$VMsList[$userChoice]
	$script:SwitchName=$VMchoice
	Write-Host "Info: " -NoNewLine;Write-Host "The chosen virtual switch is " -NoNewLine;Write-Host "$SwitchName" -NoNewLine -ForegroundColor green;Write-Host "."
	}

	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Verification of required resources (and automatic decision making)."
	if(Test-Path $isoOrBasePath)
	{
		Write-Host "Info: " -NoNewLine;Write-Host "The resource corresponding to your request has been identified." -ForegroundColor green
	}else{
		Write-Host "Info: " -NoNewLine;Write-Host "The corresponding resource could not be identified or an unexpected error was caused during the identification phase." -ForegroundColor darkred
		Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Automated launch of the download of the corresponding resources.`n" -NoNewLine

			if(Test-Path $isoOrVHDBaseDest){$null}else{[void](New-Item -Path $isoOrVHDBaseFolderPath -ItemType Directory -Force)}

	Start-BitsTransfer -Source $isoOrBaseSrc -Destination $isoOrVHDBaseDest -DisplayName "Hyper-V_Toolbox - Downloading function - Franck FERMAN." -Description "Download of the corresponding resource in progress."

	if(Test-Path $isoOrBasePath){Write-Host "`nInfo: " -NoNewLine;Write-Host "Download successfully completed." -ForegroundColor green}else{Write-Host "`nInfo:" -NoNewLine;Write-Host "An unexpected error was caused." -ForegroundColor darkred;Write-Host "`nOngoing action:" -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor darkred;pause;main}
	}

$script:RAMgbSize=$RAMgbSizeUserChoice
$script:VHDgbSize=$VHDgbSizeUserChoice

	if(Test-Path $VHDSPath){$null}else{[void](New-Item -Path $VHDSPath -ItemType Directory -Force)}
	if(Test-Path $vmsPath){$null}else{[void](New-Item -Path $vmsPath -ItemType Directory -Force)}
}

function HPV-New_VM-Template-Microsoft_Windows
{
Clear-Host
Write-Host "1 - Microsoft Windows 10 Entreprise (LTSC): Sysprep & autounattend.xml."
Write-Host ""
Write-Host "2 - Microsoft Windows Server 2019: Sysprep."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	1{HPV-New_VM-Template-Client-Microsoft_Windows_10-Entreprise_LTSC-sysprep_autounattend}

    	2{HPV-New_VM-Template-Server-Microsoft_Windows_Server_2019-sysprep}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Use_New-VM-Template-Microsoft_Windows
{
New-VHD -ParentPath $isoOrBasePath -Path $VHDSPath\$VMName.vhdx -Differencing|Out-Null

	if($UseNetworkCard -eq $true){New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -BootDevice VHD -VHDPath $VHDSPath\$VMName.vhdx -Path "$vmsPath" -SwitchName $SwitchName}else{New-VM -Name $VMName -MemoryStartupBytes $RAMgbSize -Generation 2 -BootDevice VHD -VHDPath "$VHDSPath\$VMName.vhdx" -Path "$vmsPath"}

Set-VM -Name $VMName -AutomaticCheckpointsEnabled $false
}

function HPV-New_VM-Template-Client-Microsoft_Windows_10-Entreprise_LTSC-sysprep_autounattend
{
[string]$script:isoOrBasePath=".\src\Microsoft_Windows\clients\vhds\base\base-client-windows10-entreprise-ltsc-sysprep-autounattend.vhdx"
[string]$script:isoOrVHDBaseDest=".\src\Microsoft_Windows\clients\vhds\base"
[string]$script:isoOrVHDBaseFolderPath=".\src\Microsoft_Windows\clients\vhds\base"
[string]$script:isoOrBaseSrc="https://depository.fra1.digitaloceanspaces.com/bases/Microsoft_Windows/base-client-windows10-entreprise-ltsc-sysprep-autounattend.vhdx"

[string]$script:VHDSPath=".\src\Microsoft_Windows\clients\vhds\"
[string]$script:vmsPath=".\src\Microsoft_Windows\clients\vms\"

$script:RAMgbSizeUserChoice=2GB
$script:VHDgbSizeUserChoice="$null"

HPV-New_VM-Template-Model
HPV-Use_New-VM-Template-Microsoft_Windows

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	1{HPV-Copy_VM-Same-Template-Client-Microsoft_Windows_10-Entreprise_LTSC}
    	2{HPV-Copy_VM-Different-Template-Client-Microsoft_Windows_10-Entreprise_LTSC}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Same-Template-Client-Microsoft_Windows_10-Entreprise_LTSC
{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for the virtual machine is " -NoNewLine ;Write-Host "$VMname" -NoNewLine -ForegroundColor green;Write-Host "."

HPV-Use_New-VM-Template-Microsoft_Windows

Write-Host ""
Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	1{HPV-Copy_VM-Same-Template-Client-Microsoft_Windows_10-Entreprise_LTSC}
    	2{HPV-Copy_VM-Different-Template-Client-Microsoft_Windows_10-Entreprise_LTSC}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Different-Template-Client-Microsoft_Windows_10-Entreprise_LTSC
{
HPV-New_VM-Template-Client-Microsoft_Windows_10-Entreprise_LTSC
}

function HPV-New_VM-Template-Server-Microsoft_Windows_Server_2019-sysprep
{
[string]$script:isoOrBasePath=".\src\Microsoft_Windows\servers\vhds\base\base-windows_server_2019-sysprep.vhdx"
[string]$script:isoOrVHDBaseDest=".\src\Microsoft_Windows\servers\vhds\base"
[string]$script:isoOrVHDBaseFolderPath=".\src\Microsoft_Windows\servers\vhds\base"
[string]$script:isoOrBaseSrc="https://depository.fra1.digitaloceanspaces.com/bases/Microsoft_Windows/base-windows_server_2019-sysprep.vhdx"

[string]$script:VHDSPath=".\src\Microsoft_Windows\servers\vhds\"
[string]$script:vmsPath=".\src\Microsoft_Windows\servers\vms\"

$script:RAMgbSizeUserChoice=2GB
$script:VHDgbSizeUserChoice="$null"

HPV-New_VM-Template-Model
HPV-Use_New-VM-Template-Microsoft_Windows

Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	1{HPV-Copy_VM-Same-Template-Server-Microsoft_Windows_Server_2019-sysprep}
    	2{HPV-Copy_VM-Different-Template-Server-Microsoft_Windows_Server_2019-sysprep}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Same-Template-Server-Microsoft_Windows_Server_2019-sysprep
{
Clear-Host
$script:VMName=Read-Host "Choose a name for the virtual machine"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for the virtual machine is " -NoNewLine ;Write-Host "$VMname" -NoNewLine -ForegroundColor green;Write-Host "."

HPV-Use_New-VM-Template-Microsoft_Windows

Write-Host ""
Write-Host "1 - Recreate the same virtual machine (with the same characteristics)."
Write-Host "2 - Recreate the same virtual machine (with different characteristics)."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	1{HPV-Copy_VM-Same-Template-Server-Microsoft_Windows_Server_2019-sysprep}
    	2{HPV-Copy_VM-Different-Template-Server-Microsoft_Windows_Server_2019-sysprep}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;Write-Host "Info: " -NoNewLine;Write-Host "A summary of the last machine created will be displayed after this program is exited.";Write-Host "";pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;Write-Host "";exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Copy_VM-Different-Template-Server-Microsoft_Windows_Server_2019-sysprep
{
HPV-New_VM-Template-Server-Microsoft_Windows_Server_2019-sysprep
}

function HPV-New_VM-Template-GNU_Linux
{
Clear-Host
Write-Host "0 - pfSense (CE, 2.5.1): Only the preconfiguration performed."
Write-Host ""
Write-Host "1 - Debian (11.3.0): Only the preconfiguration performed."
Write-Host "2 - Ubuntu, Jammy Jellyfish (LTS, 22.04): Only the preconfiguration performed."
Write-Host ""
Write-Host "3 - Rocky Linux (Full, 8.5): Only the preconfiguration performed."
Write-Host "4 - Rocky Linux (Minimal, 8.5): Only the preconfiguration performed."
Write-Host ""
Write-Host "5 - Parrot Security (5.0): Only the preconfiguration performed."
Write-Host "6 - Kali (Live, 2022.1): Only the preconfiguration performed."
Write-Host "7 - Kali (Installer, 2022.1): Only the preconfiguration performed."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
		0{HPV-New_VM-Template-GNU_Linux-pfSense-preconfiguration}
    	1{HPV-New_VM-Template-GNU_Linux-Debian-preconfiguration}
    	2{HPV-New_VM-Template-GNU_Linux-Ubuntu-preconfiguration}
    	3{HPV-New_VM-Template-GNU_Linux-Rocky_Linux-Full-preconfiguration}
    	4{HPV-New_VM-Template-GNU_Linux-Rocky_Linux-Minimal-preconfiguration}
    	5{HPV-New_VM-Template-GNU_Linux-Parrot_Security-preconfiguration}
    	6{HPV-New_VM-Template-GNU_Linux-Kali_Linux-Live-preconfiguration}
    	7{HPV-New_VM-Template-GNU_Linux-Kali_Linux-Installer-preconfiguration}

    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-New_VM-Template-GNU_Linux-pfSense-preconfiguration
{
Under_Development
}

function HPV-New_VM-Template-GNU_Linux-Debian-preconfiguration
{
Under_Development
}

function HPV-New_VM-Template-GNU_Linux-Ubuntu-preconfiguration
{
Under_Development
}

function HPV-New_VM-Template-GNU_Linux-Rocky_Linux-Full-preconfiguration
{
Under_Development
}

function PV-New_VM-Template-GNU_Linux-Rocky_Linux-Minimal-preconfiguration
{
Under_Development
}

function HPV-New_VM-Template-GNU_Linux-Parrot_Security-preconfiguration
{
Under_Development
}

function HPV-New_VM-Template-GNU_Linux-Kali_Linux-Live-preconfiguration
{
Under_Development
}

function HPV-New_VM-Template-GNU_Linux-Kali_Linux-Installer-preconfiguration
{
Under_Development
}

<### ### ### ### ### ### ### ### ### ###
### Management of virtual machine(s). ###
### ### ### ### ### ### ### ### ### ###>

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
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Show_VMs
{
Clear-Host
Write-Host "Ongoing action: " -NoNewLine;Write-Host "Displaying the list of virtual machines."

$Get_VM=Get-VM|Select-Object -Property Name,State,Uptime,Status|Out-Default;pause

Write-Host ""
Write-Host "7 - Return to the virtual machine(s) management menu." -ForegroundColor gray
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{   
    	7{HPV-VM_Management}
    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Start_VM
{
Clear-Host
Write-Host "Ongoing action: " -NoNewLine;Write-Host "Displays a list of currently powered-off virtual machines.`n"

$Get_VM=Get-VM|Where{$_.State -eq 'Off'}
[array]$VMsList=@()
$Get_VM|ForEach-Object{$VMsList+=$_.Name}

For($i=0;$i -lt $VMsList.Length;$i++){Write-Host "$i - $($VMsList[$i])"}

[int]$userChoice=Read-Host "`nWhich machine do you want to start"
$VMuserChoice=$VMsList[$userChoice]
$Selected_VM=$VMuserChoice
Write-Host "`nInfo: " -NoNewLine;Write-Host "The selected virtual machine is " -NoNewLine;Write-Host "$Selected_VM" -NoNewLine -ForegroundColor green;Write-Host "."

Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Starting the virtual machine." -ForegroundColor green
Start-VM -Name $Selected_VM

Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Display the list of currently running virtual machines."
Get-VM|Where{$_.State -eq 'Running'}|Out-Default;pause

Write-Host ""
Write-Host "6 - Boot another virtual machine."
Write-Host ""
Write-Host "7 - Return to the virtual machine(s) management menu." -ForegroundColor gray
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
		6{HPV-Start_VM}

    	7{HPV-VM_Management}
    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Start_All_VMs
{
Clear-Host
[array]$VMsList=@()
$Get_VM=Get-VM|Where{$_.State -eq 'Off'}
$Get_VM|ForEach-Object{$VMsList+=$_.Name}

	if($VMsList -ne $null)
	{
		Write-Host "Ongoing action: " -NoNewLine;Write-Host "Displays a list of currently powered-off virtual machines.`n"
		ForEach($VM in $VMsList){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Starting the virtual machine " -NoNewLine;Write-Host "$VM." -ForegroundColor green;Start-VM -Name $VM}
		Write-Host ""
	}else{Write-Host "Info: " -NoNewLine;Write-Host "No machines are available or currently down." -ForegroundColor darkred;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}

Write-Host "Ongoing action: " -NoNewLine;Write-Host "Display the list of currently running virtual machines."
Get-VM|Where{$_.State -eq 'Running'}|Out-Default;pause

Write-Host ""
Write-Host "7 - Return to the virtual machine(s) management menu." -ForegroundColor gray
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	7{HPV-VM_Management}
    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Shut_Down_VMs
{
Clear-Host
[array]$VMsList=@()
$Get_VM=Get-VM|Where{$_.State -eq 'Running'}
$Get_VM|ForEach-Object{$VMsList+=$_.Name}

	if($VMsList -ne $null)
	{
		Write-Host "Ongoing action: " -NoNewLine;Write-Host "Display the list of currently running virtual machines.`n"
		For($i=0;$i -lt $VMsList.Length;$i++){Write-Host "$i - $($VMsList[$i])"}

		$userChoice=Read-Host "`nWhich machine do you want to switch off"
		$VMuserChoice=$VMsList[$userChoice]
		$Selected_VM=$VMuserChoice
		Write-Host "`nInfo: " -NoNewLine;Write-Host "The selected virtual machine is " -NoNewLine;Write-Host "$Selected_VM" -NoNewLine -ForegroundColor green;Write-Host "."
		
		Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Switching off of the machine." -ForegroundColor green
		Stop-VM -Name $Selected_VM -ErrorAction SilentlyContinue -TurnOff -Force
		
		Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Displays a list of currently powered-off virtual machines.`n"
		Get-VM|Where{$_.State -eq 'Off'}|Out-Default;pause
	}else{Write-Host "Info: " -NoNewLine;Write-Host "No machines are available or currently up." -ForegroundColor darkred;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}

Write-Host ""
Write-Host "6 - Shut down another virtual machine."
Write-Host ""
Write-Host "7 - Return to the virtual machine(s) management menu." -ForegroundColor gray
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
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Shut_Down_All_VMs
{
Clear-Host
[array]$VMsList=@()
$Get_VM=Get-VM|Where{$_.State -eq 'Running'}
$Get_VM|ForEach-Object{$VMsList+=$_.Name}

	if($VMsList -ne $null)
	{
		Write-Host "Ongoing action: " -NoNewLine;Write-Host "Display the list of currently running virtual machines.`n"
		ForEach($VM in $VMsList){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Switching off of the machine " -NoNewLine;Write-Host "$VM" -ForegroundColor green;Stop-VM -Name $VM -TurnOff -Force -ErrorAction SilentlyContinue}

		Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Displays a list of currently powered-off virtual machines."
		Get-VM|Where{$_.State -eq 'Off'}|Out-Default;pause
	}else{Write-Host "Info: " -NoNewLine;Write-Host "No machines are available or currently up." -ForegroundColor darkred;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}

Write-Host ""
Write-Host "7 - Return to the virtual machine(s) management menu." -ForegroundColor gray
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	7{HPV-VM_Management}
    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Remove_VMs
{
Clear-Host
Write-Host "Ongoing action: " -NoNewLine;Write-Host "Display the list of virtual machines.`n"

[array]$VMsList=@()
$Get_VM=Get-VM
$Get_VM|ForEach-Object{$VMsList+=$_.Name}

For($i=0;$i -lt $VMsList.Length;$i++){Write-Host "$i - $($VMsList[$i])"}

$userChoice=Read-Host "`nWhich machine do you want to delete with its data"
$VMuserChoice=$VMsList[$userChoice]
$Selected_VM=$VMuserChoice
Write-Host "`nInfo: " -NoNewLine;Write-Host "The selected virtual machine is " -NoNewLine;Write-Host "$Selected_VM" -NoNewLine -ForegroundColor green;Write-Host "."

$Is_On=Get-VM -Name $Selected_VM|Where{$_.State -eq 'Running'}
if($Is_On -eq $null){$null}else{Write-Host "`nInfo" -NoNewLine;Write-Host "The machine is obviously currently switched on." -ForegroundColor darkred;Write-Host "`nOngoing action:" -NoNewLine;Write-Host "Switching off of the machine." -ForegroundColor green;Stop-VM -Name $Selected_VM -TurnOff -Force -ErrorAction SilentlyContinue}

Remove-VM -Name $Selected_VM -Force

$VMPath=Get-ChildItem -Path . -Filter $Selected_VM -Recurse|%{$_.FullName}
[void](Remove-Item -Path $VMPath -Force -Recurse)

$Selected_VHDX=$Selected_VM+".vhdx"
$VHDXPath=Get-ChildItem -Path . -Filter $Selected_VHDX -Recurse|%{$_.FullName}
[void](Remove-Item -Path $VHDXPath -Force -Recurse)

Write-Host ""
Write-Host "6 - Delete another machine."
Write-Host ""
Write-Host "7 - Return to the virtual machine(s) management menu." -ForegroundColor gray
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
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Remove_All_VMs
{
Clear-Host
Write-Host "Ongoing action: " -NoNewLine;Write-Host "Start the process of deleting virtual machines."

[array]$VMsList=@{}
$Get_VM=Get-VM|Where{$_.State -eq 'Off'}
$VMsList=($Get_VM).Name

	if($VMsList -eq $null)
	{
		ForEach($VM in $VMsList){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Switching off of the machine " -NoNewLine;Write-Host "$VM" -ForegroundColor green;Stop-VM -Name $VM -Force -TurnOff -WarningAction SilentlyContinue -ErrorAction SilentlyContinue}
	}

ForEach($VM in $VMsList){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Removing the virtual machine " -NoNewLine;Write-Host "$VM" -ForegroundColor green;Remove-VM -Name $VM -Force}

[array]$VHDXList=@()
$VHDXPath=Get-ChildItem -Path . -Filter *.vhdx -Recurse -Exclude base-*|%{$_.FullName}
$VHDXList=$VHDXPath
ForEach($VHDX in $VHDXList){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Deletion of the virtual hard disk " -NoNewLine;Write-Host "$VHDX" -ForegroundColor green;[void](Remove-Item -Path $VHDX -Force -Recurse)}

<### ### ### ### ### ### ### ### ### ###
### BEGIN TODO: Improve the algorithm/logic. ###
### ### ### ### ### ### ### ### ### ###>

[void](Remove-Item -Path ".\src\Microsoft_Windows\clients\vms\*" -Force -Recurse -ErrorAction SilentlyContinue -WarningAction SilentlyContinue -InformationAction SilentlyContinue)
[void](Remove-Item -Path ".\src\Microsoft_Windows\servers\vms\*" -Force -Recurse -ErrorAction SilentlyContinue -WarningAction SilentlyContinue -InformationAction SilentlyContinue)
[void](Remove-Item -Path ".\src\GNU_Linux\vms\*" -Force -Recurse -ErrorAction SilentlyContinue -WarningAction SilentlyContinue -InformationAction SilentlyContinue)

### END: TODO

Write-Host ""
Write-Host "7 - Return to the virtual machine(s) management menu." -ForegroundColor gray
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
    	7{HPV-VM_Management}
    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

<### ### ### ### ### ### ### ### ### ###
### Management of virtual switch(es). ###
### ### ### ### ### ### ### ### ### ###>

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
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Show_Virtual_VSwitches
{
Clear-Host
Write-Host "Ongoing action: " -NonewLine;Write-Host "Display the list of virtual switches."

Get-VMSwitch|Out-Default;pause

Write-Host ""
Write-Host "7 - Return to the virtual switch management menu." -ForegroundColor gray
Write-Host "8 - Go back to the main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
		7{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Return to the virtual switch management menu.`n" -ForegroundColor red;pause;HPV-Virtual_Switches_Management}
    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-New_VSwitch
{
Clear-Host
$Switch_Name=Read-Host "What name would you like to choose for your network switch"
Write-Host "Info: " -NoNewLine;Write-Host "The name chosen for your virtual switch is " -NoNewLine;Write-Host "$Switch_Name" -NoNewLine -ForegroundColor green;Write-Host "."

Write-Host ""
Write-Host "What type of virtual switch do you want to create?"
Write-Host ""
Write-Host "1 - Internal"
Write-Host "2 - Private"
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
		1{[string]$Switch_Type="Internal"}
		2{[string]$Switch_Type="Private"}
		default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

New-VMSwitch -Name $Switch_Name -SwitchType $Switch_Type|Out-Null

Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Display the list of virtual switches."
Get-VMSwitch|Select-Object Name,SwitchType|Out-Default

Write-Host "7 - Return to the virtual switch management menu." -ForegroundColor gray
Write-Host "8 - Go back to the main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

[int]$userChoice=Read-Host "Your choice"
	switch($userChoice)
	{
		7{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Return to the virtual switch management menu.`n" -ForegroundColor red;pause;HPV-Virtual_Switches_Management}
    	8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
    	9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exit of the program in progress.`n" -ForegroundColor darkred;pause;$host.ui.RawUI.WindowTitle=$DefaultWindowTitle;exit}
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Remove_VSwitch
{
Clear-Host
Write-Host "Ongoing action: " -NoNewLine;Write-Host "Displaying the list of virtual switches.`n"

[array]$VSwitchesList=@()
$Get_VSwitches=Get-VMSwitch
$Get_VSwitches|ForEach-Object{$VSwitchesList+=$_.Name}

For($i=0;$i -lt $VSwitchesList.Length;$i++){Write-Host "$i - $($VSwitchesList[$i])"}

$userChoice=Read-Host "`nWhich virtual switch do you want to remove"
$VSwitchChoice=$VSwitchesList[$userChoice]
$Selected_Switch=$VSwitchChoice
Write-Host "`nInfo: " -NoNewLine;Write-Host "The chosen virtual switch is " -NoNewLine;Write-Host "$Selected_Switch" -NoNewLine -ForegroundColor green;Write-Host "."

Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Deletion of the virtual switch " -NoNewLine;Write-Host "$Selected_Switch" -NoNewLine -ForegroundColor green;Write-Host "."
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
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

<### ### ### ### ### ### ### ### ### ### ### ###
### Resource management and local downloading. ###
### ### ### ### ### ### ### ### ### ### ### ###>

function Resource_Management
{
Clear-Host
Write-Host "1 - Download all the resources (" -NoNewLine;Write-Host "potential long waiting time" -NoNewLine -ForegroundColor red;Write-Host ")."
Write-Host ""
Write-Host "2 - Download resources for creating Windows virtual machines only."
Write-Host "3 - Download resources for creating Linux virtual machines only."
Write-Host ""
Write-Host "4 - Fully customized download program (" -NoNewLine;Write-Host "recommended" -NoNewLine -ForegroundColor green;Write-Host ")."
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
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Download_Base
{
	Param
    (
    	[string]$isoPath,
		[string]$isoDest,
		[string]$isoFolderPath,
		[string]$isoSrc
    )

Write-Host "Ongoing action: " -NoNewLine;Write-Host "Verification of required resources (and automatic decision making)."
	if(Test-Path $isoPath)
	{
		Write-Host "Info: " -NoNewLine;Write-Host "The resource corresponding to your request has been identified." -ForegroundColor green
	}else{
		Write-Host "Info: " -NoNewLine;Write-Host "The corresponding resource could not be identified or an unexpected error was caused during the identification phase." -ForegroundColor darkred
		Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Automated launch of the download of the corresponding resources.`n" -NoNewLine

			if(Test-Path $isoDest){$null}else{[void](New-Item -Path $isoFolderPath -ItemType Directory -Force)}

	Start-BitsTransfer -Source $isoSrc -Destination $isoDest -DisplayName "Hyper-V_Toolbox - Downloading function - Franck FERMAN." -Description "Download of the corresponding resource in progress."

	if(Test-Path $isoPath){Write-Host "`nInfo: " -NoNewLine;Write-Host "Download successfully completed." -ForegroundColor green}else{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused." -ForegroundColor darkred;Write-Host "Ongoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor darkred;pause;main}
	}

}

function HPV-Download_All_Resources
{
Clear-Host
Write-Host "Ongoing action: " -NoNewLine;Write-Host "Start the general download process.";Write-Host ""

Write-Host "Ongoing action: " -NoNewLine;Write-Host "Start the Linux resource download process.";Write-Host ""

Write-Host "Ongoing action: " -NoNewLine;Write-Host "Launching the pfSense ISO download process.";Write-Host ""
HPV-Download_Base ".\src\GNU_Linux\iso\pfSense-CE-2.5.1-RELEASE-amd64.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://depository.fra1.digitaloceanspaces.com/ISO_images/GNU_Linux/pfSense-CE-2.5.1-RELEASE-amd64.iso"

Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Debian ISO download process.";Write-Host ""
HPV-Download_Base ".\src\GNU_Linux\iso\debian-11.3.0-amd64-netinst.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.3.0-amd64-netinst.iso"

Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Ubuntu ISO download process.";Write-Host ""
HPV-Download_Base ".\src\GNU_Linux\iso\ubuntu-22.04-beta-desktop-amd64.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://releases.ubuntu.com/22.04/ubuntu-22.04-desktop-amd64.iso"

Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Rocky Linux (Full) ISO download process.";Write-Host ""
HPV-Download_Base ".\src\GNU_Linux\iso\Rocky-8.5-x86_64-dvd1.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.5-x86_64-dvd1.iso"

Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Rocky Linux (Minimal) ISO download process.";Write-Host ""
HPV-Download_Base ".\src\GNU_Linux\iso\Rocky-8.5-x86_64-minimal.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.5-x86_64-minimal.iso"

Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Parrot Security ISO download process.";Write-Host ""
HPV-Download_Base ".\src\GNU_Linux\iso\Parrot-security-5.0_amd64.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://bunny.deb.parrot.sh/parrot/iso/5.0/Parrot-security-5.0_amd64.iso"

Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Kali Linux Live ISO download process.";Write-Host ""
HPV-Download_Base ".\src\GNU_Linux\iso\kali-linux-2022.1-live-amd64.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://cdimage.kali.org/kali-images/current/kali-linux-2022.1-live-amd64.iso"

Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Kali Linux Installer ISO download process.";Write-Host ""
HPV-Download_Base ".\src\GNU_Linux\iso\kali-linux-2022.1-installer-amd64.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://cdimage.kali.org/kali-images/current/kali-linux-2022.1-installer-amd64.iso"

Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Start the Windows resource download process.";Write-Host ""

Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Windows 10 Enterprise ISO download process.";Write-Host ""
HPV-Download_Base ".\src\Microsoft_Windows\clients\iso\client-windows10-entreprise-ltsc.iso" ".\src\Microsoft_Windows\clients\iso" ".\src\Microsoft_Windows\clients\iso" "https://depository.fra1.digitaloceanspaces.com/ISO_images/Microsoft_Windows/client-windows10-entreprise-ltsc.iso"

Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Windows 10 Pro/Home/Education ISO download process.";Write-Host ""
HPV-Download_Base ".\src\Microsoft_Windows\clients\iso\client-windows10.iso" ".\src\Microsoft_Windows\clients\iso" ".\src\Microsoft_Windows\clients\iso" "https://depository.fra1.digitaloceanspaces.com/ISO_images/Microsoft_Windows/client-windows10.iso"

Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Windows Server 2012 ISO download process.";Write-Host ""
HPV-Download_Base ".\src\Microsoft_Windows\servers\iso\win_srv-2012.iso" ".\src\Microsoft_Windows\servers\iso" ".\src\Microsoft_Windows\servers\iso" "https://depository.fra1.digitaloceanspaces.com/ISO_images/Microsoft_Windows/win_srv-2012.iso"

Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Windows Server 2012 ISO download process.";Write-Host ""
HPV-Download_Base ".\src\Microsoft_Windows\servers\iso\win_srv-2019.iso" ".\src\Microsoft_Windows\servers\iso" ".\src\Microsoft_Windows\servers\iso" "https://depository.fra1.digitaloceanspaces.com/ISO_images/Microsoft_Windows/win_srv-2019.iso"

Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Windows Server 2019 Base download process.";Write-Host ""
HPV-Download_Base ".\src\Microsoft_Windows\servers\vhds\base\base-windows_server_2019-sysprep.vhdx" ".\src\Microsoft_Windows\servers\vhds\base" ".\src\Microsoft_Windows\servers\vhds\base" "https://depository.fra1.digitaloceanspaces.com/bases/Microsoft_Windows/base-windows_server_2019-sysprep.vhdx"

Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Windows Entreprise Base download process.";Write-Host ""
HPV-Download_Base ".\src\Microsoft_Windows\clients\vhds\base\base-client-windows10-entreprise-ltsc-sysprep-autounattend.vhdx" ".\src\Microsoft_Windows\clients\vhds\base" ".\src\Microsoft_Windows\clients\vhds\base" "https://depository.fra1.digitaloceanspaces.com/bases/Microsoft_Windows/base-client-windows10-entreprise-ltsc-sysprep-autounattend.vhdx"

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
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Download_All_Windows_Resources
{
Clear-Host
Write-Host "Ongoing action: " -NoNewLine;Write-Host "Start the Windows resource download process.";Write-Host ""

Write-Host "Ongoing action: " -NoNewLine;Write-Host "Launching the Windows 10 Enterprise ISO download process.";Write-Host ""
HPV-Download_Base ".\src\Microsoft_Windows\clients\iso\client-windows10-entreprise-ltsc.iso" ".\src\Microsoft_Windows\clients\iso" ".\src\Microsoft_Windows\clients\iso" "https://depository.fra1.digitaloceanspaces.com/ISO_images/Microsoft_Windows/client-windows10-entreprise-ltsc.iso"

Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Windows 10 Pro/Home/Education ISO download process.";Write-Host ""
HPV-Download_Base ".\src\Microsoft_Windows\clients\iso\client-windows10.iso" ".\src\Microsoft_Windows\clients\iso" ".\src\Microsoft_Windows\clients\iso" "https://depository.fra1.digitaloceanspaces.com/ISO_images/Microsoft_Windows/client-windows10.iso"

Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Windows Server 2012 ISO download process.";Write-Host ""
HPV-Download_Base ".\src\Microsoft_Windows\servers\iso\win_srv-2012.iso" ".\src\Microsoft_Windows\servers\iso" ".\src\Microsoft_Windows\servers\iso" "https://depository.fra1.digitaloceanspaces.com/ISO_images/Microsoft_Windows/win_srv-2012.iso"

Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Windows Server 2012 ISO download process.";Write-Host ""
HPV-Download_Base ".\src\Microsoft_Windows\servers\iso\win_srv-2019.iso" ".\src\Microsoft_Windows\servers\iso" ".\src\Microsoft_Windows\servers\iso" "https://depository.fra1.digitaloceanspaces.com/ISO_images/Microsoft_Windows/win_srv-2019.iso"

Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Windows Server 2019 Base download process.";Write-Host ""
HPV-Download_Base ".\src\Microsoft_Windows\servers\vhds\base\base-windows_server_2019-sysprep.vhdx" ".\src\Microsoft_Windows\servers\vhds\base" ".\src\Microsoft_Windows\servers\vhds\base" "https://depository.fra1.digitaloceanspaces.com/bases/Microsoft_Windows/base-windows_server_2019-sysprep.vhdx"

Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Windows Entreprise Base download process.";Write-Host ""
HPV-Download_Base ".\src\Microsoft_Windows\clients\vhds\base\base-client-windows10-entreprise-ltsc-sysprep-autounattend.vhdx" ".\src\Microsoft_Windows\clients\vhds\base" ".\src\Microsoft_Windows\clients\vhds\base" "https://depository.fra1.digitaloceanspaces.com/bases/Microsoft_Windows/base-client-windows10-entreprise-ltsc-sysprep-autounattend.vhdx"

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
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Download_All_Linux_Resources
{
Clear-Host
Write-Host "Ongoing action: " -NoNewLine;Write-Host "Start the Linux resource download process.";Write-Host ""

Write-Host "Ongoing action: " -NoNewLine;Write-Host "Launching the pfSense ISO download process.";Write-Host ""
HPV-Download_Base ".\src\GNU_Linux\iso\pfSense-CE-2.5.1-RELEASE-amd64.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://depository.fra1.digitaloceanspaces.com/ISO_images/GNU_Linux/pfSense-CE-2.5.1-RELEASE-amd64.iso"

Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Debian ISO download process.";Write-Host ""
HPV-Download_Base ".\src\GNU_Linux\iso\debian-11.3.0-amd64-netinst.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.3.0-amd64-netinst.iso"

Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Ubuntu ISO download process.";Write-Host ""
HPV-Download_Base ".\src\GNU_Linux\iso\ubuntu-22.04-beta-desktop-amd64.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://releases.ubuntu.com/22.04/ubuntu-22.04-desktop-amd64.iso"

Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Rocky Linux (Full) ISO download process.";Write-Host ""
HPV-Download_Base ".\src\GNU_Linux\iso\Rocky-8.5-x86_64-dvd1.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.5-x86_64-dvd1.iso"

Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Rocky Linux (Minimal) ISO download process.";Write-Host ""
HPV-Download_Base ".\src\GNU_Linux\iso\Rocky-8.5-x86_64-minimal.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.5-x86_64-minimal.iso"

Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Parrot Security ISO download process.";Write-Host ""
HPV-Download_Base ".\src\GNU_Linux\iso\Parrot-security-5.0_amd64.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://bunny.deb.parrot.sh/parrot/iso/5.0/Parrot-security-5.0_amd64.iso"

Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Kali Linux Live ISO download process.";Write-Host ""
HPV-Download_Base ".\src\GNU_Linux\iso\kali-linux-2022.1-live-amd64.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://cdimage.kali.org/kali-images/current/kali-linux-2022.1-live-amd64.iso"

Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Kali Linux Installer ISO download process.";Write-Host ""
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
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

function HPV-Download_Custom_Resources
{
Clear-Host

### BEGIN: Customization/choice process.

Write-Host "Ongoing action: " -NoNewLine;Write-Host "Launching the customization process."

Ask_YesOrNo "Question" "Would you like to install one or more Microsoft Windows machine(s)?"
	switch($Ask_YesOrNo_Result) 	### BEGIN: Switch Microsoft Windows.
	{
		1{[bool]$DoIuse_Microsoft_Windows=$false}	
		0{[bool]$DoIuse_Microsoft_Windows=$true 	### BEGIN: If Microsoft Windows is to be used.

Ask_YesOrNo "Question" "Would you like to install Microsoft Windows Entreprise?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$DoIuse_Microsoft_Windows_Entreprise=$false}
		0{[bool]$DoIuse_Microsoft_Windows_Entreprise=$true}
	}

	Ask_YesOrNo "Question" "Would you like to install Microsoft Windows 10 Pro/Home/Education?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$DoIuse_Microsoft_Windows_Pro=$false}
		0{[bool]$DoIuse_Microsoft_Windows_Pro=$true}
	}

	Ask_YesOrNo "Question" "Would you like to install Microsoft Windows Server 2012?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$DoIuse_Microsoft_Windows_Server_2012=$false}
		0{[bool]$DoIuse_Microsoft_Windows_Server_2012=$true}
	}

	Ask_YesOrNo "Question" "Would you like to install Microsoft Windows Server 2019?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$DoIuse_Microsoft_Windows_Server_2019=$false}
		0{[bool]$DoIuse_Microsoft_Windows_Server_2019=$true}
	}

	Ask_YesOrNo "Question" "Would you like to install Base for Microsoft Windows Server 2019?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$DoIuse_Microsoft_Windows_Server_2019_Base=$false}
		0{[bool]$DoIuse_Microsoft_Windows_Server_2019_Base=$true}
	}

	Ask_YesOrNo "Question" "Would you like to install Base for Microsoft Windows Entreprise?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$DoIuse_Microsoft_Windows_Entreprise_Base=$false}
		0{[bool]$DoIuse_Microsoft_Windows_Entreprise_Base=$true}
	}

	} 		### END: If Microsoft Windows is to be used.

	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}

	}		### END: Switch Microsoft Windows.

	Ask_YesOrNo "Question" "Would you like to install one or more GNU/Linux machine(s)?"
	switch($Ask_YesOrNo_Result)
	{		### BEGIN: Switch GNU/Linux.
		1{[bool]$DoIuse_GNU_Linux=$false}	
		0{[bool]$DoIuse_GNU_Linux=$true 	### BEGIN: If GNU/Linux is to be used.

	Ask_YesOrNo "Question" "Would you like to install pfSense?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$DoIuse_GNU_Linux_pfSense=$false}
		0{[bool]$DoIuse_GNU_Linux_pfSense=$true}
	}

	Ask_YesOrNo "Question" "Would you like to install Debian?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$DoIuse_GNU_Linux_Debian=$false}
		0{[bool]$DoIuse_GNU_Linux_Debian=$true}
	}

	Ask_YesOrNo "Question" "Would you like to install Ubuntu?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$DoIuse_GNU_Linux_Ubuntu=$false}
		0{[bool]$DoIuse_GNU_Linux_Ubuntu=$true}
	}

	Ask_YesOrNo "Question" "Would you like to install Rocky Linux (Full)?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$DoIuse_GNU_Linux_Rocky_Linux_Full=$false}
		0{[bool]$DoIuse_GNU_Linux_Rocky_Linux_Full=$true}
	}

	Ask_YesOrNo "Question" "Would you like to install Rocky Linux (Minimal)?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$DoIuse_GNU_Linux_Rocky_Linux_Minimal=$false}
		0{[bool]$DoIuse_GNU_Linux_Rocky_Linux_Minimal=$true}
	}

	Ask_YesOrNo "Question" "Would you like to install Parrot Security?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$DoIuse_GNU_Linux_Parrot_Security=$false}
		0{[bool]$DoIuse_GNU_Linux_Parrot_Security=$true}
	}

	Ask_YesOrNo "Question" "Would you like to install Kali Linux (Live)?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$DoIuse_GNU_Linux_Kali_Linux_Live=$false}
		0{[bool]$DoIuse_GNU_Linux_Kali_Linux_Live=$true}
	}

	Ask_YesOrNo "Question" "Would you like to install Kali Linux (Installer)?"
	switch($Ask_YesOrNo_Result)
	{
		1{[bool]$DoIuse_GNU_Linux_Kali_Linux_Installer=$false}
		0{[bool]$DoIuse_GNU_Linux_Kali_Linux_Installer=$true}
	}
	
	}		### BEGIN: If GNU/Linux is to be used.

	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}

	}		### END: Switch GNU/Linux.

		### END: Customization/choice process.

		### BEGIN: Resource download process.

if($DoIuse_Microsoft_Windows_Entreprise -eq $true){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Microsoft Windows Entreprise ISO download process.";Write-Host "";HPV-Download_Base ".\src\Microsoft_Windows\clients\iso\client-windows10-entreprise-ltsc.iso" ".\src\Microsoft_Windows\clients\iso" ".\src\Microsoft_Windows\clients\iso" "https://depository.fra1.digitaloceanspaces.com/ISO_images/Microsoft_Windows/client-windows10-entreprise-ltsc.iso"}else{$null}

if($DoIuse_Microsoft_Windows_Pro -eq $true){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Microsoft Windows Pro ISO download process.";Write-Host "";HPV-Download_Base ".\src\Microsoft_Windows\clients\iso\client-windows10.iso" ".\src\Microsoft_Windows\clients\iso" ".\src\Microsoft_Windows\clients\iso" "https://depository.fra1.digitaloceanspaces.com/ISO_images/Microsoft_Windows/client-windows10.iso"}else{$null}

if($DoIuse_Microsoft_Windows_Server_2012 -eq $true){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Microsoft Windows Server 2012 ISO download process.";Write-Host "";HPV-Download_Base ".\src\Microsoft_Windows\servers\iso\win_srv-2012.iso" ".\src\Microsoft_Windows\servers\iso" ".\src\Microsoft_Windows\servers\iso" "https://depository.fra1.digitaloceanspaces.com/ISO_images/Microsoft_Windows/win_srv-2012.iso"}else{$null}

if($DoIuse_Microsoft_Windows_Server_2019 -eq $true){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Microsoft Windows Server 2019 ISO download process.";Write-Host "";HPV-Download_Base ".\src\Microsoft_Windows\servers\iso\win_srv-2019.iso" ".\src\Microsoft_Windows\servers\iso" ".\src\Microsoft_Windows\servers\iso" "https://depository.fra1.digitaloceanspaces.com/ISO_images/Microsoft_Windows/win_srv-2019.iso"}else{$null}

if($DoIuse_Microsoft_Windows_Server_2019_Base -eq $true){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Base for Microsoft Windows Server 2019 download process.";Write-Host "";HPV-Download_Base ".\src\Microsoft_Windows\servers\vhds\base\base-windows_server_2019-sysprep.vhdx" ".\src\Microsoft_Windows\servers\vhds\base" ".\src\Microsoft_Windows\servers\vhds\base" "https://depository.fra1.digitaloceanspaces.com/bases/Microsoft_Windows/base-windows_server_2019-sysprep.vhdx"}else{$null}

if($DoIuse_Microsoft_Windows_Entreprise_Base -eq $true){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Base for Microsoft Windows Server 2019 download process.";Write-Host "";HPV-Download_Base ".\src\Microsoft_Windows\clients\vhds\base\base-client-windows10-entreprise-ltsc-sysprep-autounattend.vhdx" ".\src\Microsoft_Windows\clients\vhds\base" ".\src\Microsoft_Windows\clients\vhds\base" "https://depository.fra1.digitaloceanspaces.com/bases/Microsoft_Windows/base-client-windows10-entreprise-ltsc-sysprep-autounattend.vhdx"}else{$null}

if($DoIuse_GNU_Linux_pfSense -eq $true){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the pfSense ISO download process.";Write-Host "";HPV-Download_Base ".\src\GNU_Linux\iso\pfSense-CE-2.5.1-RELEASE-amd64.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://depository.fra1.digitaloceanspaces.com/ISO_images/GNU_Linux/pfSense-CE-2.5.1-RELEASE-amd64.iso"}else{$null}

if($DoIuse_GNU_Linux_Debian -eq $true){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Debian ISO download process.";Write-Host "";HPV-Download_Base ".\src\GNU_Linux\iso\debian-11.3.0-amd64-netinst.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.3.0-amd64-netinst.iso"}else{$null}

if($DoIuse_GNU_Linux_Ubuntu -eq $true){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Ubuntu ISO download process.";Write-Host "";HPV-Download_Base ".\src\GNU_Linux\iso\ubuntu-22.04-beta-desktop-amd64.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://releases.ubuntu.com/22.04/ubuntu-22.04-desktop-amd64.iso"}else{$null}

if($DoIuse_GNU_Linux_Rocky_Linux_Full -eq $true){HWrite-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Rocky Linux (Full) ISO download process.";Write-Host "";PV-Download_Base ".\src\GNU_Linux\iso\Rocky-8.5-x86_64-dvd1.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.5-x86_64-dvd1.iso"}else{$null}

if($DoIuse_GNU_Linux_Rocky_Linux_Minimal -eq $true){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Rocky Linux (Minimal) ISO download process.";Write-Host "";HPV-Download_Base ".\src\GNU_Linux\iso\Rocky-8.5-x86_64-minimal.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.5-x86_64-minimal.iso"}else{$null}

if($DoIuse_GNU_Linux_Parrot_Security -eq $true){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Parrot Security ISO download process.";Write-Host "";HPV-Download_Base ".\src\GNU_Linux\iso\Parrot-security-5.0_amd64.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://bunny.deb.parrot.sh/parrot/iso/5.0/Parrot-security-5.0_amd64.iso"}else{$null}

if($DoIuse_GNU_Linux_Kali_Linux_Live -eq $true){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Kali Linux Live ISO download process.";Write-Host "";HPV-Download_Base ".\src\GNU_Linux\iso\kali-linux-2022.1-live-amd64.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://cdimage.kali.org/kali-images/current/kali-linux-2022.1-live-amd64.iso"}else{$null}

if($DoIuse_GNU_Linux_Kali_Linux_Installer -eq $true){Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Launching the Kali Linux Installer ISO download process.";Write-Host "";HPV-Download_Base ".\src\GNU_Linux\iso\kali-linux-2022.1-installer-amd64.iso" ".\src\GNU_Linux\iso" ".\src\GNU_Linux\iso" "https://cdimage.kali.org/kali-images/current/kali-linux-2022.1-installer-amd64.iso"}else{$null}

		### END: Resource download process.

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
    	default{Write-Host "`nInfo: " -NoNewLine;Write-Host "An unexpected error was caused. In most cases, it is an error made by the user, so take the time to answer the questions correctly." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Go back to the main menu.`n" -ForegroundColor red;pause;main}
	}

}

Check_AdministratorRights
# SIG # Begin signature block
# MIIZfgYJKoZIhvcNAQcCoIIZbzCCGWsCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUv+hA0/JfFoL62Zv6o0woqvC9
# KKGgghOSMIIFkzCCBHugAwIBAgITTQAAABkdsBkxWWfEPAAAAAAAGTANBgkqhkiG
# 9w0BAQsFADBOMRUwEwYKCZImiZPyLGQBGRYFbG9jYWwxFjAUBgoJkiaJk/IsZAEZ
# FgZhdWxuYXkxHTAbBgNVBAMTFGF1bG5heS1QS0ktQVBQLVdQLUNBMB4XDTIyMDIy
# ODA4Mjc0OFoXDTIzMDIyODA4Mjc0OFowGDEWMBQGA1UEAxMNRkVSTUFOIEZyYW5j
# azCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKw566ga9BudRr/YZ2dE
# eMaQlrDBl8twqh/t2UhOJwB6M9La1fKgI2d/cKPNOr09WQrBdvh/XLIB2MW4ifVI
# 4U93Xp/X6zjxua1fatZy0rAJqYEDtSdUZz5O/ir3OZpLyPMa/JDlL62kWCze1wcF
# I65cBr/CkOaP6rJPKQN+X9BDXyBN0If9oUrQ7jCtbLf12FQ6PefYUantGkwAS8qr
# 2vg5KEjxeDrFRnPi/z5InvZHrF5IrZlk2LzfBb59nI2Yl3RxSYnZzFPVeFcfSUIa
# WDd60ZQlPkJPArHSkrNW1rF+SsOZAJta7x42074VgFNah6MA/PlUW0U0CP71YJ8z
# SeECAwEAAaOCAp4wggKaMD4GCSsGAQQBgjcVBwQxMC8GJysGAQQBgjcVCIWfoF2F
# 6qg7g4WRH4X7zByC77crgXGC2cMKh5C7cQIBZAIBBTATBgNVHSUEDDAKBggrBgEF
# BQcDAzALBgNVHQ8EBAMCB4AwGwYJKwYBBAGCNxUKBA4wDDAKBggrBgEFBQcDAzAd
# BgNVHQ4EFgQUQjLfr3K4jmhVTRs2myIJkizIOdUwHwYDVR0jBBgwFoAUf2loKHIU
# zCWuoFOAzLgb9GQgWNYwgdYGA1UdHwSBzjCByzCByKCBxaCBwoaBv2xkYXA6Ly8v
# Q049YXVsbmF5LVBLSS1BUFAtV1AtQ0EsQ049UEtJLUFQUC1XUCxDTj1DRFAsQ049
# UHVibGljJTIwS2V5JTIwU2VydmljZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJh
# dGlvbixEQz1hdWxuYXksREM9bG9jYWw/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlz
# dD9iYXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50MIHHBggrBgEF
# BQcBAQSBujCBtzCBtAYIKwYBBQUHMAKGgadsZGFwOi8vL0NOPWF1bG5heS1QS0kt
# QVBQLVdQLUNBLENOPUFJQSxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1T
# ZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPWF1bG5heSxEQz1sb2NhbD9jQUNl
# cnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhvcml0
# eTA2BgNVHREELzAtoCsGCisGAQQBgjcUAgOgHQwbRkZlcm1hbkBhdWxuYXktc291
# cy1ib2lzLmZyMA0GCSqGSIb3DQEBCwUAA4IBAQAq9k/6Y8EAcGyH41eZItWJQbxa
# MQ7o/2XZ6tbQPivw1fEZLfj4g183qXso6PR3pvHToFLo1qai3vWA5Gx1cxyjEIom
# yWQ2wisEUNVc6DiSWBZExPSHJZGVuYu4ZSiUFIwZtnMcZmVenbblV2JL7y5N6SrG
# bnGq+U+iGVCOTQfDUGYUGVvTiuFRe6iv+qDEv+SkBPptwt5LfadqFDpTKHz0RQ0I
# +4TUp7Tgg9FuRmw1uH0jWhSba0grSFp/67hygx7FscWldGTexISV47dVFmEs0i8P
# P7SStTcejOS+ga6yKiMFCLFGqgSYUrVTmgpRmBEqa5Z8hZKcvuoo0dL8YwmQMIIG
# 7DCCBNSgAwIBAgIQMA9vrN1mmHR8qUY2p3gtuTANBgkqhkiG9w0BAQwFADCBiDEL
# MAkGA1UEBhMCVVMxEzARBgNVBAgTCk5ldyBKZXJzZXkxFDASBgNVBAcTC0plcnNl
# eSBDaXR5MR4wHAYDVQQKExVUaGUgVVNFUlRSVVNUIE5ldHdvcmsxLjAsBgNVBAMT
# JVVTRVJUcnVzdCBSU0EgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkwHhcNMTkwNTAy
# MDAwMDAwWhcNMzgwMTE4MjM1OTU5WjB9MQswCQYDVQQGEwJHQjEbMBkGA1UECBMS
# R3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9T
# ZWN0aWdvIExpbWl0ZWQxJTAjBgNVBAMTHFNlY3RpZ28gUlNBIFRpbWUgU3RhbXBp
# bmcgQ0EwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDIGwGv2Sx+iJl9
# AZg/IJC9nIAhVJO5z6A+U++zWsB21hoEpc5Hg7XrxMxJNMvzRWW5+adkFiYJ+9Uy
# UnkuyWPCE5u2hj8BBZJmbyGr1XEQeYf0RirNxFrJ29ddSU1yVg/cyeNTmDoqHvzO
# WEnTv/M5u7mkI0Ks0BXDf56iXNc48RaycNOjxN+zxXKsLgp3/A2UUrf8H5VzJD0B
# KLwPDU+zkQGObp0ndVXRFzs0IXuXAZSvf4DP0REKV4TJf1bgvUacgr6Unb+0ILBg
# frhN9Q0/29DqhYyKVnHRLZRMyIw80xSinL0m/9NTIMdgaZtYClT0Bef9Maz5yIUX
# x7gpGaQpL0bj3duRX58/Nj4OMGcrRrc1r5a+2kxgzKi7nw0U1BjEMJh0giHPYla1
# IXMSHv2qyghYh3ekFesZVf/QOVQtJu5FGjpvzdeE8NfwKMVPZIMC1Pvi3vG8Aij0
# bdonigbSlofe6GsO8Ft96XZpkyAcSpcsdxkrk5WYnJee647BeFbGRCXfBhKaBi2f
# A179g6JTZ8qx+o2hZMmIklnLqEbAyfKm/31X2xJ2+opBJNQb/HKlFKLUrUMcpEmL
# QTkUAx4p+hulIq6lw02C0I3aa7fb9xhAV3PwcaP7Sn1FNsH3jYL6uckNU4B9+rY5
# WDLvbxhQiddPnTO9GrWdod6VQXqngwIDAQABo4IBWjCCAVYwHwYDVR0jBBgwFoAU
# U3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYEFBqh+GEZIA/DQXdFKI7RNV8G
# EgRVMA4GA1UdDwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMBMGA1UdJQQM
# MAoGCCsGAQUFBwMIMBEGA1UdIAQKMAgwBgYEVR0gADBQBgNVHR8ESTBHMEWgQ6BB
# hj9odHRwOi8vY3JsLnVzZXJ0cnVzdC5jb20vVVNFUlRydXN0UlNBQ2VydGlmaWNh
# dGlvbkF1dGhvcml0eS5jcmwwdgYIKwYBBQUHAQEEajBoMD8GCCsGAQUFBzAChjNo
# dHRwOi8vY3J0LnVzZXJ0cnVzdC5jb20vVVNFUlRydXN0UlNBQWRkVHJ1c3RDQS5j
# cnQwJQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnVzZXJ0cnVzdC5jb20wDQYJKoZI
# hvcNAQEMBQADggIBAG1UgaUzXRbhtVOBkXXfA3oyCy0lhBGysNsqfSoF9bw7J/Ra
# oLlJWZApbGHLtVDb4n35nwDvQMOt0+LkVvlYQc/xQuUQff+wdB+PxlwJ+TNe6qAc
# Jlhc87QRD9XVw+K81Vh4v0h24URnbY+wQxAPjeT5OGK/EwHFhaNMxcyyUzCVpNb0
# llYIuM1cfwGWvnJSajtCN3wWeDmTk5SbsdyybUFtZ83Jb5A9f0VywRsj1sJVhGbk
# s8VmBvbz1kteraMrQoohkv6ob1olcGKBc2NeoLvY3NdK0z2vgwY4Eh0khy3k/ALW
# PncEvAQ2ted3y5wujSMYuaPCRx3wXdahc1cFaJqnyTdlHb7qvNhCg0MFpYumCf/R
# oZSmTqo9CfUFbLfSZFrYKiLCS53xOV5M3kg9mzSWmglfjv33sVKRzj+J9hyhtal1
# H3G/W0NdZT1QgW6r8NDT/LKzH7aZlib0PHmLXGTMze4nmuWgwAxyh8FuTVrTHurw
# ROYybxzrF06Uw3hlIDsPQaof6aFBnf6xuKBlKjTg3qj5PObBMLvAoGMs/FwWAKjQ
# xH/qEZ0eBsambTJdtDgJK0kHqv3sMNrxpy/Pt/360KOE2See+wFmd7lWEOEgbsau
# sfm2usg1XTN2jvF8IAwqd661ogKGuinutFoAsYyr4/kKyVRd1LlqdJ69SK6YMIIH
# BzCCBO+gAwIBAgIRAIx3oACP9NGwxj2fOkiDjWswDQYJKoZIhvcNAQEMBQAwfTEL
# MAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UE
# BxMHU2FsZm9yZDEYMBYGA1UEChMPU2VjdGlnbyBMaW1pdGVkMSUwIwYDVQQDExxT
# ZWN0aWdvIFJTQSBUaW1lIFN0YW1waW5nIENBMB4XDTIwMTAyMzAwMDAwMFoXDTMy
# MDEyMjIzNTk1OVowgYQxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1h
# bmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGlt
# aXRlZDEsMCoGA1UEAwwjU2VjdGlnbyBSU0EgVGltZSBTdGFtcGluZyBTaWduZXIg
# IzIwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCRh0ssi8HxHqCe0wfG
# AcpSsL55eV0JZgYtLzV9u8D7J9pCalkbJUzq70DWmn4yyGqBfbRcPlYQgTU6IjaM
# +/ggKYesdNAbYrw/ZIcCX+/FgO8GHNxeTpOHuJreTAdOhcxwxQ177MPZ45fpyxnb
# VkVs7ksgbMk+bP3wm/Eo+JGZqvxawZqCIDq37+fWuCVJwjkbh4E5y8O3Os2fUAQf
# GpmkgAJNHQWoVdNtUoCD5m5IpV/BiVhgiu/xrM2HYxiOdMuEh0FpY4G89h+qfNfB
# Qc6tq3aLIIDULZUHjcf1CxcemuXWmWlRx06mnSlv53mTDTJjU67MximKIMFgxvIC
# LMT5yCLf+SeCoYNRwrzJghohhLKXvNSvRByWgiKVKoVUrvH9Pkl0dPyOrj+lcvTD
# WgGqUKWLdpUbZuvv2t+ULtka60wnfUwF9/gjXcRXyCYFevyBI19UCTgqYtWqyt/t
# z1OrH/ZEnNWZWcVWZFv3jlIPZvyYP0QGE2Ru6eEVYFClsezPuOjJC77FhPfdCp3a
# vClsPVbtv3hntlvIXhQcua+ELXei9zmVN29OfxzGPATWMcV+7z3oUX5xrSR0Gyzc
# +Xyq78J2SWhi1Yv1A9++fY4PNnVGW5N2xIPugr4srjcS8bxWw+StQ8O3ZpZelDL6
# oPariVD6zqDzCIEa0USnzPe4MQIDAQABo4IBeDCCAXQwHwYDVR0jBBgwFoAUGqH4
# YRkgD8NBd0UojtE1XwYSBFUwHQYDVR0OBBYEFGl1N3u7nTVCTr9X05rbnwHRrt7Q
# MA4GA1UdDwEB/wQEAwIGwDAMBgNVHRMBAf8EAjAAMBYGA1UdJQEB/wQMMAoGCCsG
# AQUFBwMIMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQMIMCUwIwYIKwYBBQUHAgEW
# F2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMEQGA1UdHwQ9MDswOaA3oDWGM2h0dHA6
# Ly9jcmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQVRpbWVTdGFtcGluZ0NBLmNybDB0
# BggrBgEFBQcBAQRoMGYwPwYIKwYBBQUHMAKGM2h0dHA6Ly9jcnQuc2VjdGlnby5j
# b20vU2VjdGlnb1JTQVRpbWVTdGFtcGluZ0NBLmNydDAjBggrBgEFBQcwAYYXaHR0
# cDovL29jc3Auc2VjdGlnby5jb20wDQYJKoZIhvcNAQEMBQADggIBAEoDeJBCM+x7
# GoMJNjOYVbudQAYwa0Vq8ZQOGVD/WyVeO+E5xFu66ZWQNze93/tk7OWCt5XMV1Vw
# S070qIfdIoWmV7u4ISfUoCoxlIoHIZ6Kvaca9QIVy0RQmYzsProDd6aCApDCLpOp
# viE0dWO54C0PzwE3y42i+rhamq6hep4TkxlVjwmQLt/qiBcW62nW4SW9RQiXgNdU
# IChPynuzs6XSALBgNGXE48XDpeS6hap6adt1pD55aJo2i0OuNtRhcjwOhWINoF5w
# 22QvAcfBoccklKOyPG6yXqLQ+qjRuCUcFubA1X9oGsRlKTUqLYi86q501oLnwIi4
# 4U948FzKwEBcwp/VMhws2jysNvcGUpqjQDAXsCkWmcmqt4hJ9+gLJTO1P22vn18K
# Vt8SscPuzpF36CAT6Vwkx+pEC0rmE4QcTesNtbiGoDCni6GftCzMwBYjyZHlQgNL
# gM7kTeYqAT7AXoWgJKEXQNXb2+eYEKTx6hkbgFT6R4nomIGpdcAO39BolHmhoJ6O
# trdCZsvZ2WsvTdjePjIeIOTsnE1CjZ3HM5mCN0TUJikmQI54L7nu+i/x8Y/+ULh4
# 3RSW3hwOcLAqhWqxbGjpKuQQK24h/dN8nTfkKgbWw/HXaONPB3mBCBP+smRe6bE8
# 5tB4I7IJLOImYr87qZdRzMdEMoGyr8/fMYIFVjCCBVICAQEwZTBOMRUwEwYKCZIm
# iZPyLGQBGRYFbG9jYWwxFjAUBgoJkiaJk/IsZAEZFgZhdWxuYXkxHTAbBgNVBAMT
# FGF1bG5heS1QS0ktQVBQLVdQLUNBAhNNAAAAGR2wGTFZZ8Q8AAAAAAAZMAkGBSsO
# AwIaBQCgeDAYBgorBgEEAYI3AgEMMQowCKACgAChAoAAMBkGCSqGSIb3DQEJAzEM
# BgorBgEEAYI3AgEEMBwGCisGAQQBgjcCAQsxDjAMBgorBgEEAYI3AgEVMCMGCSqG
# SIb3DQEJBDEWBBQe8aDTYD2qzF/i2ZGpDaN8LU/HRjANBgkqhkiG9w0BAQEFAASC
# AQCm8wj2bmbnEGfuzfDiVA+1jySyZbT/ILsZKAfihgXtOJWZYx+Ymp0CVPjBCHrX
# Y3fiq5vXNJKyoH/mlt09vGbMAd+eHy1DMtkFZ5pXsrEdx0ywji8oMOMrrtyHWq/P
# A9jCZC+L5bEXuFfHBd9oq3yMlJ31x22edeZUKP3jMujhTD+9E4ucncS/3R4eKHCw
# 59FcVav4ez6NqNhCPPbX6ULifYLNbDI3kbMPu0eRcejfKqtxjRkKnlPxWo6oIVpN
# JzQc5m1c6uwnxwAA/nxd6Zzd3chdWUZpEf7f5aENzVwhk2DRkur911cz4gHGXjW2
# 2/Fsuzwj9lM7SLmR9rUxdzAfoYIDTDCCA0gGCSqGSIb3DQEJBjGCAzkwggM1AgEB
# MIGSMH0xCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIx
# EDAOBgNVBAcTB1NhbGZvcmQxGDAWBgNVBAoTD1NlY3RpZ28gTGltaXRlZDElMCMG
# A1UEAxMcU2VjdGlnbyBSU0EgVGltZSBTdGFtcGluZyBDQQIRAIx3oACP9NGwxj2f
# OkiDjWswDQYJYIZIAWUDBAICBQCgeTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
# MBwGCSqGSIb3DQEJBTEPFw0yMjA0MTIyMjQyNDZaMD8GCSqGSIb3DQEJBDEyBDAF
# uT/Fk6+e16nmfaDFhmz0SNxFxzT3tKfgq+Sc7JDhA+LHCa3Fz3Xx8T/Rj6sZbvgw
# DQYJKoZIhvcNAQEBBQAEggIASiPpP7bTUhhkqjvGG5cMeOIE7kUfOEHQ5QlXXfJ6
# hauogH1TYf3RgJB68stAvDYDPiVaNuMDtI8Rq2FvBjx4Fh6EFjpnA2H3CV8EGFBA
# qfzOwtOU6xfQXdXNZhTKey2c+AU7s4Qtepw6WdGKklJirU7/CMZphIRNEz88GML5
# ENyeXH4Pt4oQRNSc1PXdyDiysCrn3TpQ6YmpAR1oMgDdwiInNZKWQNqXBczqI2oU
# DdUrWN+qYShE/rgw3cbkfFxEDlm17iyA0bF212+CvUHTaaMBEmZqNaNGdYe4Qo2A
# v/LmaQCDnXFNLdrvOOq5Kk3HLMXv3QO/b/qNsYXXyLtFI7s/VswLBmFHxqLkZxSE
# +tKG+QA/KQhxyMGJBZi17W1kDbfjinnjbV1zdZl/2Io5LwbvBzZuggla0bCQ7ngM
# PONxyUPFbl04naQJ/SW3c+X8rHKaGHXntpUBDE/DnoLsXwPjbKBZ4lRcGrD7V+AH
# pME6cRCxvXMT/2KgPRUCvFQ7N3lqi4PjeQBZQAGI3jkzfnxJ8eaokL/ky0Y7C0zI
# 6Hkztvp+xhX0J8XSO3wwQL7+VPIdW9eXJPNDF443Wz25/mY233wBo5oxk9XJg+Dq
# q2jjDCbRinX1wmWidhfZ+gb/TMe8pa/AWnzzpmxeB2gTPT7OY614BxrbvIEFy5cQ
# bZU=
# SIG # End signature block
