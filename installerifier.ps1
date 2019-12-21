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

        #Set-ExecutionPolicy Bypass -Scope Process -Force; 
        #iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

        Write-Host 
        Write-Host "You need to restart your shell before you continue, otherwise Chocolatey may not be recognised correctly."
        Write-Host "This is Bad™ becuase you wont be able to run the rest of the script!"
        Write-Host
        return 1
    }

    Write-Host "Installing SQL Server modules"
    Install-Module -Name SqlServer

    Write-Host "Pre-requesities installed!"
    Write-Host
    # Todo: Install Update-SessionEnvironment
}

# todo check exit code here
#Install-Prerequesities




# Git
if(Missing-Command -executable "git.exe")
{    

    Write-Host "Git not found."
    Write-Host "Installing..."

    #choco install git -y

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

    #choco install vscode -y

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

    # lmao this is super heavy handed but the mobile dev package is currently failing a test in chocolately :(
    choco install visualstudio2019professional --package-parameters "--allWorkloads --includeRecommended --includeOptional --passive --locale en-US" -y

    Write-Host "Visual Studio 2019 is installed!"
}
else 
{
    Write-Host "Visual Studio 2019 already exists"
}
try 
{
    # todo make this express specific
    $sqlExpress = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server').InstalledInstances
    choco install sql-server-express -y
}
catch 
{
    Write-Host "SQL Server Express not found"
}

$sqlInstance = Get-SqlInstance -ServerInstance ".\sqlexpress"

if($sqlInstance -eq $null)
{
    choco install sql-server-management-studio
}
else 
{
    Write-Host "SQL Server Express already installed!"
}

# Visual Studio, with Desktop, Mobile, and Web Workloads
# Sql Express
# Sql Server Management Studio
# Android Studio
# SQLite Browser
# 