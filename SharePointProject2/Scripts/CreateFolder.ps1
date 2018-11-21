
git fetch
$status = git status

if($status -like "*Your branch is up to date*" -and $status -like "*nothing to commit*")
{
	$gitlog = git log --pretty=oneline --decorate=short
	$lastCommit = $($gitlog -split "`r`n")[0]

	$oneTagOnly = "(\(tag: [0-9.]+),"
	$moreTags = "(\(tag: [0-9.]+\))"

	if($lastCommit -notlike "tag: ")
	{
		exit 2
		ForEach ($line in $($gitlog -split "`r`n"))
		{
			if($line -like "*tag: *")
			{
				$tag = [regex]::Matches($line, $oneTagOnly)
			}
		}
	}
}
else
{
    write-host
    exit 1
}
