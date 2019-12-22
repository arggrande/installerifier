Write-Host 
Write-Host "--------------------------------"
Write-Host "Welcome to the Installerifier!"
Write-Host "--------------------------------"
Write-Host 
Write-Host "We are going to install a bunch of things."
Write-Host

function Missing-Command 
{
    param([string] $executable)

    $result = ((Get-Command $executable -ErrorAction SilentlyContinue) -eq $null)

    return $result
}

function Install-Prerequesities 
{
    Write-Host "Installing pre-requesites for this script."
    Write-Host

    Write-Host "Installing Nuget Provider..."
    Install-PackageProvider -Name NuGet -RequiredVersion 2.8.5.201 -Force 
    Write-Host "NuGet package provider install!"

    Write-Host "Trusting the main PSGallery so we can install things..."
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

    Write-Host "Installing how we detect Visual Studio..."
    Install-Module VSSetup -Scope CurrentUser

    Write-Host "Finding Chocolatey..."
    if(Missing-Command -executable "choco.exe")
    {
        Write-Host "Chocolatey not found... installing it now!"

        Set-ExecutionPolicy Bypass -Scope Process -Force; 
        iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

        Write-Host 
        Write-Host "You need to restart your shell before you continue, otherwise Chocolatey may not be recognised correctly."
        Write-Host "This is Bad™ becuase you wont be able to run the rest of the script!"
        Write-Host
        return 1
    }

    Write-Host "Installing SQL Server modules"
    Install-Module -Name SqlServer

    Write-Host "Installing Git Fork!"
    choco install git-fork -y

    Write-Host "Pre-requesities installed!"
    Write-Host
    # Todo: Install Update-SessionEnvironment
}

# todo check exit code here
$preReqs = Install-Prerequesities

if($preReqs -eq 1)
{
    Write-Host "Prerequisites failed to install correctly :("
    return
}

# Git
if(Missing-Command -executable "git.exe")
{    

    Write-Host "Git not found."
    Write-Host "Installing..."

    choco install git -y

    Write-Host "Git is installed!"
}
else 
{
    Write-Host "Git is already installed."
}

# VSCode

if(Missing-Command -executable "code.exe")
{
    Write-Host "VSCode not found."
    Write-Host "Installing..."

    choco install vscode -y

    Write-Host "VSCode is installed!"
}
else 
{
    Write-Host "VSCode is already installed."
}


$vs2017 = Get-VSSetupInstance -All | Select-VSSetupInstance -Require 'Microsoft.VisualStudio.Workload.NativeDesktop' -Version '[15.0,16.0)' -Latest

if($vs2017 -eq $null) 
{
    Write-Host "Visual Studio 2019 not found."

    # full install command fails, just going with default for now. This will likely mean you'll have to run the installer afterwards to get the workloads you need.
    choco install visualstudio2019professional -y

    Write-Host "Visual Studio 2019 is installed!"
}
else 
{
    Write-Host "Visual Studio 2019 already exists"
}

$sqlInstance = Get-SqlInstance -ServerInstance ".\sqlexpress"

if($sqlInstance -eq $null)
{
    choco install sql-server-management-studio -y
}
else 
{
    Write-Host "SQL Server Express already installed!"
}

Write-Host "----------------------------"
Write-Host "Done!! Oh happy dayyyys..."
Write-Host "----------------------------"

# Visual Studio, with Desktop, Mobile, and Web Workloads
# Sql Express
# Sql Server Management Studio
# Android Studio
# SQLite Browser
# 