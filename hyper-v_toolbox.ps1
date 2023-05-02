<#
.SYNOPSIS
Hyper-V Toolbox is an interactive PowerShell script inspired by Docker and Vagrant, designed for efficient virtual machine management.

.DESCRIPTION
This project is dedicated to providing users with an efficient and user-friendly tool for virtual machine management. With a focus on streamlining the virtual machine management process, this tool offers a range of features designed to enhance productivity and simplify operations.

.EXAMPLE
PS > Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process; .\hyper-v_toolbox.ps1

.NOTES
Author: Franck Ferman
Version: 4.0

.LINK
https://github.com/franckferman/Hyper-V_Toolbox
#>

# Retrieve the WAN access status through a randomly chosen URL from a list defined in parameter. Returns 0 if the connection is successful, otherwise 1.

function Get-WANStatus {
    param (
        [Parameter(Mandatory=$false)]
        [System.Uri[]]$urls = @('https://www.google.com/search?q=franck+ferman', 'https://www.google.com/search?q=blog+franck+ferman')
    )

    [String]$selectedUrl = Get-Random -InputObject $urls -Count 1
    $webSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

    try {
        # Hide the progress notice.
        $ProgressPreference = 'SilentlyContinue'
        $response = Invoke-WebRequest -Uri $selectedUrl -WebSession $webSession -Headers @{
            'User-Agent' = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:88.0) Gecko/20100101 Firefox/88.0'
        } -UseBasicParsing -TimeoutSec 5

        if ([Byte]$response.StatusCode -eq 200) {
            return 0
        }

        else {
            return 1
        }

    }
    catch {
        return 1
    }

}

[Single]$scriptVersion = 4.0

function Get-Update {
    param (
        [Parameter(Mandatory=$false)]
        [System.Uri]$repositoryUrl = 'https://raw.githubusercontent.com/franckferman/Hyper-V_Toolbox/main/hyper-v_toolbox.ps1'
    )

    try {
        $ProgressPreference = 'SilentlyContinue'
        $Content = (Invoke-WebRequest -Uri $repositoryUrl -UseBasicParsing -TimeoutSec 5).Content

        # 'Version:' represents the required string, '\s*' matches optional white spaces, '(\d+\.\d+)' captures the script version, where '\d+' matches one or more digits and '\.' matches a decimal point.        
        $VersionMatch = [regex]::Match($Content, 'Version:\s*(\d+\.\d+)')
        if ($VersionMatch.Success) {
            [Single]$Version = $VersionMatch.Groups[1].Value
        } else {
            [Single]$Version = $null
        }

        if ($Version -ne $null -and $scriptVersion -lt $Version) {
            return 0
        } else {
            # The script is up to date.
            return 1
        }
    }
    catch {
        Write-Warning "An unexpected error was caused during the script update check : $($_.Exception.Message)"
    }

}

# Declaration of global variables containing download links to JSON files allowing access to downloadable resources (images and virtual hard drives).

# [System.Uri]$Blank_Windows_JSON_LinksFile = 'https://drive.google.com/file/d/1dBFadZXRnhb2fPIU9LJxdcdlBQky9eR5/view?usp=sharing'
# [System.Uri]$Blank_Linux_JSON_LinksFile = 'https://drive.google.com/file/d/1V7mk8zJS6qIJIQ4U4G9Nw0b6MhstQ5OZ/view?usp=sharing'

[System.Uri]$Blank_Windows_JSON_LinksFile = 'https://raw.githubusercontent.com/franckferman/Hyper-V_Toolbox/main/assets/links/blank_windows.json'
[System.Uri]$Blank_Linux_JSON_LinksFile = 'https://raw.githubusercontent.com/franckferman/Hyper-V_Toolbox/main/assets/links/blank_linux.json'

# Representation of the graphical banners.

function Show-Buddha_Banner
{
@"
                                  _
                               _ooOoo_
                              o8888888o
                              88" . "88
                              (| -_- |)
                              O\  =  /O
                           ____/'---'\____
                         .'  \\|     |//  '.
                        /  \\|||  :  |||//  \
                       /  _||||| -:- |||||_  \
                       |   | \\\  -  /'| |   |
                       | \_|  '\'---'//  |_/ |
                       \  .-\__ '-. -'__/-.  /
                     ___'. .'  /--.--\  '. .'___
                  ."" '<  '.___\_<|>_/___.' _> \"".
                 | | :  '- \'. ;'. _/; .'/ /  .' ; |
                 \  \ '-.   \_\_'. _.'_/_/  -' _.' /
       ==========='-.'___'-.__\ \___  /__.-'_.'_.-'================
                               '=--=-'
                                          _____            _ _               
  /\  /\_   _ _ __   ___ _ __    /\   /\ /__   \___   ___ | | |__   _____  __
 / /_/ / | | | '_ \ / _ \ '__|___\ \ / /   / /\/ _ \ / _ \| | '_ \ / _ \ \/ /
/ __  /| |_| | |_) |  __/ | |_____\ V /   / / | (_) | (_) | | |_) | (_) >  < 
\/ /_/  \__, | .__/ \___|_|        \_/    \/   \___/ \___/|_|_.__/ \___/_/\_\
        |___/|_|                                                             
"@
}

function Show-Window_Banner
{
@"
 _______________________________________________________________________
|[>] Hyper-V Toolbox                                         [-]|[]|[x]"|
|"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""|"|
|PS C:\WINDOWS\system32> Set-Location -Path C:\Users\$env:USERNAME          | |
|PS C:\Users\$env:USERNAME> .\hyper-v_toolbox.ps1                           | |
|                                                                     |_|
|_____________________________________________________________________|/|
"@
}

function Show-Window_Banner-Two
{
@"
  .---------.
  |.-------.|
  ||PS C:\>||
  ||       ||
  |"-------'|
.-^---------^-.
| ---~[HPV    |
| Toolbox]---~|
"-------------'
"@
}

