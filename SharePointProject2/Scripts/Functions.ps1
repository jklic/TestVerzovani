

function GetLastTag($gitlog)
{
	$oneTagOnly = "(tag: [0-9.]+),"
	$moreTags = "(\(tag: [0-9.]+\))"

    $tag = ""
    ForEach ($line in $($gitlog -split "`r`n"))
	{
		if($line -like "*tag: *")
		{
			$tag = ""
			$tag = [regex]::Matches($line, $oneTagOnly)
            if($tag.Count -eq 0)
            {
                $tag = [regex]::Matches($line, $moreTags)
                if($tag.Count -eq 0)
                {
                    continue
                }
            }

            $tag = $tag[0].Value
                
            if ($tag -ne "" -and $tag -ne $null)
            {
				$tag = $tag -replace "\(",""
                $tag = $tag -replace "tag: ",""
                $tag = $tag -replace ",",""
                $tag = $tag -replace "\)",""
                break
			}
		}
    }
    return [version]$tag
}

function getHighestTag($gitTags)
{
	[version]$highestTag = "0.0.0.1"
	foreach($tag1 in $gitTags)
	{
		try 
		{
			$tag1 = [version]$tag1
			if($tag1 -gt $highestTag)
			{
				$highestTag = $tag1
			}
		}
		catch {}
	}

	return $highestTag
}

function GetVersion 
{
	$VersionLineRegex = "\[assembly: AssemblyInformationalVersion\(`"([0-9]+.[0-9]+.[0-9]+.[0-9]+)`"\)\]"
    $VersionNumberRegex = "([0-9]+.[0-9]+.[0-9]+.[0-9]+)"

	try 
	{
		$file = (Get-Content .\Properties\AssemblyInfo.cs)
		$assemblyVersion = [regex]::Matches($file, $VersionLineRegex)
        $version = $assemblyVersion = [regex]::Matches($assemblyVersion, $VersionNumberRegex)
		if($version -ne "" -and $version -ne $null)
		{
			$version = [version]$version.groups[0].Value
		}
	}
	catch
	{
		return $null
	}
	return $version
}

function editVersion($NewVersion)
{
	$VersionNumberRegex = "([0-9]+.[0-9]+.[0-9]+.[0-9]+)"

	$version = GetVersion

	try 
	{
			(Get-Content .\Version.cs) -replace $version, $NewVersion | Out-File .\Version.cs
	}
	catch{}
}