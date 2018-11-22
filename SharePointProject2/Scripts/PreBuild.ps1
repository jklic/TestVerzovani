
$path = (Get-Location).Path + "\Scripts\Functions.ps1"
. ($path)

# . C:\Users\klic\source\repos\SharePointProject2\SharePointProject2\Scripts\Functions.ps1

# git fetch
# $status = git status


# $gitlog = git log --pretty=oneline --decorate=short
# $lastCommit = ""
# $lastCommit = $($gitlog -split "`r`n")[0]

# if($lastCommit -notlike "*tag: *")
# {
# 	$tag = GetLastTag $gitlog

# 	editVersion

# 	if($tag -eq "" -or $tag -eq $null)
# 	{
# 		exit 3
# 	}
# 	else
# 	{
# 	    git tag $tag
# 	}
# }