function Show-Window_Banner-Three
{
@"
                     ,---.           ,---.
                    / /"'.\.--"""--./,'"\ \
                    \ \    _       _    / /
                     './  / __   __ \  \,'
                      /    /_O)_(_O\    \
                      |  .-'  ___  '-.  |
                   .--|       \_/       |--.
                 ,'    \   \   |   /   /    '.
                /       '.  '--^--'  ,'       \
             .-"""""-.    '--.___.--'     .-"""""-.
.-----------/         \------------------/         \--------------.
| .---------\         /----------------- \         /------------. |
| |          '-'--'--'                    '--'--'-'             | |
| |                                                             | |
| |           __7__          %%%,%%%%%%%                        | |
| |           \_._/           ,'%% \\-*%%%%%%%                  | |
| |           ( ^ )     ;%%%%%*%   _%%%%                        | |
| |            '='|\.    ,%%%       \(_.*%%%%.                  | |
| |              /  |    % *%%, ,%%%%*(    '                    | |
| |            (/   |  %^     ,*%%% )\|,%%*%,_                  | |
| |            |__, |       *%    \/ #).-*%%*                   | |
| |             |   |           _.) ,/ *%,                      | |
| |             |   |   _________/)#(_____________              | |
| |             /___|  |__________________________|             | |
| |             ===         [Hyper-V Toolbox]                   | |
| |_____________________________________________________________| |
|_________________________________________________________________|
                   )__________|__|__________(
                  |            ||            |
                  |____________||____________|
                    ),-----.(      ),-----.(
                  ,'   ==.   \    /  .==    '.
                 /            )  (            \
                 '==========='    '===========' 
"@
}

function Show-Window_Banner-Four
{
@"
                        .="=.
                      _/.-.-.\_     _
                     ( ( o o ) )    ))
      .-------.       |/  "  \|    //
      |  HPV  |        \'---'/    //
     _|  TBX  |_       /'"""'\\  ((
   =(_|_______|_)=    / /_,_\ \\  \\
     |:::::::::|      \_\\_'__/ \  ))
     |:::::::[]|       /'  /'~\  |//
     |o=======.|      /   /    \  /
     '"""""""""'  ,--',--'\/\    /
                   '-- "--'  '--'
"@
}

function Show-Linux_Banner
{
@"
       .---.
      /     \
      \.@-@./
      /'\_/'\
     //  _  \\
    | \     )|_
   /'\_'>  <_/ \
   \__/'---'\__/
"@
}

function Show-Linux_Banner-Two
{
@"
             ,        ,
            /(        )'
            \ \___   / |
            /- _  '-/  '
           (/\/ \ \   /\
           / /   | '    \
           O O   ) /    |
           '-^--''<     '
          (_.)  _  )   /
           '.___/'    /
             '-----' /
<----.     __ / __   \
<----|====O)))==) \) /====
<----'    '--' '.__,' \
             |        |
              \       /
         ______( (_  / \______
       ,'  ,-----'   |        \
       '--{__________)        \/
"@
}

function Show-Linux_Banner-Three
{
@"
         _nnnn_                      
        dGGGGMMb     ,""""""""""""""""".
       @p~qp~~qMb    | Hyper-V Toolbox |
       M|@||@) M|   _;.................'
       @,----.JM| -'
      JS^\__/  qKL
     dZP        qKRb
    dZP          qKKb
   fZP            SMMb
   HZM            MMMM
   FqM            MMMM
 __| ".        |\dS"qML
 |    '.       | '' \Zq
_)      \.___.,|     .'
\____   )MMMMMM|   .'
     '-'       '--'
"@
}

function Show-Linux_Banner-Four
{
@"
 __________________
( Hyper-V Toolbox  )
 ------------------
        o   ^__^
         o  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||
"@
}

function Show-Windows_Logo
{
@"
 .----------------.
|          _       |
|      _.-'|'-._   |
| .__.|    |    |  |
|     |_.-'|'-._|  |
| '--'|    |    |  |
| '--'|_.-'-'-._|  |
| '--'             |
 '----------------'
"@
}

function Show-Windows_Logo-Two
{
@"
   ._________________.
   |.---------------.|
   ||   -._ .-.     ||
   ||   -._| | |    ||
   ||   -._|"|"|    ||
   ||   -._|.-.|    ||
   ||_______________||
   /.-.-.-.-.-.-.-.-.\
  /.-.-.-.-.-.-.-.-.-.\
 /.-.-.-.-.-.-.-.-.-.-.\
/______/__________\___o_\
\_______________________/
"@
}

function Show-Space_Banner
{
@"

         *                 *                  *              *
                                                      *             *
                        *            *                             ___
  *               *                                          |     | |
        *              _________##                 *        / \    | |
                      @\\\\\\\\\##    *     |              |--o|===|-|
  *                  @@@\\\\\\\\##\       \|/|/            |---|   | |
                    @@ @@\\\\\\\\\\\    \|\\|//|/     *   /     \  | |
             *     @@@@@@@\\\\\\\\\\\    \|\|/|/         | H-T   | | |
                  @@@@@@@@@----------|    \\|//          | P-B   |=| |
       __         @@ @@@ @@__________|     \|/           | V-X   | | |
  ____|_@|_       @@@@@@@@@__________|     \|/           |_______| |_|
=|__ _____ |=     @@@@ .@@@__________|      |             |@| |@|  | |
____0_____0__\|/__@@@@__@@@__________|_\|/__|___\|/__\|/___________|_|_
"@
}

function Show-Space_Banner-Two
{
@"
                                             _.--"""""--._
                                          ,-'             '-.
               _                        ,' --- -  ----   --- '.
             ,'|'.                    ,'       ________________'.
            O'.+,'O                  /        /____(_______)___\ \
   _......_   ,=.         __________;   _____  ____ _____  _____  :
 ,'   ,--.-',,;,:,;;;;;;;///////////|   -----  ---- -----  -----  |
(    (  ==)=========================|      ,---.    ,---.    ,.   |
 '._  '--'-,''''''"""""""\\\\\\\\\\\:     /'. ,'\  /_    \  /\/\  ;
    ''''''                           \    :  Y  :  :-'-. :  : ): /
                                      '.  \  |  /  \=====/  \/\/'
                                        '. '-'-'    '---'    ;'
                                          '-._           _,-'
                                              '--.....--'   ,--.
                                                           ().0()
                                                            ''-'
"@
}

function Show-Space_Banner-Three
{
@"
   .        .        .        .        .        .        .        .        .
     .         .         .        _......____._        .         .
   .          .          . ..--'"" .           """"""---...          .
                   _...--""        ................       '-.              .
                .-'        ...:'::::;:::%:.::::::_;;:...     '-.
             .-'       ..::::'''''   _...---'"""":::+;_::.      '.      .
  .        .' .    ..::::'      _.-""               :::)::.       '.
         .      ..;:::'     _.-'         .             f::'::    o  _
        /     .:::%'  .  .-"                        .-.  ::;;:.   /" "x
  .   .'  ""::.::'    .-"     _.--'"""-.           (   )  ::.::  |_.-' |
     .'    ::;:'    .'     .-" .d@@b.   \    .    . '-'   ::%::   \_ _/    .
    .'    :,::'    /   . _'    8@@@@8   j      .-'       :::::      " o
    | .  :.%:' .  j     (_)    '@@@P'  .'   .-"         ::.::    .  f
    |    ::::     (        -..____...-'  .-"          .::::'       /
.   |    ':'::    '.                ..--'        .  .::'::   .    /
    j     ':::::    '-._____...---""             .::%:::'       .'  .
     \      ::.:%..             .       .    ...:,::::'       .'
 .    \       ':::':..                ....::::.::::'       .-'          .
       \    .   '':::%::'::.......:::::%::.::::''       .-'
      . '.        . ''::::::%::::.::;;:::::'''      _.-'          .
  .       '-..     .    .   '''''''''         . _.-'     .          .
         .    ""--...____    .   ______......--' .         .         .
  .        .        .    """"""""     .        .        .        .        .
"@
}

function Show-HPV_TBX_Banner {
@"
 _     ___   _         _____  ___   _ 
| |_| | |_) \ \  /      | |  | |_) \ \_/
|_| | |_|    \_\/       |_|  |_|_) /_/ \
"@
}

