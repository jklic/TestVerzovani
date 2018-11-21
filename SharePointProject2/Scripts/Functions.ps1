

function GetLastTag($gitlog)
{
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
                $tag = $tag -replace "\(tag: ",""
                $tag = $tag -replace ",",""
                $tag = $tag -replace "\)",""
                break
			}
		}
    }
    return $tag
}