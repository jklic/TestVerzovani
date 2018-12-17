

foreach($file in "C:\inetpub\deploy")
{
    if($file.extension -eq ".wsp")
    {

        $cred = Get-Credential
        New-PSDrive -Name NewPSDrive -PSProvider FileSystem -Root \\lilith\deploy -Credential $cred
        
        New-Item NewPSDrive:\Temp -ItemType Directory -Force
        New-Item NewPSDrive:\Temp\$projectName -ItemType Directory -Force
        
        try
        {
            $process = "cmd.exe"
            $arg = "/c C:\Windows\System32\expand.exe -F:*.dll \\lilith\deploy\$projectName.wsp \\lilith\deploy\Temp\$projectName"     
            Start-Process $process -ArgumentList $arg -Wait
            
            New-Item  NewPSDrive:\$projectName.wsp.txt -ItemType File -Force
        }
        catch
        {
            Remove-Item -Path NewPSDrive:\Temp -Force -Recurse
            Remove-Item -Path NewPSDrive:\$projectName+".wsp.txt"
            Remove-PSDrive NewPSDrive
            exit 0
        }
        
        foreach($file in Get-ChildItem -Path  NewPSDrive:\Temp\$projectName)
        {
            $versions = $file | Select-Object -ExpandProperty VersionInfo
            $fileVersion = $versions.FileVersion
            $productVersion = $versions.ProductVersion
            Add-Content  NewPSDrive:\$projectName.wsp.txt "$file;$fileVersion;$productVersion"
        }
        
        Remove-Item -Path NewPSDrive:\Temp -Force -Recurse
        Remove-PSDrive NewPSDrive
    }
}