function Show-PacMan-One
{
@"
   ,##.                   ,==.
 ,#    #.                 \ o ',
#        #     _     _     \    \
#        #    (_)   (_)    /    ; 
 '#    #'                 /   .'  
   '##'                   "=="
"@
Write-Host ''
Write-Host (Show-HPV_TBX_Banner)
}

function Show-PacMan-Two
{
@"
   ,##.             ,==.
 ,#    #.           \ o ',
#        #     _     \    \
#        #    (_)    /    ; 
 '#    #'           /   .'  
   '##'             "=="
"@
Write-Host ''
Write-Host (Show-HPV_TBX_Banner)
}

function Show-PacMan-Three
{
@"
   ,##.       ,==.
 ,#    #.     \ o ',
#        #     \    \
#        #     /    ; 
 '#    #'     /   .'  
   '##'       "=="
"@
Write-Host ''
Write-Host (Show-HPV_TBX_Banner)
}

$AnimatedPacman_Banner = @('Show-PacMan-One', 'Show-PacMan-Two', 'Show-PacMan-Three')

function Show-AnimatedBanner {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [Array]$AnimatedBanners
    )

    foreach ($banner in $AnimatedBanners) {
        [console]::Clear()
        Invoke-Expression $banner
        Start-Sleep -Milliseconds 800
    }

    [console]::Clear()
}

[Array]$Window_Banners = @('Show-Window_Banner', 'Show-Window_Banner-Two', 'Show-Window_Banner-Three', 'Show-Window_Banner-Four')
[Array]$Linux_Banners = @('Show-Linux_Banner', 'Show-Linux_Banner-Two', 'Show-Linux_Banner-Three', 'Show-Linux_Banner-Four')
[Array]$Windows_Banners = @('Show-Windows_Logo', 'Show-Windows_Logo-Two')
[Array]$Space_Banners = @('Show-Space_Banner' ,'Show-Space_Banner-Two' ,'Show-Space_Banner-Three')

function Get-RandomBanner {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [Array[]]$Banners
    )

    [Byte]$randomNumber = Get-Random -Minimum 0 -Maximum $Banners.Count
    & $Banners[$randomNumber]
}

Function Set-HDDSize {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$false)]
    [Array[]]$HDDSizes = @('8GB', '16GB', '32GB', '64GB', '128GB', '256GB'),
    [Parameter(Mandatory=$true)]
    [Byte]$DefaultHDDSizeChoice
  )

  $script:HDDSize
  $SelectedHDDSize
  $selectedIndex

  Write-Host 'Selection of virtual hard disk size:'
  Write-Host ''

  for ($index = 0; $index -lt $HDDSizes.Length; $index++) {
    Write-Host "$index - $($HDDSizes[$index])"
  }

  do {
    Write-Host ''
    $selectedIndex = Read-Host "Enter your choice [0-$($HDDSizes.Length - 1)]"
    Write-Host ''

    if ($selectedIndex -ge 0 -and $selectedIndex -lt $HDDSizes.Length) {
      $SelectedHDDSize = $HDDSizes[$selectedIndex]

    } else {
        Write-Warning 'Valid choice not made, the default value will be assigned.'
        $SelectedHDDSize = $HDDSizes[$DefaultHDDSizeChoice]
    }

  } while ( -not $SelectedHDDSize )

  $script:HDDSize = $SelectedHDDSize
  Write-Warning "Virtual hard disk size is set to $SelectedHDDSize."
}

