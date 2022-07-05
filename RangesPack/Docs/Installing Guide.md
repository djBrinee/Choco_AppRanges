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

4. Modify the files following the instructions inside these files.

5. Input this command on the terminal to unpack the files:
````
$ choco pack
````




