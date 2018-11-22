
$path = (Get-Location).Path + "\Scripts\Functions.ps1"
. ($path)

#Podívám se jestli je něco nového na serveru, a jestli nemám něco nepushnutého
git fetch
$status = git status

#Projekt je syncnutý
if($status -like "*Your branch is up to date*" -and $status -like "*nothing to commit*")
{
	#Získám poslední TAG
    $gitlog = git log --pretty=oneline --decorate=short
	$tag = GetLastTag $gitlog

	if($tag -eq "" -or $tag -eq $null)
	{
		#Žádný TAG neexistuje - končím chybou ? přiřadit 1.0.0.0 ????
		exit 2
	}
	else 
	{
		#Zjistím jestli poslední commit má TAG
		$lastCommit = ""
		$lastCommit = $($gitlog -split "`r`n")[0]
		
		if($lastCommit -notlike "*tag: *")
		{
			#nemá - přiřadím TAG + verzi 
			$newTag = "{0}.{1}.{2}.{3}" -f $tag.Major, $tag.Minor, $tag.Build, ($tag.Revision + 1)
			editVersion $newTag
			git tag $newTag
			git push --tags
		}
		else
		{
			#má - upravím verzi
			$newTag = "{0}.{1}.{2}.{3}" -f $tag.Major, $tag.Minor, $tag.Build, $tag.Revision
			editVersion $newTag		
		}
	}
}
else
{
    write-host
    exit 1
}