Function Set-RAMSize {
  [CmdletBinding()]
  param (
    [Parameter(Mandatory=$false)]
    [Array[]]$RAMSizes = @('1GB', '2GB', '4GB', '8GB', '16GB', '32GB'),
    [Parameter(Mandatory=$true)]
    [Byte]$DefaultRAMSizeChoice
  )

  $script:RAMSize
  $SelectedRAMSize
  $selectedIndex

  Write-Host 'Selection of RAM size:'
  Write-Host ''

  for ($index = 0; $index -lt $RAMSizes.Length; $index++) {
    Write-Host "$index - $($RAMSizes[$index])"
  }

  do {
    Write-Host ''
    $selectedIndex = Read-Host "Enter your choice [0-$($RAMSizes.Length - 1)]"
    Write-Host ''

    if ($selectedIndex -ge 0 -and $selectedIndex -lt $RAMSizes.Length) {
      $SelectedRAMSize = $RAMSizes[$selectedIndex]

    } else {
        Write-Warning 'Valid choice not made, the default value will be assigned.'
        $SelectedRAMSize = $RAMSizes[$DefaultRAMSizeChoice]
    }

  } while ( -not $SelectedRAMSize )

  $script:RAMSize = $SelectedRAMSize
  Write-Warning "RAM size is set to $SelectedRAMSize."
}

Function Set-VSwitch {

    $shouldContinue = AskYesOrNo -Title 'Question' -Message 'Does a virtual switch need to be added?' -DefaultNo $true
    Write-Host ''

        if ($shouldContinue) {
            [Bool]$script:VSwitchState = $true

            [Array]$VSwitches=@()
            Get-VMSwitch | ForEach-Object { $VSwitches += $_.Name }

            Write-Host 'Virtual switch selection:'
            Write-Host ''

            For ( $i = 0; $i -lt $VSwitches.Length; $i++ ) { Write-Host "$i - $($VSwitches[$i])" }

            Write-Host ''
            [String]$SelectedVSwitchChoice = Read-Host "Enter your choice [0-$($VSwitches.Length - 1)] or enter C to cancel"
            if ($SelectedVSwitchChoice -eq 'C') {
                [Bool]$script:VSwitchState = $false
                Write-Host ''
                Write-Warning 'Cancellation action initiated. No virtual switch added.'
            
            } elseif ($SelectedVSwitchChoice -ge 0 -and $SelectedVSwitchChoice -lt $VSwitches.Length) {
                $VSwitch=$VSwitches[$SelectedVSwitchChoice]
                [String]$script:VSwitchName = $VSwitch
                Write-Host ''
                Write-Warning "Added virtual switch $VSwitch"

            } else {
                [Bool]$script:VSwitchState = $false
                Write-Host ''
                Write-Warning 'No valid choice made. No virtual switch added.'
            }

        } else { 
            [Bool]$script:VSwitchState = $false
            Write-Warning 'No virtual switch added.' 
        }

}

function Set-Name {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [String]$PrefixName = 'VM'
    )

        Write-Host ''

        [String]$VMNameInput = Read-Host 'VM name'
        if (-not $VMNameInput) {
            $randomNumber = Get-Random -Minimum 42 -Maximum 2600
            $ChosenVMName = "$PrefixName-$randomNumber"
            $script:VMName = $ChosenVMName
            Write-Host ''
            Write-Warning "No name specified. $ChosenVMName was generated and selected randomly."
        
        } else {
            $ChosenVMName = $VMNameInput
            $script:VMName = $ChosenVMName
            Write-Host ''
            Write-Warning "$ChosenVMName has been defined."
        }

}

function Set-CloneBlankVM {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [ValidateSet('Windows', 'Linux')]
        [String]$OperatingSystem
    )

    [console]::Clear()
    $banners = if ($OperatingSystem -eq 'Windows') { $Windows_Banners } else { $Linux_Banners }
    Write-Host (Get-RandomBanner -Banners $banners)

    Write-Host ''
    Write-Host 'Hyper-V Toolbox'
    Write-Host '--------------------'
    Write-Host ''

    Set-Name -Prefix $Prefix
    # Set-Name -Prefix "VM-$OperatingSystem"
    Set-VSwitch
}

function Check-OSType {
    [CmdletBinding()]
    param()

    if (($Title -match "(cli|client)") -or ($Filename -match "(cli|client)")) {
        [String]$script:OperatingSystem = 'Client'
    } elseif (($Title -match "(srv|serveur|server)") -or ($Filename -match "(srv|serveur|server)")) {
        [String]$script:OperatingSystem = 'Server'
    } else {
        # Neither Title nor Filename contain the searched keywords.
    }
}

function Set-BlankVM {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [ValidateSet('Windows', 'Linux')]
        [String]$OperatingSystem
    )

    [console]::Clear()
    $banners = if ($OperatingSystem -eq 'Windows') { $Windows_Banners } else { $Linux_Banners }
    Write-Host (Get-RandomBanner -Banners $banners)

    Write-Host ''
    Write-Host 'Hyper-V Toolbox'
    Write-Host '--------------------'

    Check-OSType

    if ($OperatingSystem -eq 'Client') {
        $Prefix = "VM-$OperatingSystem-Client"
    } elseif ($OperatingSystem -eq 'Server') {
        $Prefix = "VM-$OperatingSystem-Server"
    } else {
        $Prefix = "VM-$OperatingSystem"
    }

    Set-Name -Prefix $Prefix
    Set-VSwitch
    Write-Host ''

    [Array]$RAMSizes = if ($OperatingSystem -eq 'Windows') { @('1GB', '2GB', '4GB', '8GB', '16GB') } else { @('1GB', '2GB', '4GB', '8GB', '16GB', '32GB') }
    [Byte]$DefaultRAMSizeChoiceIndex = if ($OperatingSystem -eq 'Windows') { 1 } else { 0 }
    Set-RAMSize -RAMSizes $RAMSizes -DefaultRAMSizeChoice $DefaultRAMSizeChoiceIndex
    Write-Host ''

    [Array]$HDDSizes = if ($OperatingSystem -eq 'Windows') { @('8GB', '16GB', '32GB', '64GB', '128GB', '256GB') } else { @('8GB', '16GB', '32GB', '64GB', '128GB', '256GB', '512GB') }
    [Byte]$DefaultHDDSizeChoiceIndex = if ($OperatingSystem -eq 'Windows') { 2 } else { 1 }
    Set-HDDSize -HDDSizes $HDDSizes -DefaultHDDSizeChoice $DefaultHDDSizeChoiceIndex
    Write-Host ''
}

