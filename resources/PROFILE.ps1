# Basic aliases
function Remove-ItemRecursive { Remove-Item @args -Recurse }
Set-Alias rm Remove-ItemRecursive
Set-Alias ls Get-ChildItem
Set-Alias grep Select-String
Set-Alias cat Get-Content
Set-Alias cd.. Set-Location..
Set-Alias la Get-ChildItemAll
Set-Alias home Set-LocationHome
Set-Alias cl Clear-Host

# Custom functions
function Set-Location.. { Set-Location .. }
function Get-ChildItemAll { Get-ChildItem -Force @args }
function Set-LocationHome { Set-Location "C:\dev\" }
