**Python Package Windows Installation Guide**
---
---


1. Open the "Windows Powershell" terminal with the "Administrator run"

2. Copy this command on the terminal (use if you not have Chocolatey installed):
````
$ Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
````

3. create a new Chocolatey Template Package using this command on the terminal:
````
$ choco new <"packageName">
````
(Change <"packageName"> for any name you want for your package.)

4. Modify the file ```chocolateyinstall.ps1 ``` with the following lines:
```
$ErrorActionPreference = 'Stop';
$packageName = "PACKAGE_NAME"
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileType   = "exe"
$fileName   = 'main.exe'
$fileLocation   = Join-Path $toolsDir "PATH"

Install-BinFile -Name "$packageName" -Path "$fileLocation"
```
("PACKAGE_NAME" is the name of yor package and "PATH" is the path where the bin file is located)

5. Modify the file ```chocolateyuninstall.ps1 ``` with the following lines:
```
$ErrorActionPreference = 'Stop'; # stop on all errors
$packageArgs = @{
packageName   = 'PACKAGE_NAME'
softwareName  = 'PACKAGE_NAME*'  #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique
fileType      = 'exe' #only one of these: MSI or EXE (ignore MSU for now)
# MSI
silentArgs    = "/qn /norestart"
validExitCodes= @(0, 3010, 1605, 1614, 1641) # https://msdn.microsoft.com/en-us/library/aa376931(v=vs.85).aspx
}
[array]$key = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName']

Uninstall-BinFile -Name "${packageName}"
if ($key.Count -eq 1) {
$key | % {
    $packageArgs['file'] = "$($_.UninstallString)" #NOTE: You may need to split this if it contains spaces, see below

    if ($packageArgs['fileType'] -eq 'MSI') {
    $packageArgs['silentArgs'] = "$($_.PSChildName) $($packageArgs['silentArgs'])"
    $packageArgs['file'] = ''
    } else {
    
    }

    Uninstall-ChocolateyPackage @packageArgs
}
} elseif ($key.Count -eq 0) {
Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
Write-Warning "$($key.Count) matches found!"
Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
Write-Warning "Please alert package maintainer the following keys were matched:"
$key | % {Write-Warning "- $($_.DisplayName)"}
}
```
6. Fill the files: ```LICENSE.txt``` and ```VERIFiCATION.txt``` with valid information in both.

7. Input this command on the terminal to unpack the files:
````
$ choco pack
````

8. By doing the previous step, will generate a file with the extension ```.nupkg```, it will the name of the package to install and upload to chocolatey.

9. Input the following command to install the package locally:
```
$ choco install PACKAGE_NAME -dv -s .
```

10. You gotta register yourself in the chocolatey page, it will give you a key. This key is going to be used to input the following command:

```
$ choco apikey --key PERSONAL_KEY --source https://push.chocolatey.org/ -PS
```
("PERSONAL_KEY" is the key you will see the chocolatey page)

11. Upload your package typing the following command in the terminal:

```
$ choco push PACKAGE_NAME --source https://push.chocolatey.org/
```
("PACKAGE_NAME" is the name of your package).

***
You can access to the official chocolatey documentation by clicking [here](https://docs.chocolatey.org/en-us/create/create-packages)