function Ensure-BasicResource {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$false)]
        [String]$VHDPath = '.\assets\resources\vhds',
        [Parameter(Mandatory=$false)]
        [String]$VMsPath = '.\assets\resources\vms'
    )

    $directories = @($VHDPath, $VMsPath)

    try {
        foreach ($directory in $directories) {
            if (-not (Test-Path $directory)) {
                New-Item -ItemType Directory -Path $directory -ErrorAction Stop | Out-Null
            }
        }
    }
    catch {
        Write-Error "Error when creating directories: $_"
        ScriptExit -ExitCode 1
    }
}

function Ensure-Directory {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [String]$Path
    )

    if (-not (Test-Path $Path)) {
        try {
            New-Item -Path $Path -ItemType Directory -Force -ErrorAction Stop | Out-Null
        }
        catch {
            Write-Error "Failed to create directory '$Path': $_"
            ScriptExit -ExitCode 1
        }
    }
}

function Ensure-JSONDirectory {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)][String]$JSONFilePathDestination,
        [Parameter(Mandatory = $true)][String]$JSONFileDownloadSource
    )

    if (-not (Test-Path $JSONFilePathDestination)) {
        Write-Host ''
        Write-Warning 'JSON configuration file containing links to images not found. Initiate a download attempt.'
        try {
            # Start-BitsTransfer -Source $JSONFileDownloadSource -Destination $JSONFilePathDestination -DisplayName 'Hyper-V Toolbox' -Description "Downloading from $JSONFileDownloadSource to $JSONFilePathDestination" -TransferType Download -TransferPolicy Unrestricted -ErrorAction Stop
            Invoke-WebRequest -Uri $JSONFileDownloadSource -OutFile $JSONFilePathDestination -TimeoutSec 5 -UseBasicParsing
            Write-Warning 'JSON file successfully downloaded.'
            Write-Host ''
            Read-Host 'Press enter to continue...'
        } catch {
            Write-Warning 'JSON file could not be downloaded.'
            ScriptExit -ExitCode 1
        }
    }

}

function Get-GDriveFileID {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [String]$DriveFileSource
    )

    if ($DriveFileSource.Contains('download&id')) {
    # Do nothing if the link already contains the correct format. Let the function return $null by default.
    
    } elseif ($DriveFileSource -match "drive\.google\.com") {
    $GFileID = ($DriveFileSource -split '/')[5]
    [String]$GDriveUrl = "https://drive.google.com/uc?export=download&id=$GFileID"
    return $GDriveUrl
    
    } else {
        # Do nothing if the link is not in the right format. Let the function return $null by default
    }
}

function Read-FromJSON {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [String]$JSONFilePathDestination
    )

    if (Test-Path $JSONFilePathDestination) {
        $JSONContent = Get-Content -Path $JSONFilePathDestination -Raw
        $JSONdata = $JSONContent | ConvertFrom-Json
        return $JSONdata

    } elseif ( -not (Test-Path $JSONFilePathDestination) ) {
        Write-Warning 'JSON configuration file not identified.'
        Write-Host ''
        ScriptExit -ExitCode 1

    } else {
        Write-Warning 'Unexpected error.'
        ScriptExit -ExitCode 1
    }

}

function Invoke-GDriveFileRequest {
    param(
        [Parameter(Mandatory=$true)]
        [String]$Url,
        [Parameter(Mandatory=$true)]
        [String]$Destination,
        [String]$DisplayName = 'Hyper-V Toolbox',
        [String]$Description = "Downloading from $url to $Destination"
    )

    $WebClient = New-Object System.Net.WebClient
    $DownloadPageContent = $WebClient.DownloadString($Url)

    $regex = 'action="([^"]*)"'
    $match = [regex]::Match($DownloadPageContent, $regex)

    if ($match.Success) {
    $downloadUrl = $match.Groups[1].Value
    Write-Host $downloadUrl
    } else {
    Write-Warning 'Download URL not found.'
    }

    Add-Type -AssemblyName System.Web
    $DownloadLink = [System.Web.HttpUtility]::HtmlDecode($downloadUrl)

    Start-BitsTransfer -Source $DownloadLink -Destination $Destination -DisplayName $DisplayName -Description $Description

    [String]$script:Url = $DownloadLink
}

function Check-BlankVM_Links {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [String]$JSONFilePath,
        [Parameter(Mandatory = $true)]
        [System.Uri]$JSONFileURL
    )

    $JSONDirectory = Split-Path -Path $JSONFilePath
    Ensure-Directory -Path $JSONDirectory

    [System.Uri]$Url = $JSONFileURL

    if ($Url -match "drive\.google\.com") { $Url = Get-GDriveFileID -DriveFileSource $Url }

    try {
        [void](Ensure-JSONDirectory -JSONFilePathDestination $JSONFilePath -JSONFileDownloadSource $Url)
    }
    catch {
        Write-Warning "Error occurred during JSON file download: $_"
        ScriptExit -ExitCode 1
    }

    [Array]$script:MenuItems = Read-FromJSON -JSONFilePathDestination $JSONFilePath
}

