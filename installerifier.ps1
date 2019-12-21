﻿Write-Host 
Write-Host "--------------------------------"
Write-Host "Welcome to the Installerifier!"
Write-Host "--------------------------------"
Write-Host 
Write-Host "We are going to install a bunch of things."
Write-Host

function Not-Found 
{
    param([string] $executable)

    Write-Host "Testing for $executable"

    $result = ((Get-Command $executable -ErrorAction SilentlyContinue) -ne $null)

    Write-Host "$executable found: $result"
}

Write-Host "Finding Chocolatey..."
if(Not-Found -executable "choco.exe")
{
    Write-Host "Chocolatey not found... installing it now!"

    #Set-ExecutionPolicy Bypass -Scope Process -Force; 
    #iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

    Write-Host 
    Write-Host "You need to restart your shell before you continue, otherwise Chocolatey may not be recognised correctly."
    Write-Host "This is Bad™ becuase you wont be able to run the rest of the script!"
    Write-Host
    return
}
else 
{
    Write-Host "Chocolatey is present! Continuing with the rest of the script..."
    Write-Host
    Write-Host "Go grab a coffee and come back later <3"
}

# Git
if(Not-Found -executable "git.exe")
{    
    Write-Host "Git is already installed."

}
else 
{
    Write-Host "Git not found."
    Write-Host "Installing..."

    choco install git -y

    Write-Host "Git is installed!"

}

# VSCode

if(Not-Found -executable "code.exe")
{
    Write-Host "VSCode not found."
    Write-Host "Installing..."

    #choco install vscode

    Write-Host "VSCode is installed!"
}
else 
{
    Write-Host "VSCode is already installed."
}


# Visual Studio, with Desktop, Mobile, and Web Workloads
# Sql Express
# Sql Server Management Studio
# Android Studio
# SQLite Browser
# 