<#hyper-v_toolbox

Author: Franck FERMAN - fferman@protonmail.ch
Version: 1.0
#>

$script:Get_WindowTitle=$host.ui.RawUI.WindowTitle

function Check_AdminRights
{
$is_Admin = (New-Object System.Security.Principal.WindowsPrincipal([System.Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)

switch ($is_Admin)
{
    True{main}
    False{Write-Host "Error, please run Powershell in administrator mode." -ForegroundColor red}
    default {Write-Host "Error 520: Unknown Error." -ForegroundColor red}
}
}

function main
{
$host.ui.RawUI.WindowTitle="Hyper-V Toolbox - Franck FERMAN"
Clear-Host
Write-Host ""
Write-Host "                               _oo0oo_                  " -ForegroundColor darkyellow
Write-Host "                              o8888888o                 " -ForegroundColor darkyellow
Write-Host "                              88`" . `"88               " -ForegroundColor darkyellow
Write-Host "                              (| -_- |)                 " -ForegroundColor darkyellow
Write-Host "                              0\  =  /0                 " -ForegroundColor darkyellow
Write-Host "                            ___/`----'\___              " -ForegroundColor darkyellow
Write-Host "                          .' \\|     |// '.             " -ForegroundColor darkyellow
Write-Host "                         / \\|||  :  |||// \            " -ForegroundColor darkyellow
Write-Host "                        / _||||| -:- |||||- \           " -ForegroundColor darkyellow
Write-Host "                       |   | \\\  -  /// |   |          " -ForegroundColor darkyellow
Write-Host "                       | \_|  ''\---/''  |_/ |          " -ForegroundColor darkyellow
Write-Host "                       \  .-\__  '-'  ___/-. /          " -ForegroundColor darkyellow
Write-Host "                     ___'. .'  /--.--\  `. .'___        " -ForegroundColor darkyellow
Write-Host "                  .`"`" '<  `.___\_<|>_/___.' >' `"`".  " -ForegroundColor darkyellow
Write-Host "                 | | :  `- \`.;`\ _ /`;.`/ - ` : | |    " -ForegroundColor darkyellow
Write-Host "                 \  \ `_.   \_ __\ /__ _/   .-` /  /    " -ForegroundColor darkyellow
Write-Host "             =====`-.____`.___ \_____/___.-`___.-'===== " -ForegroundColor darkyellow
Write-Host "                               `=---='                  " -ForegroundColor darkyellow
Write-Host ""
Write-Host "  _  _                      __   __  _____         _ _             " -ForegroundColor darkyellow
Write-Host " | || |_  _ _ __  ___ _ _ __\ \ / / |_   _|__  ___| | |__  _____ __" -ForegroundColor darkyellow
Write-Host " | __ | || | '_ \/ -_) '_|___\ V /    | |/ _ \/ _ \ | '_ \/ _ \ \ /" -ForegroundColor darkyellow
Write-Host " |_||_|\_, | .__/\___|_|      \_/     |_|\___/\___/_|_.__/\___/_\_\" -ForegroundColor darkyellow
Write-Host "       |__/|_|                                                     " -ForegroundColor darkyellow
Write-Host ""

Write-Host "Hello dear " -NoNewline
Write-Host "$env:UserName " -NoNewLine -ForegroundColor green
Write-Host "and welcome to " -NoNewLine
Write-Host "Hyper-V Toolbox" -NonewLine -ForegroundColor green
Write-Host "."
Write-Host ""
Write-Host "1 - Creation of (blank) virtual machine(s)."
Write-Host "2 - Creation of pre-configured virtual machines (from a template)."
Write-Host ""
Write-Host "3 - Management of virtual machines."
Write-Host "4 - Management of virtual switches."
Write-Host ""
Write-Host "5 - Resource management and local downloading."
Write-Host ""
Write-Host "9 - Quit the program." -ForegroundColor red
Write-Host ""

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{
    1{HPV-New_VM}
    2{HPV-New_VM_FromTemplate}
    3{HPV-VM_Management}
    4{HPV-Virtual_Switches_Management}
    5{resource_management}
    
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400: The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function HPV-New_VM
{
Clear-Host
Write-Host "1 - Microsoft Windows"
Write-Host "2 - GNU/Linux"
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{
    1{HPV-New_VM-Microsoft_Windows}
    2{HPV-New_VM-GNU_Linux}
    
    8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main}
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400: The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function HPV-New_VM-Microsoft_Windows
{
Clear-Host
Write-Host "1 - Windows 10 Entreprise (LTSC)"
Write-Host ""
Write-Host "2 - Windows Server 2012"
Write-Host "3 - Windows Server 2019"
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{
    1{HPV-New_VM-Client_Windows10}

    2{HPV-New_VM-Server_2012}
    3{HPV-New_VM-Server_2019}

    8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main}
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400 : The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function HPV-New_VM-Client_Windows10
{
Clear-Host
$VMname = Read-Host "Virtual machine name"
Write-Host "Info: " -NoNewLine
Write-Host "The name chosen for the virtual machine is : $VMname" -ForegroundColor green
Write-Host ""

$Get_VMSwitch=Get-VMSwitch
$VMList=@()
$Get_VMSwitch|ForEach-Object {$VMList+=$_.Name}
Write-Host "Ongoing action: " -NoNewLine
Write-Host "List of virtual switches.`n" -ForegroundColor green
For($i=0;$i -lt $VMList.Length;$i++){Write-Host "$i - $($VMList[$i])"}
Write-Host ""
$userChoice=Read-Host "Which virtual switch do you want to choose"
$VMchoice=$VMList[$userChoice]
$SwitchName=$VMchoice
Write-Host "Info: " -NoNewLine
Write-Host "The chosen virtual switch is : $SwitchName" -ForegroundColor green

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "ISO management and verification."
if(Test-Path ".\src\Microsoft_Windows\clients\iso\client-windows10-entreprise-ltsc.iso")
{
Write-Host "Info: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://images-data.fra1.digitaloceanspaces.com/client-windows10-entreprise-ltsc.iso"

$dest=".\src\Microsoft_Windows\clients\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\Microsoft_Windows\clients\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}

$GBSizeList=@('1GB','2GB','4GB','8GB')
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Memory startup bytes list.`n" -ForegroundColor green
For($i=0;$i -lt $GBSizeList.Length;$i++){Write-Host "$i - $($GBSizeList[$i])"}
Write-Host ""
$userChoice=Read-Host "Memory startup bytes choice"
$GBchoice=$GBSizeList[$userChoice]
$MemStartupBytes=$GBchoice
Write-Host "Info: " -NoNewLine
Write-Host "The chosen memory startup bytes is : $MemStartupBytes" -ForegroundColor green

switch($MemStartupBytes)
{
    "1GB"{$MemStartupBytes=1GB}
    "2GB"{$MemStartupBytes=2GB}
    "4GB"{$MemStartupBytes=4GB}
    "8GB"{$MemStartupBytes=8GB}
}

$GenerationChoice=Read-Host "`nChoose the generation of the machine (1 or 2)"
Write-Host "Info: " -NoNewLine
Write-Host "The chosen generation is : $GenerationChoice" -ForegroundColor green

$VHDGBSizeList=@('20GB','32GB','48GB','64GB','80GB','120GB')
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "List of possible disk sizes.`n" -ForegroundColor green
For($i=0;$i -lt $VHDGBSizeList.Length;$i++){Write-Host "$i - $($VHDGBSizeList[$i])"}
Write-Host ""
$userChoice=Read-Host "Choose the hard drive size"
$GBchoice=$VHDGBSizeList[$userChoice]
$VHDGBSize=$GBchoice
Write-Host "`nInfo: " -NoNewLine
Write-Host "The chosen hard disk size is : $VHDGBSize" -ForegroundColor green

switch($VHDGBSize)
{
    "20GB"{$VHDGBSize=20GB}
    "32GB"{$VHDGBSize=32GB}
    "48GB"{$VHDGBSize=48GB}
    "64GB"{$VHDGBSize=64GB}
    "80GB"{$VHDGBSize=80GB}
    "120GB"{$VHDGBSize=120GB}
}

if(Test-Path ".\src\Microsoft_Windows\clients\vhds\")
{
$null
}else{
New-Item -Name ".\src\Microsoft_Windows\clients\vhds\" -ItemType Directory -Force|Out-Null
}

if(Test-Path ".\src\Microsoft_Windows\clients\vms\")
{
$null
}else{
New-Item -Name ".\src\Microsoft_Windows\clients\vms\" -ItemType Directory -Force|Out-Null
}

New-VM -Name $VMName -MemoryStartupBytes $MemStartupBytes -Generation $GenerationChoice -NewVHDPath ".\src\Microsoft_Windows\clients\vhds\$VMName.vhdx" -NewVHDSizeBytes $VHDGBSize -Path ".\src\Microsoft_Windows\clients\vms\$VMName" -SwitchName $SwitchName

Add-VMDvdDrive -VMName $VMName -Path ".\src\Microsoft_Windows\clients\iso\client-windows10-entreprise-ltsc.iso"
$myVM=Get-VMFirmware $VMName
$HDD = $myVM.BootOrder[0]
$PXE = $myVM.BootOrder[1]
$DVD = $myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VM -Name $VMName -AutomaticCheckpointsEnabled $false

Write-Host ""
Write-Host "1 - Recreate exactly the same machine (with the same characteristics)."
Write-Host "2 - Recreate another machine (but with different characteristics)."
Write-Host ""
Write-Host "8 - Back to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{
    1{HPV-Copy_Same_VM-Client_Windows10}
    2{HPV-New_VM-Client_Windows10}

    8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main}
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";Clear-Host;exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400 : The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function HPV-Copy_Same_VM-Client_Windows10
{
Clear-Host
$VMname = Read-Host "Virtual machine name"
Write-Host "Info: " -NoNewLine
Write-Host "The name chosen for the virtual machine is : $VMname" -ForegroundColor green

New-VM -Name $VMName -MemoryStartupBytes $MemStartupBytes -Generation $GenerationChoice -NewVHDPath ".\src\Microsoft_Windows\clients\vhds\$VMName.vhdx" -NewVHDSizeBytes $VHDGBSize -Path ".\src\Microsoft_Windows\clients\vms\$VMName" -SwitchName $SwitchName

Add-VMDvdDrive -VMName $VMName -Path ".\src\Microsoft_Windows\clients\iso\client-windows10-entreprise-ltsc.iso"
$myVM=Get-VMFirmware $VMName
$HDD = $myVM.BootOrder[0]
$PXE = $myVM.BootOrder[1]
$DVD = $myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VM -Name $VMName -AutomaticCheckpointsEnabled $false

Write-Host ""
Write-Host "1 - Recreate exactly the same machine (with the same characteristics)."
Write-Host "2 - Recreate another machine (but with different characteristics)."
Write-Host ""
Write-Host "8 - Back to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{
    1{HPV-Copy_Same_VM-Client_Windows10}
    2{HPV-New_VM-Client_Windows10}

    8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main}
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400 : The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function HPV-New_VM-Server_2012
{
Clear-Host
$VMname = Read-Host "Virtual machine name"
Write-Host "Info: " -NoNewLine
Write-Host "The name chosen for the virtual machine is : $VMname" -ForegroundColor green
Write-Host ""

$Get_VMSwitch=Get-VMSwitch
$VMList=@()
$Get_VMSwitch|ForEach-Object {$VMList+=$_.Name}
Write-Host "Ongoing action: " -NoNewLine
Write-Host "List of virtual switches.`n" -ForegroundColor green
For($i=0;$i -lt $VMList.Length;$i++){Write-Host "$i - $($VMList[$i])"}
Write-Host ""
$userChoice=Read-Host "Which virtual switch do you want to choose"
$VMchoice=$VMList[$userChoice]
$SwitchName=$VMchoice
Write-Host "Info: " -NoNewLine
Write-Host "The chosen virtual switch is : $SwitchName" -ForegroundColor green

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "ISO management and verification."
if(Test-Path ".\src\Microsoft_Windows\servers\iso\win_srv-2012.iso")
{
Write-Host "Info: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://images-data.fra1.digitaloceanspaces.com/win_srv-2012.iso"

$dest=".\src\Microsoft_Windows\servers\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\Microsoft_Windows\servers\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}

$GBSizeList=@('1GB','2GB','4GB','8GB')
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Memory startup bytes list.`n" -ForegroundColor green
For($i=0;$i -lt $GBSizeList.Length;$i++){Write-Host "$i - $($GBSizeList[$i])"}
Write-Host ""
$userChoice=Read-Host "Memory startup bytes choice"
$GBchoice=$GBSizeList[$userChoice]
$MemStartupBytes=$GBchoice
Write-Host "Info: " -NoNewLine
Write-Host "The chosen memory startup bytes is : $MemStartupBytes" -ForegroundColor green

switch($MemStartupBytes)
{
    "1GB"{$MemStartupBytes=1GB}
    "2GB"{$MemStartupBytes=2GB}
    "4GB"{$MemStartupBytes=4GB}
    "8GB"{$MemStartupBytes=8GB}
}

$GenerationChoice=Read-Host "`nChoose the generation of the machine (1 or 2)"
Write-Host "Info: " -NoNewLine
Write-Host "The chosen generation is : $GenerationChoice" -ForegroundColor green

$VHDGBSizeList=@('20GB','32GB','48GB','64GB','80GB','120GB')
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "List of possible disk sizes.`n" -ForegroundColor green
For($i=0;$i -lt $VHDGBSizeList.Length;$i++){Write-Host "$i - $($VHDGBSizeList[$i])"}
Write-Host ""
$userChoice=Read-Host "Choose the hard drive size"
$GBchoice=$VHDGBSizeList[$userChoice]
$VHDGBSize=$GBchoice
Write-Host "`nInfo: " -NoNewLine
Write-Host "The chosen hard disk size is : $VHDGBSize" -ForegroundColor green

switch($VHDGBSize)
{
    "20GB"{$VHDGBSize=20GB}
    "32GB"{$VHDGBSize=32GB}
    "48GB"{$VHDGBSize=48GB}
    "64GB"{$VHDGBSize=64GB}
    "80GB"{$VHDGBSize=80GB}
    "120GB"{$VHDGBSize=120GB}
}

if(Test-Path ".\src\Microsoft_Windows\servers\vhds\")
{
$null
}else{
New-Item -Name ".\src\Microsoft_Windows\servers\vhds\" -ItemType Directory -Force|Out-Null
}

if(Test-Path ".\src\Microsoft_Windows\servers\vms\")
{
$null
}else{
New-Item -Name ".\src\Microsoft_Windows\servers\vms\" -ItemType Directory -Force|Out-Null
}

New-VM -Name $VMName -MemoryStartupBytes $MemStartupBytes -Generation $GenerationChoice -NewVHDPath ".\src\Microsoft_Windows\clients\vhds\$VMName.vhdx" -NewVHDSizeBytes $VHDGBSize -Path ".\src\Microsoft_Windows\servers\vms\$VMName" -SwitchName $SwitchName

Add-VMDvdDrive -VMName $VMName -Path ".\src\Microsoft_Windows\servers\iso\win_srv-2012.iso"
$myVM=Get-VMFirmware $VMName
$HDD = $myVM.BootOrder[0]
$PXE = $myVM.BootOrder[1]
$DVD = $myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VM -Name $VMName -AutomaticCheckpointsEnabled $false

Write-Host ""
Write-Host "1 - Recreate exactly the same machine (with the same characteristics)."
Write-Host "2 - Recreate another machine (but with different characteristics)."
Write-Host ""
Write-Host "8 - Back to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{
    1{HPV-Copy_Same_VM-Server_2012}
    2{HPV-New_VM-Server_2012}

    8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main}
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";Clear-Host;exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400 : The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function HPV-Copy_Same_VM-Server_2012
{
Clear-Host
$VMname = Read-Host "Virtual machine name"
Write-Host "Info: " -NoNewLine
Write-Host "The name chosen for the virtual machine is : $VMname" -ForegroundColor green

New-VM -Name $VMName -MemoryStartupBytes $MemStartupBytes -Generation $GenerationChoice -NewVHDPath ".\src\Microsoft_Windows\servers\vhds\$VMName.vhdx" -NewVHDSizeBytes $VHDGBSize -Path ".\src\Microsoft_Windows\servers\vms\$VMName" -SwitchName $SwitchName

Add-VMDvdDrive -VMName $VMName -Path ".\src\Microsoft_Windows\servers\iso\win_srv-2012.iso"
$myVM=Get-VMFirmware $VMName
$HDD = $myVM.BootOrder[0]
$PXE = $myVM.BootOrder[1]
$DVD = $myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VM -Name $VMName -AutomaticCheckpointsEnabled $false

Write-Host ""
Write-Host "1 - Recreate exactly the same machine (with the same characteristics)."
Write-Host "2 - Recreate another machine (but with different characteristics)."
Write-Host ""
Write-Host "8 - Back to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{
    1{HPV-Copy_Same_VM-Server_2012}
    2{HPV-New_VM-Server_2012}

    8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main}
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400 : The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function HPV-New_VM-Server_2019
{
Clear-Host
$VMname = Read-Host "Virtual machine name"
Write-Host "Info: " -NoNewLine
Write-Host "The name chosen for the virtual machine is : $VMname" -ForegroundColor green
Write-Host ""

$Get_VMSwitch=Get-VMSwitch
$VMList=@()
$Get_VMSwitch|ForEach-Object {$VMList+=$_.Name}
Write-Host "Ongoing action: " -NoNewLine
Write-Host "List of virtual switches.`n" -ForegroundColor green
For($i=0;$i -lt $VMList.Length;$i++){Write-Host "$i - $($VMList[$i])"}
Write-Host ""
$userChoice=Read-Host "Which virtual switch do you want to choose"
$VMchoice=$VMList[$userChoice]
$SwitchName=$VMchoice
Write-Host "Info: " -NoNewLine
Write-Host "The chosen virtual switch is : $SwitchName" -ForegroundColor green

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "ISO management and verification."
if(Test-Path ".\src\Microsoft_Windows\servers\iso\win_srv-2019.iso")
{
Write-Host "Info: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://images-data.fra1.digitaloceanspaces.com/win_srv-2019.iso"

$dest=".\src\Microsoft_Windows\servers\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\Microsoft_Windows\servers\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}

$GBSizeList=@('1GB','2GB','4GB','8GB')
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Memory startup bytes list.`n" -ForegroundColor green
For($i=0;$i -lt $GBSizeList.Length;$i++){Write-Host "$i - $($GBSizeList[$i])"}
Write-Host ""
$userChoice=Read-Host "Memory startup bytes choice"
$GBchoice=$GBSizeList[$userChoice]
$MemStartupBytes=$GBchoice
Write-Host "Info: " -NoNewLine
Write-Host "The chosen memory startup bytes is : $MemStartupBytes" -ForegroundColor green

switch($MemStartupBytes)
{
    "1GB"{$MemStartupBytes=1GB}
    "2GB"{$MemStartupBytes=2GB}
    "4GB"{$MemStartupBytes=4GB}
    "8GB"{$MemStartupBytes=8GB}
}

$GenerationChoice=Read-Host "`nChoose the generation of the machine (1 or 2)"
Write-Host "Info: " -NoNewLine
Write-Host "The chosen generation is : $GenerationChoice" -ForegroundColor green

$VHDGBSizeList=@('20GB','32GB','48GB','64GB','80GB','120GB')
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "List of possible disk sizes.`n" -ForegroundColor green
For($i=0;$i -lt $VHDGBSizeList.Length;$i++){Write-Host "$i - $($VHDGBSizeList[$i])"}
Write-Host ""
$userChoice=Read-Host "Choose the hard drive size"
$GBchoice=$VHDGBSizeList[$userChoice]
$VHDGBSize=$GBchoice
Write-Host "`nInfo: " -NoNewLine
Write-Host "The chosen hard disk size is : $VHDGBSize" -ForegroundColor green

switch($VHDGBSize)
{
    "20GB"{$VHDGBSize=20GB}
    "32GB"{$VHDGBSize=32GB}
    "48GB"{$VHDGBSize=48GB}
    "64GB"{$VHDGBSize=64GB}
    "80GB"{$VHDGBSize=80GB}
    "120GB"{$VHDGBSize=120GB}
}

if(Test-Path ".\src\Microsoft_Windows\servers\vhds\")
{
$null
}else{
New-Item -Name ".\src\Microsoft_Windows\servers\vhds\" -ItemType Directory -Force|Out-Null
}

if(Test-Path ".\src\Microsoft_Windows\servers\vms\")
{
$null
}else{
New-Item -Name ".\src\Microsoft_Windows\servers\vms\" -ItemType Directory -Force|Out-Null
}

New-VM -Name $VMName -MemoryStartupBytes $MemStartupBytes -Generation $GenerationChoice -NewVHDPath ".\src\Microsoft_Windows\clients\vhds\$VMName.vhdx" -NewVHDSizeBytes $VHDGBSize -Path ".\src\Microsoft_Windows\servers\vms\$VMName" -SwitchName $SwitchName

Add-VMDvdDrive -VMName $VMName -Path ".\src\Microsoft_Windows\servers\iso\win_srv-2019.iso"
$myVM=Get-VMFirmware $VMName
$HDD = $myVM.BootOrder[0]
$PXE = $myVM.BootOrder[1]
$DVD = $myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VM -Name $VMName -AutomaticCheckpointsEnabled $false

Write-Host ""
Write-Host "1 - Recreate exactly the same machine (with the same characteristics)."
Write-Host "2 - Recreate another machine (but with different characteristics)."
Write-Host ""
Write-Host "8 - Back to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{
    1{HPV-Copy_Same_VM-Server_2019}
    2{HPV-New_VM-Server_2019}

    8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main}
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";Clear-Host;exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400 : The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function HPV-Copy_Same_VM-Server_2019
{
Clear-Host
$VMname = Read-Host "Virtual machine name"
Write-Host "Info: " -NoNewLine
Write-Host "The name chosen for the virtual machine is : $VMname" -ForegroundColor green

New-VM -Name $VMName -MemoryStartupBytes $MemStartupBytes -Generation $GenerationChoice -NewVHDPath ".\src\Microsoft_Windows\servers\vhds\$VMName.vhdx" -NewVHDSizeBytes $VHDGBSize -Path ".\src\Microsoft_Windows\servers\vms\$VMName" -SwitchName $SwitchName

Add-VMDvdDrive -VMName $VMName -Path ".\src\Microsoft_Windows\servers\iso\win_srv-2019.iso"
$myVM=Get-VMFirmware $VMName
$HDD = $myVM.BootOrder[0]
$PXE = $myVM.BootOrder[1]
$DVD = $myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VM -Name $VMName -AutomaticCheckpointsEnabled $false

Write-Host ""
Write-Host "1 - Recreate exactly the same machine (with the same characteristics)."
Write-Host "2 - Recreate another machine (but with different characteristics)."
Write-Host ""
Write-Host "8 - Back to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{
    1{HPV-Copy_Same_VM-Server_2019}
    2{HPV-New_VM-Server_2019}

    8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main}
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400 : The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function HPV-New_VM-GNU_Linux
{
Clear-Host
Write-Host "0 - pfsense (CE, 2.5)"
Write-Host ""
Write-Host "1 - Debian (11)"
Write-Host "2 - Ubuntu (22.04)"
Write-Host ""
Write-Host "3 - Rocky Linux (Full, 8)"
Write-Host "4 - Rocky Linux (Minimal, 8)"
Write-Host ""
Write-Host "5 - Parrot Security (5.0)"
Write-Host "6 - Kali (Live, 2022.1)"
Write-Host "7 - Kali (Installer, 2022.1)"
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

<#
https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.3.0-amd64-netinst.iso
https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.5-x86_64-dvd1.iso
https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.5-x86_64-minimal.iso
https://bunny.deb.parrot.sh/parrot/iso/5.0/Parrot-security-5.0_amd64.iso
https://ftp.u-strasbg.fr/linux/distributions/archlinux/iso/2022.04.01/archlinux-2022.04.01-x86_64.iso
https://cdimage.kali.org/kali-images/current/kali-linux-2022.1-live-amd64.iso
https://cdimage.kali.org/kali-images/current/kali-linux-2022.1-installer-amd64.iso
https://ubuntu.univ-nantes.fr/ubuntu-cd/22.04/ubuntu-22.04-beta-desktop-amd64.iso
https://ubuntu.univ-nantes.fr/ubuntu-cd/20.04.4/ubuntu-20.04.4-desktop-amd64.iso
https://ubuntu.univ-nantes.fr/ubuntu-cd/18.04.6/ubuntu-18.04.6-desktop-amd64.iso
https://nyifiles.netgate.com/mirror/downloads/pfSense-CE-2.5.1-RELEASE-amd64.iso.gz
#>

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{
    
    0{HPV-New_VM-pfsense}

    1{HPV-New_VM-debian}
    2{HPV-New_VM-ubuntu}

    3{HPV-New_VM-rocky-full}
    4{HPV-New_VM-rocky-min}

    5{HPV-New_VM-parrot}
    6{HPV-New_VM-kali-live}
    7{HPV-New_VM-kali-installer}

    8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main}
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400 : The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function HPV-New_VM-debian
{
Clear-Host
$VMname = Read-Host "Virtual machine name"
Write-Host "Info: " -NoNewLine
Write-Host "The name chosen for the virtual machine is : $VMname" -ForegroundColor green
Write-Host ""

$Get_VMSwitch=Get-VMSwitch
$VMList=@()
$Get_VMSwitch|ForEach-Object {$VMList+=$_.Name}
Write-Host "Ongoing action: " -NoNewLine
Write-Host "List of virtual switches.`n" -ForegroundColor green
For($i=0;$i -lt $VMList.Length;$i++){Write-Host "$i - $($VMList[$i])"}
Write-Host ""
$userChoice=Read-Host "Which virtual switch do you want to choose"
$VMchoice=$VMList[$userChoice]
$SwitchName=$VMchoice
Write-Host "Info: " -NoNewLine
Write-Host "The chosen virtual switch is : $SwitchName" -ForegroundColor green

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "ISO management and verification."
if(Test-Path ".\src\GNU_Linux\iso\debian-11.3.0-amd64-netinst.iso")
{
Write-Host "Info: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.3.0-amd64-netinst.iso"

$dest=".\src\GNU_Linux\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}

$GBSizeList=@('1GB','2GB','4GB','8GB')
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Memory startup bytes list.`n" -ForegroundColor green
For($i=0;$i -lt $GBSizeList.Length;$i++){Write-Host "$i - $($GBSizeList[$i])"}
Write-Host ""
$userChoice=Read-Host "Memory startup bytes choice"
$GBchoice=$GBSizeList[$userChoice]
$MemStartupBytes=$GBchoice
Write-Host "Info: " -NoNewLine
Write-Host "The chosen memory startup bytes is : $MemStartupBytes" -ForegroundColor green

switch($MemStartupBytes)
{
    "1GB"{$MemStartupBytes=1GB}
    "2GB"{$MemStartupBytes=2GB}
    "4GB"{$MemStartupBytes=4GB}
    "8GB"{$MemStartupBytes=8GB}
}

$GenerationChoice=Read-Host "`nChoose the generation of the machine (1 or 2)"
Write-Host "Info: " -NoNewLine
Write-Host "The chosen generation is : $GenerationChoice" -ForegroundColor green

$VHDGBSizeList=@('20GB','32GB','48GB','64GB','80GB','120GB')
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "List of possible disk sizes.`n" -ForegroundColor green
For($i=0;$i -lt $VHDGBSizeList.Length;$i++){Write-Host "$i - $($VHDGBSizeList[$i])"}
Write-Host ""
$userChoice=Read-Host "Choose the hard drive size"
$GBchoice=$VHDGBSizeList[$userChoice]
$VHDGBSize=$GBchoice
Write-Host "`nInfo: " -NoNewLine
Write-Host "The chosen hard disk size is : $VHDGBSize" -ForegroundColor green

switch($VHDGBSize)
{
    "20GB"{$VHDGBSize=20GB}
    "32GB"{$VHDGBSize=32GB}
    "48GB"{$VHDGBSize=48GB}
    "64GB"{$VHDGBSize=64GB}
    "80GB"{$VHDGBSize=80GB}
    "120GB"{$VHDGBSize=120GB}
}

if(Test-Path ".\src\GNU_Linux\vhds\")
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\vhds\" -ItemType Directory -Force|Out-Null
}

if(Test-Path ".\src\GNU_Linux\vms\")
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\vms\" -ItemType Directory -Force|Out-Null
}

New-VM -Name $VMName -MemoryStartupBytes $MemStartupBytes -Generation $GenerationChoice -NewVHDPath ".\src\GNU_Linux\vhds\$VMName.vhdx" -NewVHDSizeBytes $VHDGBSize -Path ".\src\GNU_Linux\vms\$VMName" -SwitchName $SwitchName

Add-VMDvdDrive -VMName $VMName -Path ".\src\GNU_Linux\iso\debian-11.3.0-amd64-netinst.iso"
$myVM=Get-VMFirmware $VMName
$HDD = $myVM.BootOrder[0]
$PXE = $myVM.BootOrder[1]
$DVD = $myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VMMemory $VMName -DynamicMemoryEnabled $false
Set-VMFirmware $VMName -EnableSecureBoot Off
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $false

Write-Host ""
Write-Host "1 - Recreate exactly the same machine (with the same characteristics)."
Write-Host "2 - Recreate another machine (but with different characteristics)."
Write-Host ""
Write-Host "8 - Back to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{
    1{HPV-Copy_Same_VM-debian}
    2{HPV-New_VM-debian}

    8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main}
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";Clear-Host;exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400 : The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function HPV-Copy_Same_VM-debian
{
Clear-Host
$VMname = Read-Host "Virtual machine name"
Write-Host "Info: " -NoNewLine
Write-Host "The name chosen for the virtual machine is : $VMname" -ForegroundColor green

New-VM -Name $VMName -MemoryStartupBytes $MemStartupBytes -Generation $GenerationChoice -NewVHDPath ".\src\GNU_Linux\vhds\$VMName.vhdx" -NewVHDSizeBytes $VHDGBSize -Path ".\src\GNU_Linux\vms\$VMName" -SwitchName $SwitchName

Add-VMDvdDrive -VMName $VMName -Path ".\src\GNU_Linux\iso\debian-11.3.0-amd64-netinst.iso"
$myVM=Get-VMFirmware $VMName
$HDD = $myVM.BootOrder[0]
$PXE = $myVM.BootOrder[1]
$DVD = $myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VMMemory $VMName -DynamicMemoryEnabled $false
Set-VMFirmware $VMName -EnableSecureBoot Off
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $false

Write-Host ""
Write-Host "1 - Recreate exactly the same machine (with the same characteristics)."
Write-Host "2 - Recreate another machine (but with different characteristics)."
Write-Host ""
Write-Host "8 - Back to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{
    1{HPV-Copy_Same_VM-debian}
    2{HPV-New_VM-debian}

    8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main}
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400 : The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function HPV-New_VM-ubuntu
{
Clear-Host
$VMname = Read-Host "Virtual machine name"
Write-Host "Info: " -NoNewLine
Write-Host "The name chosen for the virtual machine is : $VMname" -ForegroundColor green
Write-Host ""

$Get_VMSwitch=Get-VMSwitch
$VMList=@()
$Get_VMSwitch|ForEach-Object {$VMList+=$_.Name}
Write-Host "Ongoing action: " -NoNewLine
Write-Host "List of virtual switches.`n" -ForegroundColor green
For($i=0;$i -lt $VMList.Length;$i++){Write-Host "$i - $($VMList[$i])"}
Write-Host ""
$userChoice=Read-Host "Which virtual switch do you want to choose"
$VMchoice=$VMList[$userChoice]
$SwitchName=$VMchoice
Write-Host "Info: " -NoNewLine
Write-Host "The chosen virtual switch is : $SwitchName" -ForegroundColor green

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "ISO management and verification."
if(Test-Path ".\src\GNU_Linux\iso\ubuntu-22.04-beta-desktop-amd64.iso")
{
Write-Host "Info: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://ubuntu.univ-nantes.fr/ubuntu-cd/22.04/ubuntu-22.04-beta-desktop-amd64.iso"

$dest=".\src\GNU_Linux\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}

$GBSizeList=@('1GB','2GB','4GB','8GB')
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Memory startup bytes list.`n" -ForegroundColor green
For($i=0;$i -lt $GBSizeList.Length;$i++){Write-Host "$i - $($GBSizeList[$i])"}
Write-Host ""
$userChoice=Read-Host "Memory startup bytes choice"
$GBchoice=$GBSizeList[$userChoice]
$MemStartupBytes=$GBchoice
Write-Host "Info: " -NoNewLine
Write-Host "The chosen memory startup bytes is : $MemStartupBytes" -ForegroundColor green

switch($MemStartupBytes)
{
    "1GB"{$MemStartupBytes=1GB}
    "2GB"{$MemStartupBytes=2GB}
    "4GB"{$MemStartupBytes=4GB}
    "8GB"{$MemStartupBytes=8GB}
}

$GenerationChoice=Read-Host "`nChoose the generation of the machine (1 or 2)"
Write-Host "Info: " -NoNewLine
Write-Host "The chosen generation is : $GenerationChoice" -ForegroundColor green

$VHDGBSizeList=@('20GB','32GB','48GB','64GB','80GB','120GB')
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "List of possible disk sizes.`n" -ForegroundColor green
For($i=0;$i -lt $VHDGBSizeList.Length;$i++){Write-Host "$i - $($VHDGBSizeList[$i])"}
Write-Host ""
$userChoice=Read-Host "Choose the hard drive size"
$GBchoice=$VHDGBSizeList[$userChoice]
$VHDGBSize=$GBchoice
Write-Host "`nInfo: " -NoNewLine
Write-Host "The chosen hard disk size is : $VHDGBSize" -ForegroundColor green

switch($VHDGBSize)
{
    "20GB"{$VHDGBSize=20GB}
    "32GB"{$VHDGBSize=32GB}
    "48GB"{$VHDGBSize=48GB}
    "64GB"{$VHDGBSize=64GB}
    "80GB"{$VHDGBSize=80GB}
    "120GB"{$VHDGBSize=120GB}
}

if(Test-Path ".\src\GNU_Linux\vhds\")
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\vhds\" -ItemType Directory -Force|Out-Null
}

if(Test-Path ".\src\GNU_Linux\vms\")
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\vms\" -ItemType Directory -Force|Out-Null
}

New-VM -Name $VMName -MemoryStartupBytes $MemStartupBytes -Generation $GenerationChoice -NewVHDPath ".\src\GNU_Linux\vhds\$VMName.vhdx" -NewVHDSizeBytes $VHDGBSize -Path ".\src\GNU_Linux\vms\$VMName" -SwitchName $SwitchName

Add-VMDvdDrive -VMName $VMName -Path ".\src\GNU_Linux\iso\ubuntu-22.04-beta-desktop-amd64.iso"
$myVM=Get-VMFirmware $VMName
$HDD = $myVM.BootOrder[0]
$PXE = $myVM.BootOrder[1]
$DVD = $myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VMMemory $VMName -DynamicMemoryEnabled $false
Set-VMFirmware $VMName -EnableSecureBoot Off
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $false

Write-Host ""
Write-Host "1 - Recreate exactly the same machine (with the same characteristics)."
Write-Host "2 - Recreate another machine (but with different characteristics)."
Write-Host ""
Write-Host "8 - Back to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{
    1{HPV-Copy_Same_VM-ubuntu}
    2{HPV-New_VM-ubuntu}

    8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main}
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";Clear-Host;exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400 : The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function HPV-Copy_Same_VM-ubuntu
{
Clear-Host
$VMname = Read-Host "Virtual machine name"
Write-Host "Info: " -NoNewLine
Write-Host "The name chosen for the virtual machine is : $VMname" -ForegroundColor green

New-VM -Name $VMName -MemoryStartupBytes $MemStartupBytes -Generation $GenerationChoice -NewVHDPath ".\src\GNU_Linux\vhds\$VMName.vhdx" -NewVHDSizeBytes $VHDGBSize -Path ".\src\GNU_Linux\vms\$VMName" -SwitchName $SwitchName

Add-VMDvdDrive -VMName $VMName -Path ".\src\GNU_Linux\iso\ubuntu-22.04-beta-desktop-amd64.iso"
$myVM=Get-VMFirmware $VMName
$HDD = $myVM.BootOrder[0]
$PXE = $myVM.BootOrder[1]
$DVD = $myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VMMemory $VMName -DynamicMemoryEnabled $false
Set-VMFirmware $VMName -EnableSecureBoot Off
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $false

Write-Host ""
Write-Host "1 - Recreate exactly the same machine (with the same characteristics)."
Write-Host "2 - Recreate another machine (but with different characteristics)."
Write-Host ""
Write-Host "8 - Back to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{
    1{HPV-Copy_Same_VM-ubuntu}
    2{HPV-New_VM-ubuntu}

    8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main}
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400 : The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function HPV-New_VM-rocky-full
{
Clear-Host
$VMname = Read-Host "Virtual machine name"
Write-Host "Info: " -NoNewLine
Write-Host "The name chosen for the virtual machine is : $VMname" -ForegroundColor green
Write-Host ""

$Get_VMSwitch=Get-VMSwitch
$VMList=@()
$Get_VMSwitch|ForEach-Object {$VMList+=$_.Name}
Write-Host "Ongoing action: " -NoNewLine
Write-Host "List of virtual switches.`n" -ForegroundColor green
For($i=0;$i -lt $VMList.Length;$i++){Write-Host "$i - $($VMList[$i])"}
Write-Host ""
$userChoice=Read-Host "Which virtual switch do you want to choose"
$VMchoice=$VMList[$userChoice]
$SwitchName=$VMchoice
Write-Host "Info: " -NoNewLine
Write-Host "The chosen virtual switch is : $SwitchName" -ForegroundColor green

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "ISO management and verification."
if(Test-Path ".\src\GNU_Linux\iso\Rocky-8.5-x86_64-dvd1.iso")
{
Write-Host "Info: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.5-x86_64-dvd1.iso"

$dest=".\src\GNU_Linux\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}

$GBSizeList=@('1GB','2GB','4GB','8GB')
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Memory startup bytes list.`n" -ForegroundColor green
For($i=0;$i -lt $GBSizeList.Length;$i++){Write-Host "$i - $($GBSizeList[$i])"}
Write-Host ""
$userChoice=Read-Host "Memory startup bytes choice"
$GBchoice=$GBSizeList[$userChoice]
$MemStartupBytes=$GBchoice
Write-Host "Info: " -NoNewLine
Write-Host "The chosen memory startup bytes is : $MemStartupBytes" -ForegroundColor green

switch($MemStartupBytes)
{
    "1GB"{$MemStartupBytes=1GB}
    "2GB"{$MemStartupBytes=2GB}
    "4GB"{$MemStartupBytes=4GB}
    "8GB"{$MemStartupBytes=8GB}
}

$GenerationChoice=Read-Host "`nChoose the generation of the machine (1 or 2)"
Write-Host "Info: " -NoNewLine
Write-Host "The chosen generation is : $GenerationChoice" -ForegroundColor green

$VHDGBSizeList=@('20GB','32GB','48GB','64GB','80GB','120GB')
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "List of possible disk sizes.`n" -ForegroundColor green
For($i=0;$i -lt $VHDGBSizeList.Length;$i++){Write-Host "$i - $($VHDGBSizeList[$i])"}
Write-Host ""
$userChoice=Read-Host "Choose the hard drive size"
$GBchoice=$VHDGBSizeList[$userChoice]
$VHDGBSize=$GBchoice
Write-Host "`nInfo: " -NoNewLine
Write-Host "The chosen hard disk size is : $VHDGBSize" -ForegroundColor green

switch($VHDGBSize)
{
    "20GB"{$VHDGBSize=20GB}
    "32GB"{$VHDGBSize=32GB}
    "48GB"{$VHDGBSize=48GB}
    "64GB"{$VHDGBSize=64GB}
    "80GB"{$VHDGBSize=80GB}
    "120GB"{$VHDGBSize=120GB}
}

if(Test-Path ".\src\GNU_Linux\vhds\")
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\vhds\" -ItemType Directory -Force|Out-Null
}

if(Test-Path ".\src\GNU_Linux\vms\")
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\vms\" -ItemType Directory -Force|Out-Null
}

New-VM -Name $VMName -MemoryStartupBytes $MemStartupBytes -Generation $GenerationChoice -NewVHDPath ".\src\GNU_Linux\vhds\$VMName.vhdx" -NewVHDSizeBytes $VHDGBSize -Path ".\src\GNU_Linux\vms\$VMName" -SwitchName $SwitchName

Add-VMDvdDrive -VMName $VMName -Path ".\src\GNU_Linux\iso\Rocky-8.5-x86_64-dvd1.iso"
$myVM=Get-VMFirmware $VMName
$HDD = $myVM.BootOrder[0]
$PXE = $myVM.BootOrder[1]
$DVD = $myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VMMemory $VMName -DynamicMemoryEnabled $false
Set-VMFirmware $VMName -EnableSecureBoot Off
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $false

Write-Host ""
Write-Host "1 - Recreate exactly the same machine (with the same characteristics)."
Write-Host "2 - Recreate another machine (but with different characteristics)."
Write-Host ""
Write-Host "8 - Back to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{
    1{HPV-Copy_Same_VM-rocky-full}
    2{HPV-New_VM-rocky-full}

    8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main}
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";Clear-Host;exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400 : The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function HPV-Copy_Same_VM-rocky-full
{
Clear-Host
$VMname = Read-Host "Virtual machine name"
Write-Host "Info: " -NoNewLine
Write-Host "The name chosen for the virtual machine is : $VMname" -ForegroundColor green

New-VM -Name $VMName -MemoryStartupBytes $MemStartupBytes -Generation $GenerationChoice -NewVHDPath ".\src\GNU_Linux\vhds\$VMName.vhdx" -NewVHDSizeBytes $VHDGBSize -Path ".\src\GNU_Linux\vms\$VMName" -SwitchName $SwitchName

Add-VMDvdDrive -VMName $VMName -Path ".\src\GNU_Linux\iso\Rocky-8.5-x86_64-dvd1.iso"
$myVM=Get-VMFirmware $VMName
$HDD = $myVM.BootOrder[0]
$PXE = $myVM.BootOrder[1]
$DVD = $myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VMMemory $VMName -DynamicMemoryEnabled $false
Set-VMFirmware $VMName -EnableSecureBoot Off
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $false

Write-Host ""
Write-Host "1 - Recreate exactly the same machine (with the same characteristics)."
Write-Host "2 - Recreate another machine (but with different characteristics)."
Write-Host ""
Write-Host "8 - Back to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{
    1{HPV-Copy_Same_VM-rocky-full}
    2{HPV-New_VM-rocky-full}

    8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main}
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400 : The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function HPV-New_VM-rocky-min
{
Clear-Host
$VMname = Read-Host "Virtual machine name"
Write-Host "Info: " -NoNewLine
Write-Host "The name chosen for the virtual machine is : $VMname" -ForegroundColor green
Write-Host ""

$Get_VMSwitch=Get-VMSwitch
$VMList=@()
$Get_VMSwitch|ForEach-Object {$VMList+=$_.Name}
Write-Host "Ongoing action: " -NoNewLine
Write-Host "List of virtual switches.`n" -ForegroundColor green
For($i=0;$i -lt $VMList.Length;$i++){Write-Host "$i - $($VMList[$i])"}
Write-Host ""
$userChoice=Read-Host "Which virtual switch do you want to choose"
$VMchoice=$VMList[$userChoice]
$SwitchName=$VMchoice
Write-Host "Info: " -NoNewLine
Write-Host "The chosen virtual switch is : $SwitchName" -ForegroundColor green

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "ISO management and verification."
if(Test-Path ".\src\GNU_Linux\iso\Rocky-8.5-x86_64-minimal.iso")
{
Write-Host "Info: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.5-x86_64-minimal.iso"

$dest=".\src\GNU_Linux\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}

$GBSizeList=@('1GB','2GB','4GB','8GB')
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Memory startup bytes list.`n" -ForegroundColor green
For($i=0;$i -lt $GBSizeList.Length;$i++){Write-Host "$i - $($GBSizeList[$i])"}
Write-Host ""
$userChoice=Read-Host "Memory startup bytes choice"
$GBchoice=$GBSizeList[$userChoice]
$MemStartupBytes=$GBchoice
Write-Host "Info: " -NoNewLine
Write-Host "The chosen memory startup bytes is : $MemStartupBytes" -ForegroundColor green

switch($MemStartupBytes)
{
    "1GB"{$MemStartupBytes=1GB}
    "2GB"{$MemStartupBytes=2GB}
    "4GB"{$MemStartupBytes=4GB}
    "8GB"{$MemStartupBytes=8GB}
}

$GenerationChoice=Read-Host "`nChoose the generation of the machine (1 or 2)"
Write-Host "Info: " -NoNewLine
Write-Host "The chosen generation is : $GenerationChoice" -ForegroundColor green

$VHDGBSizeList=@('20GB','32GB','48GB','64GB','80GB','120GB')
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "List of possible disk sizes.`n" -ForegroundColor green
For($i=0;$i -lt $VHDGBSizeList.Length;$i++){Write-Host "$i - $($VHDGBSizeList[$i])"}
Write-Host ""
$userChoice=Read-Host "Choose the hard drive size"
$GBchoice=$VHDGBSizeList[$userChoice]
$VHDGBSize=$GBchoice
Write-Host "`nInfo: " -NoNewLine
Write-Host "The chosen hard disk size is : $VHDGBSize" -ForegroundColor green

switch($VHDGBSize)
{
    "20GB"{$VHDGBSize=20GB}
    "32GB"{$VHDGBSize=32GB}
    "48GB"{$VHDGBSize=48GB}
    "64GB"{$VHDGBSize=64GB}
    "80GB"{$VHDGBSize=80GB}
    "120GB"{$VHDGBSize=120GB}
}

if(Test-Path ".\src\GNU_Linux\vhds\")
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\vhds\" -ItemType Directory -Force|Out-Null
}

if(Test-Path ".\src\GNU_Linux\vms\")
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\vms\" -ItemType Directory -Force|Out-Null
}

New-VM -Name $VMName -MemoryStartupBytes $MemStartupBytes -Generation $GenerationChoice -NewVHDPath ".\src\GNU_Linux\vhds\$VMName.vhdx" -NewVHDSizeBytes $VHDGBSize -Path ".\src\GNU_Linux\vms\$VMName" -SwitchName $SwitchName

Add-VMDvdDrive -VMName $VMName -Path ".\src\GNU_Linux\iso\Rocky-8.5-x86_64-minimal.iso"
$myVM=Get-VMFirmware $VMName
$HDD = $myVM.BootOrder[0]
$PXE = $myVM.BootOrder[1]
$DVD = $myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VMMemory $VMName -DynamicMemoryEnabled $false
Set-VMFirmware $VMName -EnableSecureBoot Off
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $false

Write-Host ""
Write-Host "1 - Recreate exactly the same machine (with the same characteristics)."
Write-Host "2 - Recreate another machine (but with different characteristics)."
Write-Host ""
Write-Host "8 - Back to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{
    1{HPV-Copy_Same_VM-rocky-min}
    2{HPV-New_VM-rocky-min}

    8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main}
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";Clear-Host;exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400 : The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function HPV-Copy_Same_VM-rocky-min
{
Clear-Host
$VMname = Read-Host "Virtual machine name"
Write-Host "Info: " -NoNewLine
Write-Host "The name chosen for the virtual machine is : $VMname" -ForegroundColor green

New-VM -Name $VMName -MemoryStartupBytes $MemStartupBytes -Generation $GenerationChoice -NewVHDPath ".\src\GNU_Linux\vhds\$VMName.vhdx" -NewVHDSizeBytes $VHDGBSize -Path ".\src\GNU_Linux\vms\$VMName" -SwitchName $SwitchName

Add-VMDvdDrive -VMName $VMName -Path ".\src\GNU_Linux\iso\Rocky-8.5-x86_64-minimal.iso"
$myVM=Get-VMFirmware $VMName
$HDD = $myVM.BootOrder[0]
$PXE = $myVM.BootOrder[1]
$DVD = $myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VMMemory $VMName -DynamicMemoryEnabled $false
Set-VMFirmware $VMName -EnableSecureBoot Off
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $false

Write-Host ""
Write-Host "1 - Recreate exactly the same machine (with the same characteristics)."
Write-Host "2 - Recreate another machine (but with different characteristics)."
Write-Host ""
Write-Host "8 - Back to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{
    1{HPV-Copy_Same_VM-rocky-min}
    2{HPV-New_VM-rocky-min}

    8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main}
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400 : The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function HPV-New_VM-parrot
{
Clear-Host
$VMname = Read-Host "Virtual machine name"
Write-Host "Info: " -NoNewLine
Write-Host "The name chosen for the virtual machine is : $VMname" -ForegroundColor green
Write-Host ""

$Get_VMSwitch=Get-VMSwitch
$VMList=@()
$Get_VMSwitch|ForEach-Object {$VMList+=$_.Name}
Write-Host "Ongoing action: " -NoNewLine
Write-Host "List of virtual switches.`n" -ForegroundColor green
For($i=0;$i -lt $VMList.Length;$i++){Write-Host "$i - $($VMList[$i])"}
Write-Host ""
$userChoice=Read-Host "Which virtual switch do you want to choose"
$VMchoice=$VMList[$userChoice]
$SwitchName=$VMchoice
Write-Host "Info: " -NoNewLine
Write-Host "The chosen virtual switch is : $SwitchName" -ForegroundColor green

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "ISO management and verification."
if(Test-Path ".\src\GNU_Linux\iso\Parrot-security-5.0_amd64.iso")
{
Write-Host "Info: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://bunny.deb.parrot.sh/parrot/iso/5.0/Parrot-security-5.0_amd64.iso"

$dest=".\src\GNU_Linux\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}

$GBSizeList=@('1GB','2GB','4GB','8GB')
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Memory startup bytes list.`n" -ForegroundColor green
For($i=0;$i -lt $GBSizeList.Length;$i++){Write-Host "$i - $($GBSizeList[$i])"}
Write-Host ""
$userChoice=Read-Host "Memory startup bytes choice"
$GBchoice=$GBSizeList[$userChoice]
$MemStartupBytes=$GBchoice
Write-Host "Info: " -NoNewLine
Write-Host "The chosen memory startup bytes is : $MemStartupBytes" -ForegroundColor green

switch($MemStartupBytes)
{
    "1GB"{$MemStartupBytes=1GB}
    "2GB"{$MemStartupBytes=2GB}
    "4GB"{$MemStartupBytes=4GB}
    "8GB"{$MemStartupBytes=8GB}
}

$GenerationChoice=Read-Host "`nChoose the generation of the machine (1 or 2)"
Write-Host "Info: " -NoNewLine
Write-Host "The chosen generation is : $GenerationChoice" -ForegroundColor green

$VHDGBSizeList=@('20GB','32GB','48GB','64GB','80GB','120GB')
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "List of possible disk sizes.`n" -ForegroundColor green
For($i=0;$i -lt $VHDGBSizeList.Length;$i++){Write-Host "$i - $($VHDGBSizeList[$i])"}
Write-Host ""
$userChoice=Read-Host "Choose the hard drive size"
$GBchoice=$VHDGBSizeList[$userChoice]
$VHDGBSize=$GBchoice
Write-Host "`nInfo: " -NoNewLine
Write-Host "The chosen hard disk size is : $VHDGBSize" -ForegroundColor green

switch($VHDGBSize)
{
    "20GB"{$VHDGBSize=20GB}
    "32GB"{$VHDGBSize=32GB}
    "48GB"{$VHDGBSize=48GB}
    "64GB"{$VHDGBSize=64GB}
    "80GB"{$VHDGBSize=80GB}
    "120GB"{$VHDGBSize=120GB}
}

if(Test-Path ".\src\GNU_Linux\vhds\")
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\vhds\" -ItemType Directory -Force|Out-Null
}

if(Test-Path ".\src\GNU_Linux\vms\")
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\vms\" -ItemType Directory -Force|Out-Null
}

New-VM -Name $VMName -MemoryStartupBytes $MemStartupBytes -Generation $GenerationChoice -NewVHDPath ".\src\GNU_Linux\vhds\$VMName.vhdx" -NewVHDSizeBytes $VHDGBSize -Path ".\src\GNU_Linux\vms\$VMName" -SwitchName $SwitchName

Add-VMDvdDrive -VMName $VMName -Path ".\src\GNU_Linux\iso\Parrot-security-5.0_amd64.iso"
$myVM=Get-VMFirmware $VMName
$HDD = $myVM.BootOrder[0]
$PXE = $myVM.BootOrder[1]
$DVD = $myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VMMemory $VMName -DynamicMemoryEnabled $false
Set-VMFirmware $VMName -EnableSecureBoot Off
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $false

Write-Host ""
Write-Host "1 - Recreate exactly the same machine (with the same characteristics)."
Write-Host "2 - Recreate another machine (but with different characteristics)."
Write-Host ""
Write-Host "8 - Back to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{
    1{HPV-Copy_Same_VM-parrot}
    2{HPV-New_VM-parrot}

    8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main}
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";Clear-Host;exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400 : The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function HPV-Copy_Same_VM-parrot
{
Clear-Host
$VMname = Read-Host "Virtual machine name"
Write-Host "Info: " -NoNewLine
Write-Host "The name chosen for the virtual machine is : $VMname" -ForegroundColor green

New-VM -Name $VMName -MemoryStartupBytes $MemStartupBytes -Generation $GenerationChoice -NewVHDPath ".\src\GNU_Linux\vhds\$VMName.vhdx" -NewVHDSizeBytes $VHDGBSize -Path ".\src\GNU_Linux\vms\$VMName" -SwitchName $SwitchName

Add-VMDvdDrive -VMName $VMName -Path ".\src\GNU_Linux\iso\Parrot-security-5.0_amd64.iso"
$myVM=Get-VMFirmware $VMName
$HDD = $myVM.BootOrder[0]
$PXE = $myVM.BootOrder[1]
$DVD = $myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VMMemory $VMName -DynamicMemoryEnabled $false
Set-VMFirmware $VMName -EnableSecureBoot Off
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $false

Write-Host ""
Write-Host "1 - Recreate exactly the same machine (with the same characteristics)."
Write-Host "2 - Recreate another machine (but with different characteristics)."
Write-Host ""
Write-Host "8 - Back to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{
    1{HPV-Copy_Same_VM-parrot}
    2{HPV-New_VM-parrot}

    8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main}
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400 : The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function HPV-New_VM-kali-live
{
Clear-Host
$VMname = Read-Host "Virtual machine name"
Write-Host "Info: " -NoNewLine
Write-Host "The name chosen for the virtual machine is : $VMname" -ForegroundColor green
Write-Host ""

$Get_VMSwitch=Get-VMSwitch
$VMList=@()
$Get_VMSwitch|ForEach-Object {$VMList+=$_.Name}
Write-Host "Ongoing action: " -NoNewLine
Write-Host "List of virtual switches.`n" -ForegroundColor green
For($i=0;$i -lt $VMList.Length;$i++){Write-Host "$i - $($VMList[$i])"}
Write-Host ""
$userChoice=Read-Host "Which virtual switch do you want to choose"
$VMchoice=$VMList[$userChoice]
$SwitchName=$VMchoice
Write-Host "Info: " -NoNewLine
Write-Host "The chosen virtual switch is : $SwitchName" -ForegroundColor green

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "ISO management and verification."
if(Test-Path ".\src\GNU_Linux\iso\kali-linux-2022.1-live-amd64.iso")
{
Write-Host "Info: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://cdimage.kali.org/kali-images/current/kali-linux-2022.1-live-amd64.iso"

$dest=".\src\GNU_Linux\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}

$GBSizeList=@('1GB','2GB','4GB','8GB')
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Memory startup bytes list.`n" -ForegroundColor green
For($i=0;$i -lt $GBSizeList.Length;$i++){Write-Host "$i - $($GBSizeList[$i])"}
Write-Host ""
$userChoice=Read-Host "Memory startup bytes choice"
$GBchoice=$GBSizeList[$userChoice]
$MemStartupBytes=$GBchoice
Write-Host "Info: " -NoNewLine
Write-Host "The chosen memory startup bytes is : $MemStartupBytes" -ForegroundColor green

switch($MemStartupBytes)
{
    "1GB"{$MemStartupBytes=1GB}
    "2GB"{$MemStartupBytes=2GB}
    "4GB"{$MemStartupBytes=4GB}
    "8GB"{$MemStartupBytes=8GB}
}

$GenerationChoice=Read-Host "`nChoose the generation of the machine (1 or 2)"
Write-Host "Info: " -NoNewLine
Write-Host "The chosen generation is : $GenerationChoice" -ForegroundColor green

$VHDGBSizeList=@('20GB','32GB','48GB','64GB','80GB','120GB')
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "List of possible disk sizes.`n" -ForegroundColor green
For($i=0;$i -lt $VHDGBSizeList.Length;$i++){Write-Host "$i - $($VHDGBSizeList[$i])"}
Write-Host ""
$userChoice=Read-Host "Choose the hard drive size"
$GBchoice=$VHDGBSizeList[$userChoice]
$VHDGBSize=$GBchoice
Write-Host "`nInfo: " -NoNewLine
Write-Host "The chosen hard disk size is : $VHDGBSize" -ForegroundColor green

switch($VHDGBSize)
{
    "20GB"{$VHDGBSize=20GB}
    "32GB"{$VHDGBSize=32GB}
    "48GB"{$VHDGBSize=48GB}
    "64GB"{$VHDGBSize=64GB}
    "80GB"{$VHDGBSize=80GB}
    "120GB"{$VHDGBSize=120GB}
}

if(Test-Path ".\src\GNU_Linux\vhds\")
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\vhds\" -ItemType Directory -Force|Out-Null
}

if(Test-Path ".\src\GNU_Linux\vms\")
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\vms\" -ItemType Directory -Force|Out-Null
}

New-VM -Name $VMName -MemoryStartupBytes $MemStartupBytes -Generation $GenerationChoice -NewVHDPath ".\src\GNU_Linux\vhds\$VMName.vhdx" -NewVHDSizeBytes $VHDGBSize -Path ".\src\GNU_Linux\vms\$VMName" -SwitchName $SwitchName

Add-VMDvdDrive -VMName $VMName -Path ".\src\GNU_Linux\iso\kali-linux-2022.1-live-amd64.iso"
$myVM=Get-VMFirmware $VMName
$HDD = $myVM.BootOrder[0]
$PXE = $myVM.BootOrder[1]
$DVD = $myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VMMemory $VMName -DynamicMemoryEnabled $false
Set-VMFirmware $VMName -EnableSecureBoot Off
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $false

Write-Host ""
Write-Host "1 - Recreate exactly the same machine (with the same characteristics)."
Write-Host "2 - Recreate another machine (but with different characteristics)."
Write-Host ""
Write-Host "8 - Back to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{
    1{HPV-Copy_Same_VM-kali-live}
    2{HPV-New_VM-kali-live}

    8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main}
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";Clear-Host;exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400 : The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function HPV-Copy_Same_VM-kali-live
{
Clear-Host
$VMname = Read-Host "Virtual machine name"
Write-Host "Info: " -NoNewLine
Write-Host "The name chosen for the virtual machine is : $VMname" -ForegroundColor green

New-VM -Name $VMName -MemoryStartupBytes $MemStartupBytes -Generation $GenerationChoice -NewVHDPath ".\src\GNU_Linux\vhds\$VMName.vhdx" -NewVHDSizeBytes $VHDGBSize -Path ".\src\GNU_Linux\vms\$VMName" -SwitchName $SwitchName

Add-VMDvdDrive -VMName $VMName -Path ".\src\GNU_Linux\iso\kali-linux-2022.1-live-amd64.iso"
$myVM=Get-VMFirmware $VMName
$HDD = $myVM.BootOrder[0]
$PXE = $myVM.BootOrder[1]
$DVD = $myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VMMemory $VMName -DynamicMemoryEnabled $false
Set-VMFirmware $VMName -EnableSecureBoot Off
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $false

Write-Host ""
Write-Host "1 - Recreate exactly the same machine (with the same characteristics)."
Write-Host "2 - Recreate another machine (but with different characteristics)."
Write-Host ""
Write-Host "8 - Back to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{
    1{HPV-Copy_Same_VM-kali-live}
    2{HPV-New_VM-kali-live}

    8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main}
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400 : The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function HPV-New_VM-kali-installer
{
Clear-Host
$VMname = Read-Host "Virtual machine name"
Write-Host "Info: " -NoNewLine
Write-Host "The name chosen for the virtual machine is : $VMname" -ForegroundColor green
Write-Host ""

$Get_VMSwitch=Get-VMSwitch
$VMList=@()
$Get_VMSwitch|ForEach-Object {$VMList+=$_.Name}
Write-Host "Ongoing action: " -NoNewLine
Write-Host "List of virtual switches.`n" -ForegroundColor green
For($i=0;$i -lt $VMList.Length;$i++){Write-Host "$i - $($VMList[$i])"}
Write-Host ""
$userChoice=Read-Host "Which virtual switch do you want to choose"
$VMchoice=$VMList[$userChoice]
$SwitchName=$VMchoice
Write-Host "Info: " -NoNewLine
Write-Host "The chosen virtual switch is : $SwitchName" -ForegroundColor green

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "ISO management and verification."
if(Test-Path ".\src\GNU_Linux\iso\kali-linux-2022.1-installer-amd64.iso")
{
Write-Host "Info: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://cdimage.kali.org/kali-images/current/kali-linux-2022.1-installer-amd64.iso"

$dest=".\src\GNU_Linux\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}

$GBSizeList=@('1GB','2GB','4GB','8GB')
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Memory startup bytes list.`n" -ForegroundColor green
For($i=0;$i -lt $GBSizeList.Length;$i++){Write-Host "$i - $($GBSizeList[$i])"}
Write-Host ""
$userChoice=Read-Host "Memory startup bytes choice"
$GBchoice=$GBSizeList[$userChoice]
$MemStartupBytes=$GBchoice
Write-Host "Info: " -NoNewLine
Write-Host "The chosen memory startup bytes is : $MemStartupBytes" -ForegroundColor green

switch($MemStartupBytes)
{
    "1GB"{$MemStartupBytes=1GB}
    "2GB"{$MemStartupBytes=2GB}
    "4GB"{$MemStartupBytes=4GB}
    "8GB"{$MemStartupBytes=8GB}
}

$GenerationChoice=Read-Host "`nChoose the generation of the machine (1 or 2)"
Write-Host "Info: " -NoNewLine
Write-Host "The chosen generation is : $GenerationChoice" -ForegroundColor green

$VHDGBSizeList=@('20GB','32GB','48GB','64GB','80GB','120GB')
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "List of possible disk sizes.`n" -ForegroundColor green
For($i=0;$i -lt $VHDGBSizeList.Length;$i++){Write-Host "$i - $($VHDGBSizeList[$i])"}
Write-Host ""
$userChoice=Read-Host "Choose the hard drive size"
$GBchoice=$VHDGBSizeList[$userChoice]
$VHDGBSize=$GBchoice
Write-Host "`nInfo: " -NoNewLine
Write-Host "The chosen hard disk size is : $VHDGBSize" -ForegroundColor green

switch($VHDGBSize)
{
    "20GB"{$VHDGBSize=20GB}
    "32GB"{$VHDGBSize=32GB}
    "48GB"{$VHDGBSize=48GB}
    "64GB"{$VHDGBSize=64GB}
    "80GB"{$VHDGBSize=80GB}
    "120GB"{$VHDGBSize=120GB}
}

if(Test-Path ".\src\GNU_Linux\vhds\")
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\vhds\" -ItemType Directory -Force|Out-Null
}

if(Test-Path ".\src\GNU_Linux\vms\")
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\vms\" -ItemType Directory -Force|Out-Null
}

New-VM -Name $VMName -MemoryStartupBytes $MemStartupBytes -Generation $GenerationChoice -NewVHDPath ".\src\GNU_Linux\vhds\$VMName.vhdx" -NewVHDSizeBytes $VHDGBSize -Path ".\src\GNU_Linux\vms\$VMName" -SwitchName $SwitchName

Add-VMDvdDrive -VMName $VMName -Path ".\src\GNU_Linux\iso\kali-linux-2022.1-installer-amd64.iso"
$myVM=Get-VMFirmware $VMName
$HDD = $myVM.BootOrder[0]
$PXE = $myVM.BootOrder[1]
$DVD = $myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VMMemory $VMName -DynamicMemoryEnabled $false
Set-VMFirmware $VMName -EnableSecureBoot Off
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $false

Write-Host ""
Write-Host "1 - Recreate exactly the same machine (with the same characteristics)."
Write-Host "2 - Recreate another machine (but with different characteristics)."
Write-Host ""
Write-Host "8 - Back to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{
    1{HPV-Copy_Same_VM-kali-installer}
    2{HPV-New_VM-kali-installer}

    8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main}
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";Clear-Host;exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400 : The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function HPV-Copy_Same_VM-kali-installer
{
Clear-Host
$VMname = Read-Host "Virtual machine name"
Write-Host "Info: " -NoNewLine
Write-Host "The name chosen for the virtual machine is : $VMname" -ForegroundColor green

New-VM -Name $VMName -MemoryStartupBytes $MemStartupBytes -Generation $GenerationChoice -NewVHDPath ".\src\GNU_Linux\vhds\$VMName.vhdx" -NewVHDSizeBytes $VHDGBSize -Path ".\src\GNU_Linux\vms\$VMName" -SwitchName $SwitchName

Add-VMDvdDrive -VMName $VMName -Path ".\src\GNU_Linux\iso\kali-linux-2022.1-installer-amd64.iso"
$myVM=Get-VMFirmware $VMName
$HDD = $myVM.BootOrder[0]
$PXE = $myVM.BootOrder[1]
$DVD = $myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VMMemory $VMName -DynamicMemoryEnabled $false
Set-VMFirmware $VMName -EnableSecureBoot Off
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $false

Write-Host ""
Write-Host "1 - Recreate exactly the same machine (with the same characteristics)."
Write-Host "2 - Recreate another machine (but with different characteristics)."
Write-Host ""
Write-Host "8 - Back to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{
    1{HPV-Copy_Same_VM-kali-installer}
    2{HPV-New_VM-kali-installer}

    8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main}
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400 : The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function HPV-New_VM-pfsense
{
Clear-Host
$VMname = Read-Host "Virtual machine name"
Write-Host "Info: " -NoNewLine
Write-Host "The name chosen for the virtual machine is : $VMname" -ForegroundColor green
Write-Host ""

$Get_VMSwitch=Get-VMSwitch
$VMList=@()
$Get_VMSwitch|ForEach-Object {$VMList+=$_.Name}
Write-Host "Ongoing action: " -NoNewLine
Write-Host "List of virtual switches.`n" -ForegroundColor green
For($i=0;$i -lt $VMList.Length;$i++){Write-Host "$i - $($VMList[$i])"}
Write-Host ""
$userChoice=Read-Host "Which virtual switch do you want to choose"
$VMchoice=$VMList[$userChoice]
$SwitchName=$VMchoice
Write-Host "Info: " -NoNewLine
Write-Host "The chosen virtual switch is : $SwitchName" -ForegroundColor green

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "ISO management and verification."
if(Test-Path ".\src\GNU_Linux\iso\pfSense-CE-2.5.1-RELEASE-amd64.iso")
{
Write-Host "Info: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://images-data.fra1.digitaloceanspaces.com/pfSense-CE-2.5.1-RELEASE-amd64.iso"

$dest=".\src\GNU_Linux\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}

$GBSizeList=@('1GB','2GB','4GB','8GB')
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Memory startup bytes list.`n" -ForegroundColor green
For($i=0;$i -lt $GBSizeList.Length;$i++){Write-Host "$i - $($GBSizeList[$i])"}
Write-Host ""
$userChoice=Read-Host "Memory startup bytes choice"
$GBchoice=$GBSizeList[$userChoice]
$MemStartupBytes=$GBchoice
Write-Host "Info: " -NoNewLine
Write-Host "The chosen memory startup bytes is : $MemStartupBytes" -ForegroundColor green

switch($MemStartupBytes)
{
    "1GB"{$MemStartupBytes=1GB}
    "2GB"{$MemStartupBytes=2GB}
    "4GB"{$MemStartupBytes=4GB}
    "8GB"{$MemStartupBytes=8GB}
}

$GenerationChoice=Read-Host "`nChoose the generation of the machine (1 or 2)"
Write-Host "Info: " -NoNewLine
Write-Host "The chosen generation is : $GenerationChoice" -ForegroundColor green

$VHDGBSizeList=@('20GB','32GB','48GB','64GB','80GB','120GB')
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "List of possible disk sizes.`n" -ForegroundColor green
For($i=0;$i -lt $VHDGBSizeList.Length;$i++){Write-Host "$i - $($VHDGBSizeList[$i])"}
Write-Host ""
$userChoice=Read-Host "Choose the hard drive size"
$GBchoice=$VHDGBSizeList[$userChoice]
$VHDGBSize=$GBchoice
Write-Host "`nInfo: " -NoNewLine
Write-Host "The chosen hard disk size is : $VHDGBSize" -ForegroundColor green

switch($VHDGBSize)
{
    "20GB"{$VHDGBSize=20GB}
    "32GB"{$VHDGBSize=32GB}
    "48GB"{$VHDGBSize=48GB}
    "64GB"{$VHDGBSize=64GB}
    "80GB"{$VHDGBSize=80GB}
    "120GB"{$VHDGBSize=120GB}
}

if(Test-Path ".\src\GNU_Linux\vhds\")
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\vhds\" -ItemType Directory -Force|Out-Null
}

if(Test-Path ".\src\GNU_Linux\vms\")
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\vms\" -ItemType Directory -Force|Out-Null
}

New-VM -Name $VMName -MemoryStartupBytes $MemStartupBytes -Generation $GenerationChoice -NewVHDPath ".\src\GNU_Linux\vhds\$VMName.vhdx" -NewVHDSizeBytes $VHDGBSize -Path ".\src\GNU_Linux\vms\$VMName" -SwitchName $SwitchName

Add-VMDvdDrive -VMName $VMName -Path ".\src\GNU_Linux\iso\pfSense-CE-2.5.1-RELEASE-amd64.iso"
$myVM=Get-VMFirmware $VMName
$HDD = $myVM.BootOrder[0]
$PXE = $myVM.BootOrder[1]
$DVD = $myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VMMemory $VMName -DynamicMemoryEnabled $false
Set-VMFirmware $VMName -EnableSecureBoot Off
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $false

Write-Host ""
Write-Host "1 - Recreate exactly the same machine (with the same characteristics)."
Write-Host "2 - Recreate another machine (but with different characteristics)."
Write-Host ""
Write-Host "8 - Back to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{
    1{HPV-Copy_Same_VM-pfsense}
    2{HPV-New_VM-pfsense}

    8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main}
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";Clear-Host;exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400 : The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function HPV-Copy_Same_VM-pfsense
{
Clear-Host
$VMname = Read-Host "Virtual machine name"
Write-Host "Info: " -NoNewLine
Write-Host "The name chosen for the virtual machine is : $VMname" -ForegroundColor green

New-VM -Name $VMName -MemoryStartupBytes $MemStartupBytes -Generation $GenerationChoice -NewVHDPath ".\src\GNU_Linux\vhds\$VMName.vhdx" -NewVHDSizeBytes $VHDGBSize -Path ".\src\GNU_Linux\vms\$VMName" -SwitchName $SwitchName

Add-VMDvdDrive -VMName $VMName -Path ".\src\GNU_Linux\iso\pfSense-CE-2.5.1-RELEASE-amd64.iso"
$myVM=Get-VMFirmware $VMName
$HDD = $myVM.BootOrder[0]
$PXE = $myVM.BootOrder[1]
$DVD = $myVM.BootOrder[2]
Set-VMFirmware -VMName $VMName -BootOrder $DVD,$HDD,$PXE

Set-VMMemory $VMName -DynamicMemoryEnabled $false
Set-VMFirmware $VMName -EnableSecureBoot Off
Set-VM -Name $VMName -AutomaticCheckpointsEnabled $false

Write-Host ""
Write-Host "1 - Recreate exactly the same machine (with the same characteristics)."
Write-Host "2 - Recreate another machine (but with different characteristics)."
Write-Host ""
Write-Host "8 - Back to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{
    1{HPV-Copy_Same_VM-pfsense}
    2{HPV-New_VM-pfsense}

    8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main}
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400 : The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function HPV-New_VM_FromTemplate
{
Clear-Host ""
Write-Host "Info: " -NoNewLine
Write-Host "This feature is under development."
Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main
}

function HPV-VM_Management
{
Clear-Host
Write-Host "1 - List of virtual machines."
Write-Host ""
Write-Host "2 - Start a virtual machine."
Write-Host "3 - Power on all virtual machines at the same time."
Write-Host ""
Write-Host "4 - Shut down a virtual machine."
Write-Host "5 - Shut down all virtual machines at the same time."
Write-Host ""
Write-Host "6 - Delete a virtual machine."
Write-Host "7 - ICBM (Intercontinental ballistic missile): Delete all existing virtual machines."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{
    1{HPV-List_VM}
    2{HPV-Start_VM}
    3{HPV-StartAll_VM}
    4{HPV-Shut_VM}
    5{HPV-ShutAll_VM}
    6{HPV-Remove_VM}
    7{HPV-RemoveAll_VM}
    
    8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main}
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400: The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function HPV-List_VM
{
Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Viewing the list of virtual machines.`n"

$VMList=@()
$Get_VMs=Get-VM|Select-Object -Property Name,State
$VMList=$Get_VMs
$Get_VMs|Add-Content -Path '.\HPV-List_VM.txt.tmp'
Get-Content -Path '.\HPV-List_VM.txt.tmp'
Write-Host ""
pause
Remove-Item -Path '.\HPV-List_VM.txt.tmp' -Force
Write-Host ""
Write-Host "7 - Return to the virtual machine management menu section."
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{   
    7{HPV-VM_Management;Remove-Item -Path .\HPV-List_VM.txt.tmp -Force}
    8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;Remove-Item -Path .\HPV-List_VM.txt.tmp -Force;main}
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";Remove-Item -Path .\HPV-List_VM.txt.tmp -Force;exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400: The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;Remove-Item -Path .\HPV-List_VM.txt.tmp -Force;main}
}
}

function HPV-Start_VM
{
Clear-Host
$Get_VMs=Get-VM
$VMList=@()
$Get_VMs|ForEach-Object {$VMList+=$_.Name}
Write-Host "Info: " -NoNewLine
Write-Host "Viewing the list of virtual machines." -ForegroundColor green
Write-Host ""
For($i=0;$i -lt $VMList.Length;$i++){Write-Host "$i $($VMList[$i])"}
Write-Host ""
$userChoice=Read-Host "Which machine do you want to start"
$VMChoice=$VMList[$userChoice]
Write-Host "`nOngoing action : " -NoNewLine
Write-Host "Starting the virtual machine: $VMChoice." -ForegroundColor green
Start-VM -Name $VMChoice

Write-Host "`nOngoing action : " -NoNewLine
Write-Host "Viewing the list of running virtual machines." -ForegroundColor green
Get-VM | where {$_.State -eq 'Running'}

Write-Host ""
pause
Write-Host ""
Write-Host "6 - Start a new virtual machine."
Write-Host ""
Write-Host "7 - Return to the virtual machine management menu section."
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{
    6{HPV-Start_VM}   
    7{HPV-VM_Management}
    8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main}
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400: The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function HPV-StartAll_VM
{
Clear-Host
Write-Host "`nOngoing action : " -NoNewLine
Write-Host "Starting all virtual machines." -ForegroundColor green

$VMList=@()
$VMList=(Get-VM).Name
ForEach ($VM in $VMList){Start-VM -Name $VM}

Write-Host "`nOngoing action : " -NoNewLine
Write-Host "Viewing the list of running virtual machines." -ForegroundColor green
Get-VM | where {$_.State -eq 'Running'}

Write-Host ""
pause
Write-Host ""
Write-Host "7 - Return to the virtual machine management menu section."
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{ 
    7{HPV-VM_Management}
    8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main}
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400: The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function HPV-Shut_VM
{
Clear-Host
$Get_VMs=Get-VM
$VMList=@()
$Get_VMs|ForEach-Object {$VMList+=$_.Name}
Write-Host "Info: " -NoNewLine
Write-Host "Viewing the list of virtual machines." -ForegroundColor green
Write-Host ""
For($i=0;$i -lt $VMList.Length;$i++){Write-Host "$i $($VMList[$i])"}
Write-Host ""
$userChoice=Read-Host "Which machine do you want to turn off"
$VMChoice=$VMList[$userChoice]
Write-Host "`nOngoing action : " -NoNewLine
Write-Host "Shutting down the virtual machine: $VMChoice." -ForegroundColor green
Stop-VM -Name $VMChoice

Write-Host "`nOngoing action : " -NoNewLine
Write-Host "Display of the list of stopped virtual machines." -ForegroundColor green
Get-VM | where {$_.State -eq 'Off'}

Write-Host ""
pause
Write-Host ""
Write-Host "6 - Shut down another virtual machine."
Write-Host ""
Write-Host "7 - Return to the virtual machine management menu section."
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{
    6{HPV-Shut_VM}   
    7{HPV-VM_Management}
    8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main}
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400: The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function HPV-ShutAll_VM
{
Clear-Host
Write-Host "`nOngoing action : " -NoNewLine
Write-Host "Shut down all virtual machines." -ForegroundColor green

$VMList=@()
$VMList=(Get-VM).Name
ForEach ($VM in $VMList){Stop-VM -Name $VM}

Write-Host "`nOngoing action : " -NoNewLine
Write-Host "Display of the list of stopped virtual machines." -ForegroundColor green
Get-VM | where {$_.State -eq 'Off'}

Write-Host ""
pause
Write-Host ""
Write-Host "7 - Return to the virtual machine management menu section."
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{ 
    7{HPV-VM_Management}
    8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main}
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400: The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function HPV-Remove_VM
{
Clear-Host
$Get_VMs=Get-VM
$VMList=@()
$Get_VMs|ForEach-Object {$VMList+=$_.Name}
Write-Host "Info: " -NoNewLine
Write-Host "Viewing the list of virtual machines." -ForegroundColor green
Write-Host ""
For($i=0;$i -lt $VMList.Length;$i++){Write-Host "$i $($VMList[$i])"}
Write-Host ""
$userChoice=Read-Host "Which machine do you want to delete"
$VMChoice=$VMList[$userChoice]
Write-Host "`nOngoing action : " -NoNewLine
Write-Host "Deleting the machine: $VMChoice." -ForegroundColor green

$VMStatusRunning=Get-VM -Name $VMChoice|Where-Object {$_.State -eq 'Running'}
$VMStatusOff=Get-VM -Name $VMChoice|Where-Object {$_.State -eq 'Off'}
$isVMOff=[string]::IsNullOrEmpty($VMStatusOff)

if($isVMOff -eq $False){Stop-VM -Name $VMChoice}

Remove-VM -Name $VMChoice -Force

$VMItems=@()
$VMPath=Get-ChildItem -Path . -Filter $VMChoice -Recurse -ErrorAction SilentlyContinue -Force|%{$_.FullName}
$VMItems=$VMPath
ForEach ($VMItem in $VMItems){Remove-Item -Path $VMItem -Recurse -Force -ErrorAction SilentlyContinue}

$vhdxItems=@()
$vhdxName=$VMChoice+".vhdx"
$vhdxPath=Get-ChildItem -Path . -Filter $vhdxName -Recurse -ErrorAction SilentlyContinue -Force|%{$_.FullName}
$vhdxItems=$vhdxPath
ForEach ($vhdxItem in $vhdxItems){Remove-Item -Path $vhdxItem -Recurse -Force -ErrorAction SilentlyContinue}

Write-Host "`nOngoing action : " -NoNewLine
Write-Host "Display of the list of virtual machines." -ForegroundColor green
Get-VM

Write-Host ""
pause
Write-Host ""
Write-Host "6 - Delete another machine."
Write-Host ""
Write-Host "7 - Return to the virtual machine management menu section."
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{
    6{HPV-Remove_VM}   
    7{HPV-VM_Management}
    8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main}
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400: The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function HPV-RemoveAll_VM
{
Clear-Host
Write-Host "`nOngoing action : " -NoNewLine
Write-Host "Launch of the ICBM (intercontinental ballistic missile), deletion of all virtual machines." -ForegroundColor green

$RunningVMs=@()
$VMStatusRunning=Get-VM|Where-Object {$_.State -eq 'Running'}
$RunningVMs=$VMStatusRunning
ForEach ($VM in $RunningVMs){Stop-VM -Name $VM}

$VMList=@()
$Show_VMs=(Get-VM).Name
$VMList=$Show_VMs

$VMItems=@()
$VMItems=$VMList

$VMPath=@()
$VMPath=ForEach ($Item in $VMItems){Get-ChildItem -Path . -Filter $Item -Recurse -ErrorAction SilentlyContinue -Force|%{$_.FullName}}

ForEach ($Object in $VMItems){Remove-VM -Name $Object -Force}
ForEach ($Item in $VMPath){Remove-Item -Path $Item -Recurse -Force -ErrorAction SilentlyContinue}

$vhdxItems=@()
ForEach ($Object in $VMItems){$vhdxName+=$Object+".vhdx"}

$vhdxPath=ForEach ($Item in $vhdxName){Get-ChildItem -Path . -Filter $Item -Recurse -ErrorAction SilentlyContinue -Force|%{$_.FullName}}

ForEach ($vhdxItem in $vhdxPath){Remove-Item -Path $vhdxItem -Recurse -Force -ErrorAction SilentlyContinue}
Remove-Item -Path '.\src\GNU_Linux\vhds\*' -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path '.\src\GNU_Linux\vms\*' -Recurse -Force -ErrorAction SilentlyContinue

Remove-Item -Path '.\src\Microsoft_Windows\clients\vhds\*' -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path '.\src\Microsoft_Windows\clients\vms\*' -Recurse -Force -ErrorAction SilentlyContinue

Remove-Item -Path '.\src\Microsoft_Windows\servers\vhds\*' -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path '.\src\Microsoft_Windows\servers\vms\*' -Recurse -Force -ErrorAction SilentlyContinue

Write-Host ""
pause
Write-Host ""
Write-Host "7 - Return to the virtual machine management menu section."
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{ 
    7{HPV-VM_Management}
    8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main}
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400: The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function HPV-Virtual_Switches_Management
{
Clear-Host ""
Write-Host "Info: " -NoNewLine
Write-Host "This feature is under development."
Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main
}

function resource_management
{
Clear-Host
Write-Host "1 - Download all resources (the advantage is that you will be quiet and your time will be drastically optimized, but the disadvantage is that it may take time and storage given the many resources to download)."
Write-Host ""
Write-Host "2 - Download all Windows resources."
Write-Host "3 - Download all Linux resources."
Write-Host ""
Write-Host "4 - Interactive and personalized download."
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{
    1{Full_Download}
    2{Full_Win-Download}
    3{Full_Linux-Download}
    4{Custom_Download}
    
    8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main}
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400: The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function Full_Download
{
Clear-Host
Write-Host "Ongoing action: " -NoNewLine
Write-Host "Download all Windows resources."

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Verification of the existence of the Windows enterprise iso.`n" -NoNewLine
if(Test-Path ".\src\Microsoft_Windows\clients\iso\client-windows10-entreprise-ltsc.iso")
{
Write-Host "`nInfo: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://images-data.fra1.digitaloceanspaces.com/client-windows10-entreprise-ltsc.iso"

$dest=".\src\Microsoft_Windows\clients\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\Microsoft_Windows\clients\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Verification of the existence of the Windows Servers iso.`n" -NoNewLine
if(Test-Path ".\src\Microsoft_Windows\servers\iso\win_srv-2019.iso")
{
Write-Host "`nInfo: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://images-data.fra1.digitaloceanspaces.com/win_srv-2012.iso"

$dest=".\src\Microsoft_Windows\servers\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\Microsoft_Windows\servers\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}

if(Test-Path ".\src\Microsoft_Windows\servers\iso\win_srv-2019.iso")
{
$null
}else{
$isoURLsrc="https://images-data.fra1.digitaloceanspaces.com/win_srv-2019.iso"

$dest=".\src\Microsoft_Windows\servers\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\Microsoft_Windows\servers\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Download All Linux Resources."

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Verification of the existence of the Debian iso.`n" -NoNewLine
if(Test-Path ".\src\GNU_Linux\iso\debian-11.3.0-amd64-netinst.iso")
{
Write-Host "Info: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.3.0-amd64-netinst.iso"

$dest=".\src\GNU_Linux\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Verification of the existence of the pfsense iso.`n" -NoNewLine
if(Test-Path ".\src\GNU_Linux\iso\pfSense-CE-2.5.1-RELEASE-amd64.iso")
{
Write-Host "Info: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://images-data.fra1.digitaloceanspaces.com/pfSense-CE-2.5.1-RELEASE-amd64.iso"

$dest=".\src\GNU_Linux\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Verification of the existence of the Ubuntu iso.`n" -NoNewLine
if(Test-Path ".\src\GNU_Linux\iso\ubuntu-22.04-beta-desktop-amd64.iso")
{
Write-Host "Info: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://ubuntu.univ-nantes.fr/ubuntu-cd/22.04/ubuntu-22.04-beta-desktop-amd64.iso"

$dest=".\src\GNU_Linux\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Verification of the existence of the Rocky Linux (Full) iso.`n" -NoNewLine
if(Test-Path ".\src\GNU_Linux\iso\Rocky-8.5-x86_64-dvd1.iso")
{
Write-Host "Info: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.5-x86_64-dvd1.iso"

$dest=".\src\GNU_Linux\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Verification of the existence of the Rocky Linux (Minimal) iso.`n" -NoNewLine
if(Test-Path ".\src\GNU_Linux\iso\Rocky-8.5-x86_64-minimal.iso")
{
Write-Host "Info: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.5-x86_64-minimal.iso"

$dest=".\src\GNU_Linux\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Verification of the existence of the Parrot Security iso.`n" -NoNewLine
if(Test-Path ".\src\GNU_Linux\iso\Parrot-security-5.0_amd64.iso")
{
Write-Host "Info: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://bunny.deb.parrot.sh/parrot/iso/5.0/Parrot-security-5.0_amd64.iso"

$dest=".\src\GNU_Linux\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Verification of the existence of the Kali Linux (Live) iso.`n" -NoNewLine
if(Test-Path ".\src\GNU_Linux\iso\kali-linux-2022.1-live-amd64.iso")
{
Write-Host "Info: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://cdimage.kali.org/kali-images/current/kali-linux-2022.1-live-amd64.iso"

$dest=".\src\GNU_Linux\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Verification of the existence of the Kali Linux (Installer) iso.`n" -NoNewLine
if(Test-Path ".\src\GNU_Linux\iso\kali-linux-2022.1-installer-amd64.iso")
{
Write-Host "Info: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://cdimage.kali.org/kali-images/current/kali-linux-2022.1-installer-amd64.iso"

$dest=".\src\GNU_Linux\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}

Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{   
    8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main}
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400: The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function Full_Win-Download
{
Clear-Host
Write-Host "Ongoing action: " -NoNewLine
Write-Host "Download all Windows resources."

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Verification of the existence of the Windows enterprise iso.`n" -NoNewLine
if(Test-Path ".\src\Microsoft_Windows\clients\iso\client-windows10-entreprise-ltsc.iso")
{
Write-Host "`nInfo: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://images-data.fra1.digitaloceanspaces.com/client-windows10-entreprise-ltsc.iso"

$dest=".\src\Microsoft_Windows\clients\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\Microsoft_Windows\clients\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Verification of the existence of the Windows Servers iso.`n" -NoNewLine
if(Test-Path ".\src\Microsoft_Windows\servers\iso\win_srv-2019.iso")
{
Write-Host "`nInfo: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://images-data.fra1.digitaloceanspaces.com/win_srv-2012.iso"

$dest=".\src\Microsoft_Windows\servers\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\Microsoft_Windows\servers\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}

if(Test-Path ".\src\Microsoft_Windows\servers\iso\win_srv-2019.iso")
{
$null
}else{
$isoURLsrc="https://images-data.fra1.digitaloceanspaces.com/win_srv-2019.iso"

$dest=".\src\Microsoft_Windows\servers\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\Microsoft_Windows\servers\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}

Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{   
    8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main}
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400: The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function Full_Linux-Download
{
Clear-Host
Write-Host "Ongoing action: " -NoNewLine
Write-Host "Download All Linux Resources."

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Verification of the existence of the Debian iso.`n" -NoNewLine
if(Test-Path ".\src\GNU_Linux\iso\debian-11.3.0-amd64-netinst.iso")
{
Write-Host "Info: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.3.0-amd64-netinst.iso"

$dest=".\src\GNU_Linux\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Verification of the existence of the pfsense iso.`n" -NoNewLine
if(Test-Path ".\src\GNU_Linux\iso\pfSense-CE-2.5.1-RELEASE-amd64.iso")
{
Write-Host "Info: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://images-data.fra1.digitaloceanspaces.com/pfSense-CE-2.5.1-RELEASE-amd64.iso"

$dest=".\src\GNU_Linux\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Verification of the existence of the pfsense iso.`n" -NoNewLine
if(Test-Path ".\src\GNU_Linux\iso\ubuntu-22.04-beta-desktop-amd64.iso")
{
Write-Host "Info: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://ubuntu.univ-nantes.fr/ubuntu-cd/22.04/ubuntu-22.04-beta-desktop-amd64.iso"

$dest=".\src\GNU_Linux\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Verification of the existence of the Rocky Linux (Full) iso.`n" -NoNewLine
if(Test-Path ".\src\GNU_Linux\iso\Rocky-8.5-x86_64-dvd1.iso")
{
Write-Host "Info: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.5-x86_64-dvd1.iso"

$dest=".\src\GNU_Linux\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Verification of the existence of the Rocky Linux (Minimal) iso.`n" -NoNewLine
if(Test-Path ".\src\GNU_Linux\iso\Rocky-8.5-x86_64-minimal.iso")
{
Write-Host "Info: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.5-x86_64-minimal.iso"

$dest=".\src\GNU_Linux\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Verification of the existence of the Parrot Security iso.`n" -NoNewLine
if(Test-Path ".\src\GNU_Linux\iso\Parrot-security-5.0_amd64.iso")
{
Write-Host "Info: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://bunny.deb.parrot.sh/parrot/iso/5.0/Parrot-security-5.0_amd64.iso"

$dest=".\src\GNU_Linux\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Verification of the existence of the Kali Linux (Live) iso.`n" -NoNewLine
if(Test-Path ".\src\GNU_Linux\iso\kali-linux-2022.1-live-amd64.iso")
{
Write-Host "Info: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://cdimage.kali.org/kali-images/current/kali-linux-2022.1-live-amd64.iso"

$dest=".\src\GNU_Linux\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}

Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Verification of the existence of the Kali Linux (Installer) iso.`n" -NoNewLine
if(Test-Path ".\src\GNU_Linux\iso\kali-linux-2022.1-installer-amd64.iso")
{
Write-Host "Info: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://cdimage.kali.org/kali-images/current/kali-linux-2022.1-installer-amd64.iso"

$dest=".\src\GNU_Linux\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}

Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{   
    8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main}
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400: The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function Custom_Download
{
Clear-Host
Write-Host "`nQuestion: " -NoNewLine
Write-Host "Would you like to install Windows resources?`n"

Ask-YesOrNo

switch($AskYesOrNoresult)
{   
    0{Custom_Download-Windows}
    1{Custom_Download-Linux}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400: The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function Custom_Download-Windows
{
Write-Host "`nQuestion: " -NoNewLine
Write-Host "Would you like to install Windows Entreprise?`n"

Ask-YesOrNo

switch($AskYesOrNoresult)
{   
    0{
    $script:UserChoiceforWindowsEntreprise=$True

    Write-Host "`nQuestion: " -NoNewLine
    Write-Host "Would you like to install Windows Server 2012?`n"

    Ask-YesOrNo
    switch($AskYesOrNoresult)
{   
    0{
    $script:UserChoiceforWindowsServer2012=$True

    Write-Host "`nQuestion: " -NoNewLine
    Write-Host "Would you like to install Windows Server 2019?`n"

    Ask-YesOrNo
    switch($AskYesOrNoresult)
{
    0{$script:UserChoiceforWindowsServer2019=$True;Custom_Download-Linux}
    1{$script:UserChoiceforWindowsServer2019=$False;Custom_Download-Linux}
}
}
    1{$script:UserChoiceforWindowsServer2012=$False
    Write-Host "`nQuestion: " -NoNewLine
    Write-Host "Would you like to install Windows Server 2019?`n"

    Ask-YesOrNo
    switch($AskYesOrNoresult)
{
    0{$script:UserChoiceforWindowsServer2019=$True;Custom_Download-Linux}
    1{$script:UserChoiceforWindowsServer2019=$False;Custom_Download-Linux}
}
    }
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400: The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}
    1{
    $script:UserChoiceforWindowsEntreprise=$False

    Write-Host "`nQuestion: " -NoNewLine
    Write-Host "Would you like to install Windows Server 2012?`n"

    Ask-YesOrNo

    switch($AskYesOrNoresult){
    0{$script:UserChoiceforWindowsServer2012=$True

    Write-Host "`nQuestion: " -NoNewLine
    Write-Host "Would you like to install Windows Server 2019?`n"

    Ask-YesOrNo
    switch($AskYesOrNoresult)
{
    0{$script:UserChoiceforWindowsServer2019=$True;Custom_Download-Linux}
    1{$script:UserChoiceforWindowsServer2019=$False;Custom_Download-Linux}
}
    }
    1{$script:UserChoiceforWindowsServer2012=$True

    Write-Host "`nQuestion: " -NoNewLine
    Write-Host "Would you like to install Windows Server 2019?`n"

    Ask-YesOrNo
    switch($AskYesOrNoresult)
{
    0{$script:UserChoiceforWindowsServer2019=$True;Custom_Download-Linux}
    1{$script:UserChoiceforWindowsServer2019=$False;Custom_Download-Linux}
}
}
    }
    }
}
}

function Custom_Download-Linux
{
Write-Host "`nQuestion: " -NoNewLine
Write-Host "Would you like to install one or more Linux distributions?`n"

Ask-YesOrNo

switch($AskYesOrNoresult)
{   
    0{Custom_Download-Linux-Confirm}

    1{Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400: The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function Custom_Download-Linux-Confirm
{
Write-Host "`nQuestion: " -NoNewLine
Write-Host "Would you like to install pfsense?`n"

Ask-YesOrNo

switch($AskYesOrNoresult)
{   
    0{$script:UserChoiceforpfsense=$True}
    1{$script:UserChoiceforpfsense=$False}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400: The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}

Write-Host "`nQuestion: " -NoNewLine
Write-Host "Would you like to install Debian?`n"

Ask-YesOrNo

switch($AskYesOrNoresult)
{   
    0{$script:UserChoiceforDebian=$True}
    1{$script:UserChoiceforDebian=$False}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400: The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}

Write-Host "`nQuestion: " -NoNewLine
Write-Host "Would you like to install Ubuntu?`n"

Ask-YesOrNo

switch($AskYesOrNoresult)
{   
    0{$script:UserChoiceforUbuntu=$True}
    1{$script:UserChoiceforUbuntu=$False}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400: The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}

Write-Host "`nQuestion: " -NoNewLine
Write-Host "Would you like to install Rocky Linux (Full)?`n"

Ask-YesOrNo

switch($AskYesOrNoresult)
{   
    0{$script:UserChoiceforRockyFull=$True}
    1{$script:UserChoiceforRockyFull=$False}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400: The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}

Write-Host "`nQuestion: " -NoNewLine
Write-Host "Would you like to install Rocky Linux (Minimal)?`n"

Ask-YesOrNo

switch($AskYesOrNoresult)
{   
    0{$script:UserChoiceforRockyMin=$True}
    1{$script:UserChoiceforRockyMin=$False}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400: The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}

Write-Host "`nQuestion: " -NoNewLine
Write-Host "Would you like to install Parrot?`n"

Ask-YesOrNo

switch($AskYesOrNoresult)
{   
    0{$script:UserChoiceforParrot=$True}
    1{$script:UserChoiceforParrot=$False}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400: The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}

Write-Host "`nQuestion: " -NoNewLine
Write-Host "Would you like to install Kali Linux (Live)?`n"

Ask-YesOrNo

switch($AskYesOrNoresult)
{   
    0{$script:UserChoiceforKaliLive=$True}
    1{$script:UserChoiceforKaliLive=$False}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400: The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}

Write-Host "`nQuestion: " -NoNewLine
Write-Host "Would you like to install Kali Linux (Installer)?`n"

Ask-YesOrNo

switch($AskYesOrNoresult)
{   
    0{$script:UserChoiceforKaliInstaller=$True}
    1{$script:UserChoiceforKaliInstaller=$False}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400: The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}

if ($UserChoiceforWindowsEntreprise -eq $True){
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Verification of the existence of the Windows enterprise iso.`n" -NoNewLine
if(Test-Path ".\src\Microsoft_Windows\clients\iso\client-windows10-entreprise-ltsc.iso")
{
Write-Host "`nInfo: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://images-data.fra1.digitaloceanspaces.com/client-windows10-entreprise-ltsc.iso"

$dest=".\src\Microsoft_Windows\clients\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\Microsoft_Windows\clients\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}
}else{
$null
}

if ($UserChoiceforWindowsServer2012 -eq $True){
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Verification of the existence of the Windows Servers iso.`n" -NoNewLine
if(Test-Path ".\src\Microsoft_Windows\servers\iso\win_srv-2019.iso")
{
Write-Host "`nInfo: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://images-data.fra1.digitaloceanspaces.com/win_srv-2012.iso"

$dest=".\src\Microsoft_Windows\servers\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\Microsoft_Windows\servers\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}
}else{
$null
}

if ($UserChoiceforWindowsServer2019 -eq $True){
if(Test-Path ".\src\Microsoft_Windows\servers\iso\win_srv-2019.iso")
{
$null
}else{
$isoURLsrc="https://images-data.fra1.digitaloceanspaces.com/win_srv-2019.iso"

$dest=".\src\Microsoft_Windows\servers\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\Microsoft_Windows\servers\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}
}else{
$null
}

if ($UserChoiceforpfsense -eq $True){
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Verification of the existence of the pfsense iso.`n" -NoNewLine
if(Test-Path ".\src\GNU_Linux\iso\pfSense-CE-2.5.1-RELEASE-amd64.iso")
{
Write-Host "Info: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://images-data.fra1.digitaloceanspaces.com/pfSense-CE-2.5.1-RELEASE-amd64.iso"

$dest=".\src\GNU_Linux\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}
}else{
$null
}

if ($UserChoiceforDebian -eq $True){
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Verification of the existence of the Debian iso.`n" -NoNewLine
if(Test-Path ".\src\GNU_Linux\iso\debian-11.3.0-amd64-netinst.iso")
{
Write-Host "Info: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.3.0-amd64-netinst.iso"

$dest=".\src\GNU_Linux\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}
}else{
$null    
}

if ($UserChoiceforUbuntu -eq $True){
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Verification of the existence of the Ubuntu iso.`n" -NoNewLine
if(Test-Path ".\src\GNU_Linux\iso\ubuntu-22.04-beta-desktop-amd64.iso")
{
Write-Host "Info: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://ubuntu.univ-nantes.fr/ubuntu-cd/22.04/ubuntu-22.04-beta-desktop-amd64.iso"

$dest=".\src\GNU_Linux\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}
}else{
$null   
}

if ($UserChoiceforRockyFull -eq $True){
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Verification of the existence of the Rocky Linux (Full) iso.`n" -NoNewLine
if(Test-Path ".\src\GNU_Linux\iso\Rocky-8.5-x86_64-dvd1.iso")
{
Write-Host "Info: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.5-x86_64-dvd1.iso"

$dest=".\src\GNU_Linux\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}
}else{
$null   
}

if ($UserChoiceforRockyMin -eq $True){
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Verification of the existence of the Rocky Linux (Minimal) iso.`n" -NoNewLine
if(Test-Path ".\src\GNU_Linux\iso\Rocky-8.5-x86_64-minimal.iso")
{
Write-Host "Info: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://download.rockylinux.org/pub/rocky/8/isos/x86_64/Rocky-8.5-x86_64-minimal.iso"

$dest=".\src\GNU_Linux\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}
}else{
$null   
}

if ($UserChoiceforParrot -eq $True){
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Verification of the existence of the Parrot Security iso.`n" -NoNewLine
if(Test-Path ".\src\GNU_Linux\iso\Parrot-security-5.0_amd64.iso")
{
Write-Host "Info: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://bunny.deb.parrot.sh/parrot/iso/5.0/Parrot-security-5.0_amd64.iso"

$dest=".\src\GNU_Linux\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}
}else{
$null    
}

if ($UserChoiceforKaliLive -eq $True){
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Verification of the existence of the Kali Linux (Live) iso.`n" -NoNewLine
if(Test-Path ".\src\GNU_Linux\iso\kali-linux-2022.1-live-amd64.iso")
{
Write-Host "Info: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://cdimage.kali.org/kali-images/current/kali-linux-2022.1-live-amd64.iso"

$dest=".\src\GNU_Linux\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}
}else{
$null    
}

if ($UserChoiceforKaliInstaller -eq $True){
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Verification of the existence of the Kali Linux (Installer) iso.`n" -NoNewLine
if(Test-Path ".\src\GNU_Linux\iso\kali-linux-2022.1-installer-amd64.iso")
{
Write-Host "Info: " -NoNewLine
Write-Host "The iso has been correctly detected and identified." -ForegroundColor green
}else{
Write-Host "Info: " -NoNewLine
Write-Host "The iso cannot be found or an unpredictable error has been caused." -ForegroundColor red
Write-Host "`nOngoing action: " -NoNewLine
Write-Host "Automatic iso download.`n" -NoNewLine
$isoURLsrc="https://cdimage.kali.org/kali-images/current/kali-linux-2022.1-installer-amd64.iso"

$dest=".\src\GNU_Linux\iso"
if(Test-Path $dest)
{
$null
}else{
New-Item -Name ".\src\GNU_Linux\iso" -ItemType Directory -Force|Out-Null
}

Start-BitsTransfer -Source $isoURLsrc -Destination $dest -DisplayName "Hyper-V_Toolbox - Downloading." -Description "ISO download in progress."
}
}else{
$null   
}

Write-Host ""
pause
Write-Host ""
Write-Host "8 - Return to main menu." -ForegroundColor red
Write-Host "9 - Quit the program." -ForegroundColor darkred
Write-Host ""

$userChoice = Read-Host "Your choice"
switch ($userChoice)
{   
    8{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Back to main menu.`n";pause;main}
    9{Write-Host "`nOngoing action: " -NoNewLine;Write-Host "Exiting the program.`n";pause;$host.ui.RawUI.WindowTitle="$Get_WindowTitle";exit}
    default{Write-Host "`nInfo: " -NoNewLine;Write-Host "Error 400: The query syntax is incorrect." -ForegroundColor red;Write-Host "`nOngoing action : " -NoNewLine;Write-Host "Back to main menu.`n";pause;Clear-Host;main}
}
}

function Ask-YesOrNo
{
param
    (
        [string]$title="Confirmation",
        [string]$message="Do you want it?"
    )
    $choiceYes=New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Yes"
    $choiceNo=New-Object System.Management.Automation.Host.ChoiceDescription "&No", "No"
    $options=[System.Management.Automation.Host.ChoiceDescription[]]($choiceYes, $choiceNo)
    $script:AskYesOrNoresult=$host.ui.PromptForChoice($title, $message, $options, 1)
}

function info
{
$message="This script was created by Franck FERMAN."
Invoke-WmiMethod -Class win32_process -ComputerName 127.0.0.1 -Name create -ArgumentList "C:\Windows\System32\msg.exe * $message"|Out-Null
}

Check_AdminRights