function Show-Downloadable_VM {
    [console]::Clear()
    Write-Host (Get-RandomBanner -Banners $Space_Banners)
    Write-Host ''
    Write-Host 'Hyper-V Toolbox'
    Write-Host '--------------------'

    for ($i = 0; $i -lt $MenuItems.Count; $i++) { Write-Host " $($i + 1). $($MenuItems[$i].Title)" }
    Write-Host ''
    $choice = Read-Host "Enter your choice [1-$($MenuItems.Count)] or 'C' to cancel"
    if ($choice -ne 'c') {
        $index = [int]$choice - 1

        if ($index -ge 0 -and $index -lt $MenuItems.Count) {
            $Url = $MenuItems[$index].Url

            [String]$script:Title = $MenuItems[$index].Title
            [String]$script:Filename = $MenuItems[$index].Filename
            [String]$script:OutputDirectory = '.\assets\images'
            [String]$script:OutputPath = Join-Path -Path $OutputDirectory -ChildPath $Filename

            if (-not (Test-Path $OutputDirectory)) { [void](New-Item -Path $OutputDirectory -ItemType Directory -Force) }

            if (-not (Test-Path $OutputPath)) {
                if ($Url -match "drive\.google\.com") {
                    $Url = Get-GDriveFileID -DriveFileSource $Url
                    Invoke-GDriveFileRequest -Url $Url -DisplayName 'Hyper-V Toolbox' -Destination $OutputPath -Description "Downloading of $title from $Url to $outputPath"
                    # Start-BitsTransfer -Source "$Url" -Destination "$OutputPath" -DisplayName "Hyper-V Toolbox" -Description "Downloading of $Title from $Url to $OutputPath" -TransferType Download -Priority High -TransferPolicy Unrestricted; [console]::Clear()
                } else {
                [Byte]$maxRetries = 2
                [Byte]$retryInterval = 5 # seconds
                [Byte]$retryCount = 0
                do {
                    try {
                    Write-Host ''
                    Write-Warning "$Title in $OutputPath not found. Initiate a download attempt."
                    Start-BitsTransfer -Source $Url -Destination $OutputPath -DisplayName 'Hyper-V Toolbox' -Description "Downloading of $Title from $Url to $OutputPath" -TransferType Download -TransferPolicy Unrestricted
                    Write-Warning "$Title successfully downloaded in $OutputPath."
                    Write-Host ''
                    Read-Host 'Press enter to continue...'
                    break
                    } catch {
                    $retryCount++
                    if ($retryCount -lt $maxRetries) {
                        Write-Host ''
                        Write-Warning "An error was caused during the download of $Title. New attempt in $retryInterval seconds..."
                        Start-Sleep -Seconds $retryInterval
                    } else {
                        Write-Host ''
                        Write-Error "An error was caused during the download of $Title after $maxRetries attempts."
                        ScriptExit -ExitCode 1
                    }
                    }

                } while ($retryCount -lt $maxRetries)
                }

            } else {
                # Do nothing. Let the function return $null by default
            }
        
        } else {
        Show-Invalid_Input
        Show-Downloadable_VM
        }
    
    } elseif ($choice -eq 'c') { 
        BlankVM-Menu
    } else {
        Show-Invalid_Input
        Show-Downloadable_VM
    }

}

function New-BlankVM-AdditionalTasks {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [String]$VMName,
        [Parameter(Mandatory = $true)]
        [String]$OutputPath,
        [Parameter(Mandatory = $true)]
        [String]$VMType
    )

    Set-VM -Name $VMName -AutomaticCheckpointsEnabled $false

    Add-VMDvdDrive -VMName $VMName -Path $OutputPath

    # Sorts the elements of the boot order according to their type of boot device and stores them in separate variables according to their type (HDD, Network, DVD).
    $VM = Get-VMFirmware $VMName
    $BootOrder = $VM.BootOrder

    for ($i = 0; $i -lt $BootOrder.Count; $i++) {
        if ($BootOrder[$i].Device.Name -match 'Network Adapter') {
            $Network += $BootOrder[$i]
        }
        elseif ($BootOrder[$i].Device.Name -match 'Hard Drive') {
            $HDD += $BootOrder[$i]
        }
        elseif ($BootOrder[$i].Device.Name -match 'DVD Drive') {
            $DVD += $BootOrder[$i]
        }
    }

    Set-VMFirmware -VMName $VMName -BootOrder $DVD, $HDD, $Network

    if ($VMType -eq 'Windows') {
        # Additional tasks to be added for Windows. Nothing for the moment.
    }
    elseif ($VMType -eq 'Linux') {
        Set-VMFirmware $VMName -EnableSecureBoot Off
        Set-VMMemory $VMName -DynamicMemoryEnabled $False
    }
}

function New-BlankVM {
    [CmdletBinding()]
    param()

    $VHDPath = '.\assets\resources\vhds'
    $VMsPath = '.\assets\resources\vms'
    $RAMSize = [System.Convert]::ToInt64($RAMSize.Replace("GB", "")) * 1GB
    $HDDSize = [System.Convert]::ToInt64($HDDSize.Replace("GB", "")) * 1GB

    $ProgressPreference = 'SilentlyContinue'

    if ($VSwitchState -eq $false) {
        [void](New-VM -Name $VMName -MemoryStartupBytes $RAMSize -Generation 2 -NewVHDPath "$VHDPath\$VMName.vhdx" -NewVHDSizeBytes $HDDSize -Path $VMsPath)
    }

    elseif ($VSwitchState -eq $true) {
        [void](New-VM -Name $VMName -MemoryStartupBytes $RAMSize -Generation 2 -NewVHDPath "$VHDPath\$VMName.vhdx" -NewVHDSizeBytes $HDDSize -Path $VMsPath -SwitchName $VSwitchName)
    }

    else {
        Write-Warning 'Error during the creation of the virtual machine.'
        ScriptExit -ExitCode 1
    }

}

