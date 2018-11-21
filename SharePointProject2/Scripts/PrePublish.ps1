
Import-Module .\Functions.ps1

git fetch
$status = git status

if($status -like "*Your branch is up to date*" -and $status -like "*nothing to commit*")
{
    $gitlog = git log --pretty=oneline --decorate=short
    $lastCommit = ""
	$lastCommit = $($gitlog -split "`r`n")[0]

	$oneTagOnly = "(\(tag: [0-9.]+),"
	$moreTags = "(\(tag: [0-9.]+\))"

	if($lastCommit -notlike "*tag: *")
	{
		#exit 2
		$tag =  GetLastTag $gitlog

		if($tag -eq "" -or $tag -eq $null)
		{
			exit 3
		}
		else
		{
            git tag $tag
		}
	}
}
else
{
    write-host
    exit 1
}
