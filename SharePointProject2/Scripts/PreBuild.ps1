

#Get the msbuild.exe path based on the .NET version provided as parameter

$regKey = "HKLM:\software\Microsoft\MSBuild\ToolsVersions\14.0"
$regProperty = "MSBuildToolsPath"

#$buildConfigName = Read-Host -Prompt 'Please input the build configuration name (e.g. Release, Debug, Test etc):'

$outPath = Read-Host -Prompt 'Please input the Output Path ex(Folder path where you are planning to publish)'

$msbuildExe = join-path -path (Get-ItemProperty $regKey).$regProperty -childpath "msbuild.exe"

#solution full/relative path of .csproj file

&"C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\bin\MSBuild.exe" SharePointProject2.csproj /t:Package /p:BasePackagePath=$outPath