function SelectionMenu {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [String]$VMType
    )

    while ($true) {
        Write-Host (Show-SelectionMenu -VMType 'Windows')

        $choice = Read-Host 'Enter your choice'
        switch ($choice) {
            '1' { BlankVM-Menu }

            '2' { if ($VMType -eq 'Windows') { BlankVM-Clone -OperatingSystem 'Windows' } else { BlankVM-Clone -OperatingSystem 'Linux' } }
            '3' { if ($VMType -eq 'Windows') { BlankVM-Similar -OperatingSystem 'Windows' } else { BlankVM-Similar -OperatingSystem 'Linux' } }

            'r' { if ((Get-VM -Name $VMName).State -eq 'Off') { Start-VM -Name $VMName } else { Write-Host ''; Read-Host "VM $VMName is already running..."; } [console]::Clear(); if ($VMType -eq 'Windows') { Show-CreatedVMStatus -VMType 'Windows' } else { Show-CreatedVMStatus -VMType 'Linux' } }
            's' { if ((Get-VM -Name $VMName).State -eq 'Running') { Stop-VM -Name $VMName -Force } else { Write-Host ''; Read-Host "VM $VMName is already stopped..."; } [console]::Clear(); if ($VMType -eq 'Windows') { Show-CreatedVMStatus -VMType 'Windows' } else { Show-CreatedVMStatus -VMType 'Linux' } }
            'b' { main }
            'q' { Write-Host ''; ScriptExit -ExitCode 0 }
            default { Show-Invalid_Input; [console]::Clear(); Show-CreatedVMStatus -VMType $OperatingSystem }
        }
    }
}

function Show-SelectionMenu {
@"
  1 - Create a new blank virtual machine.

  2 - Clone (create) a new blank virtual machine with the exact same configuration.
  3 - Create a new blank virtual machine similar to an existing one, but with a different configuration.

r - Run the virtual machine in the background.
s - Stop the virtual machine.

b - Back to the main menu.
q - Quit the program.

"@
}

function Show-CreatedVMStatus {
    param(
        [Parameter(Mandatory=$true)]
        [ValidateSet('Windows', 'Linux')]
        [String]$VMType
    )

    Write-Host (Show-HPV_TBX_Banner)
    Write-Host '---------------------------------------------'

    if ((Get-VM -Name $VMName).Name) {
        Write-Host ''
        Write-Host "Virtual machine $VMName created successfully."
        # Get-VM -Name $VMName | Format-Table Name, State, CPUUsage, MemoryAssigned, Uptime, Status, Version -AutoSize -Wrap
        Get-VM -Name $VMName | Format-Table Name, State, @{Name='RAM'; Expression={$RAMSize}}, @{Name='Storage'; Expression={$HDDSize}} -AutoSize -Wrap

        if ((Get-VM).Count -gt 1) {
            Write-Host 'Current pool of virtual machines:'
            Get-VM | Format-Table Name, State -AutoSize -Wrap
        } else { }

        SelectionMenu -VMType $VMType

    } else { Write-Host "Error when checking the status of the virtual machine $VMName." }

}

function BlankVM-Clone {
    param (
        [Parameter(Mandatory = $true)]
        [ValidateSet('Windows', 'Linux')]
        [String]$OperatingSystem
    )

    Ensure-BasicResource
    Set-CloneBlankVM -OperatingSystem $OperatingSystem
    New-BlankVM
    Show-AnimatedBanner -AnimatedBanners $AnimatedPacman_Banner
    New-BlankVM-AdditionalTasks -VMName $VMName -OutputPath $OutputPath -VMType $OperatingSystem
    Show-CreatedVMStatus -VMType $OperatingSystem
}

function BlankVM-Similar {
    param (
        [Parameter(Mandatory = $true)]
        [ValidateSet('Windows', 'Linux')]
        [String]$OperatingSystem
    )

    Set-BlankVM -OperatingSystem $OperatingSystem
    New-BlankVM
    Show-AnimatedBanner -AnimatedBanners $AnimatedPacman_Banner
    New-BlankVM-AdditionalTasks -VMName $VMName -OutputPath $OutputPath -VMType $OperatingSystem
    Show-CreatedVMStatus -VMType $OperatingSystem
}

function BlankVM {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateSet('Windows', 'Linux')]
        [String]$OperatingSystem
    )

    # Choose the appropriate JSON file and links URL based on the operating system.
    $JSONFilePath = if ($OperatingSystem -eq 'Windows') { '.\assets\links\blank_windows.json' } else { '.\assets\links\blank_linux.json' }
    $JSONFileURL = if ($OperatingSystem -eq 'Windows') { $Blank_Windows_JSON_LinksFile } else { $Blank_Linux_JSON_LinksFile }

    # Check for links and show downloadable VM.
    Check-BlankVM_Links -JSONFilePath $JSONFilePath -JSONFileURL $JSONFileURL
    Show-Downloadable_VM

    # Ensure basic resources and set blank VM parameters.
    Ensure-BasicResource
    Set-BlankVM -OperatingSystem $OperatingSystem

    # Create the VM and perform additional tasks.
    New-BlankVM
    Show-AnimatedBanner -AnimatedBanners $AnimatedPacman_Banner
    New-BlankVM-AdditionalTasks -VMName $VMName -OutputPath $OutputPath -VMType $OperatingSystem

    # Show the status of the VM.
    Show-CreatedVMStatus -VMType $OperatingSystem
}

function BlankVM-Menu {
    while ($true) {
        [console]::Clear()
        Write-Host (Show-OSMenu)

            $choice = Read-Host 'Enter your choice'
            switch ($choice) {
            '1' { BlankVM -OperatingSystem 'Windows' }
            '2' { BlankVM -OperatingSystem 'Linux' }
            'b' { main }
            'q' { Write-Host ''; ScriptExit -ExitCode 0 }
            default { Show-Invalid_Input }
        }
    }
}

function Show-OSMenu {
Write-Host (Get-RandomBanner -Banners $Window_Banners)
@"

Hyper-V Toolbox - OS selection
--------------------
  1 - Windows
  2 - Linux

b - Back
q - Quit the program.

"@
}

# Interactive confirmation function.

function AskYesOrNo {
    param (
        [String]$Title,
        [String]$Message,
        [Bool]$DefaultNo = $false
    )

    if ($host.UI.SupportsVirtualTerminal) {
        $choiceYes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Yes"
        $choiceNo = New-Object System.Management.Automation.Host.ChoiceDescription "&No", "No"
        $options = [System.Management.Automation.Host.ChoiceDescription[]]($choiceYes, $choiceNo)
        $defaultChoice = if ($DefaultNo) { 1 } else { 0 }
        $result = $host.UI.PromptForChoice($Title, $Message, $options, $defaultChoice)

        return ($result -eq 0)
    } else {
        while ($true) {
            $response = Read-Host -Prompt "$Message [y/n]"
            switch ($response.ToLower()) {
                "y" { return $true }
                "yes" { return $true }
                "n" { return $false }
                "no" { return $false }
                default { Write-Host "Please enter 'y' or 'n'." }
            }
        }
    }
}

