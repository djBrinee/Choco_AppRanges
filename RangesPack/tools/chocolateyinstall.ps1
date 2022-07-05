
$ErrorActionPreference = 'Stop';
$packageName = "RangesPack"
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileType   = "exe"
$fileName   = 'main.exe'
$fileLocation   = Join-Path $toolsDir "\src\dist\AppRanges.exe"


Install-BinFile -Name "$packageName" -Path "$fileLocation"