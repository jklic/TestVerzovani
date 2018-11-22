
$path = (Get-Location).Path + "\Scripts\Functions.ps1"
. ($path)

git fetch
$gitTags = git tag
$tag = getHighestTag $gitTags

if($tag.ToString() -eq "0.0.0.1")
{
    #Žádný TAG neexistuje - přiřadit 1.0.0.0
    $newTag = "1.0.0.0"
}
else
{
    #TAG neexistuje - zvýším verzi
	$newTag = "{0}.{1}.{2}.{3}" -f $tag.Major, $tag.Minor, $tag.Build, ($tag.Revision + 1)
}

editVersion $newTag