# Help Menu. More graphic than informative.

function Show-Help {
[console]::Clear()
    @"
                                             _______________________
   _______________________-------------------                       '\
 /:--__                                                              |
||< > |                                   ___________________________/
| \__/_________________-------------------                         |
|                                                                  |
 |                       HYPER-V_TOOLBOX                            |
 |                                                                  |
 |      "Inspired by Vagrant and Docker,                            |
  |        This project is aimed at providing users                  |
  |      with a more efficient and user-friendly tool                |
  |        for virtual machine management."                          |
   |                                                                 |
  |                                              ____________________|_
  |  ___________________-------------------------                      '\
  |/'--_                                                                 |
  ||[ ]||                                            ___________________/
   \===/___________________--------------------------

"@
}

# Logical (functional) part of the main menu.

function main {
    while ($true) {
        [console]::Clear()
        Write-Host (Show_Menu)

        $choice = Read-Host 'Enter your choice'
        switch ($choice) {
            '1' { BlankVM-Menu }
            '2' { Write-Host ''; Write-Warning 'Feature under development'; pause; main }
            '3' { Write-Host ''; Write-Warning 'Feature under development'; pause; main }
            '4' { Write-Host ''; Write-Warning 'Feature under development'; pause; main }
            '5' { Write-Host ''; Write-Warning 'Feature under development'; pause; main }
            '6' { Write-Host ''; Write-Warning 'Feature under development'; pause; main }
            'h' { Write-Host (Show-Help); Write-Host ''; Read-Host 'Press enter to continue...' }
            'q' { Write-Host ''; ScriptExit -ExitCode 0 }
            default { Show-Invalid_Input }
        }
    }
}

# Graphical representation of the main menu.

function Show_Menu {
Write-Host (Show-Buddha_Banner)
@"

Hyper-V Toolbox - Main menu
-------------------
  1 - Create a virtual machine
  2 - Create a preconfigured virtual machine from a template [Under development]

  3 - Creation of laboratories [Under development]

  4 - Management of virtual machines [Under development]
  5 - Management of virtual switches [Under development]

  6 - Management of local resources [Under development]
  
h - Show help
q - Quit the program.

"@
}

# Handling of invalid entries.

function Show-Invalid_Input {
    Write-Host ''
    Write-Warning 'Invalid entry detected.'
    Read-Host 'Press enter to continue...'
}

# Logging function. Useful for debugging. Takes into account many parameters, including logging to Windows Event Viewer, logging to a file (LogFile), log category (Level)...

function Write-Log {
    param (
        [Parameter(Mandatory = $true)][String]$Message,
        [Parameter(Mandatory = $false)][ValidateSet('INFO', 'WARNING', 'ERROR')][String]$Level = 'INFO',
        [Parameter(Mandatory = $false)][String]$LogFile = 'hyper-v-toolbox.log',
        [Parameter(Mandatory = $false)][Bool]$UseEventLog = $false,
        [Parameter(Mandatory = $false)][String]$EventLogSource = 'Hyper-V_Toolbox'
    )

    if ($Verbose) {
        $timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
        $logMessage = "[$timestamp] [$Level] $Message"

        try {
            Add-Content -Path $LogFile -Value $logMessage -ErrorAction Stop
        } catch {
            Write-Error "Failed to write log message: $_"
        }

        if ($UseEventLog) {
            $entryType = @{
                'INFO' = 'Information'
                'WARNING' = 'Warning'
                'ERROR' = 'Error'
            }[$Level]

            if (-not (Get-EventLog -LogName Application -Source $EventLogSource -ErrorAction SilentlyContinue)) {
                New-EventLog -LogName Application -Source $EventLogSource
            }

            Write-EventLog -LogName Application -Source $EventLogSource -EntryType $entryType -EventId 1000 -Message $Message
        }
    }
}

# Exit function.

function ScriptExit {
    [CmdletBinding()]
    param (
        [Parameter()]
        [int]$ExitCode = 0
    )

    Write-Warning "Exiting script with exit code $ExitCode"
    exit $ExitCode
}

# Administrator rights verification function.

function Get-AdminRights {
    [CmdletBinding()]
    [OutputType([Bool])]
    param()

    $identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object System.Security.Principal.WindowsPrincipal($identity)
    $adminRole = [System.Security.Principal.WindowsBuiltInRole]::Administrator
    return $principal.IsInRole($adminRole)
}

# Entry point.

# Enable or disable the logging function.
$Verbose = $false

# Verification of the administration rights as well as the state of the Hyper-V module, on which the script depends.

if (Get-AdminRights) {
    Write-Log -Message 'The script launch operation has been successfully executed.' -Level 'INFO' -UseEventLog $true

    if (Get-WindowsOptionalFeature -FeatureName Microsoft-Hyper-V-All -Online | Where-Object {$_.State -eq 'Enabled'}) {
        Import-Module Hyper-V

    } else {
        Write-Warning 'The Hyper-V module is required to operate.'
    }

[Byte]$WANStatus = Get-WANStatus
if ($WANStatus -eq 0) {
    # The web request returned a status code of 200 (OK)
    [Byte]$UpdateStatus = Get-Update
    if ($UpdateStatus -eq 0) {
        Write-Warning 'An update of the script is available. Download the latest version from https://github.com/franckferman/Hyper-V_Toolbox/releases'
        Write-Host ''
        Read-Host 'Press enter to continue...'

    } elseif ($UpdateStatus -eq 1) {
        # The script is up to date.
    } else { }
} else {
    # Internet connection is not available.
}

    main
} else {
    Write-Warning 'You must have administrator rights to run this program.'
}
