
git fetch
$status = git status


    $gitlog = git log --pretty=oneline --decorate=short
    $lastCommit = ""
	$lastCommit = $($gitlog -split "`r`n")[0]

	$oneTagOnly = "(\(tag: [0-9.]+),"
	$moreTags = "(\(tag: [0-9.]+\))"

	if($lastCommit -notlike "*tag: *")
	{
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
                    $tag = $tag -replace "\(tag: ",""
                    $tag = $tag -replace ",",""
                    $tag = $tag -replace "\)",""
                    break
			    }
			}
		}
		if($tag -eq "" -or $tag -eq $null)
		{
			exit 3
		}
		else
		{
            git tag $tag
		}
	}
