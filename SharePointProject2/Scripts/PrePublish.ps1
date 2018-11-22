
$path = (Get-Location).Path + "\Scripts\Functions.ps1"
. ($path)

#Podívám se jestli je něco nového na serveru, a jestli nemám něco nepushnutého
git fetch
$status = git status

#Projekt je syncnutý
if($status -like "*Your branch is up to date*" -and $status -like "*nothing to commit*")
{
	#Získám poslední TAG
	$gitTags = git tag
	$tag = getHighestTag $gitTags

	if($tag -eq "0.0.0.1")
	{
		#Žádný TAG neexistuje - přiřadit 1.0.0.0
		$newTag = "1.0.0.0"
		
	}
	else
	{
		#Zjistím jestli poslední commit má TAG
		$lastCommit = ""
		$gitlog = git log --pretty=oneline --decorate=short
		$lastCommit = $($gitlog -split "`r`n")[0]
		
		if($lastCommit -notlike "*tag: *")
		{
			#nemá - přiřadím TAG
			$newTag = "{0}.{1}.{2}.{3}" -f $tag.Major, $tag.Minor, $tag.Build, ($tag.Revision + 1)
		}
	}
	git tag $newTag
	git push --tags
}
else
{
    write-host
    exit 1
}
