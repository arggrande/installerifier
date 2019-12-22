# installerifier
Installs a bunch of stuff I find useful when setting up a dev environment.

I'd rate this script as "idempotent-ish". Still very WIP, so YMMV.

## What does this install

### A bunch of pre-requesite tools

1. The NuGet Package Provider, along with PSGallery so we can install some choice PowerShell tools
2. The VSSetup PowerShell module, so we can detect if Visual Studio is installed
3. Chocolatey, so we can get our Executables™
4. The SqlServer PowerShell module, so we can detect if SqlServer is installed
5. Git Fork, because its seriously *amazing*. I prefer this over SourceTree, but that is my Opinion™

### Microsoft Stuff

1. VSCode
2. Visual Studio 2019 Professional
3. SQL Server Management Studio
4. [TODO] SQL Server Express

### Other Stuff

1. [TODO] Android Studio
2. [TODO] SQLite Browser 

## Requirements

1. You must have PowerShell. One Day™ I'll do a bash variant for the Mac/Linux folks in the house, but for now PowerShell will do