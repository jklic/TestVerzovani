
if($args[0] -eq "\\lilith\deploy\local")
{
	$path = (Get-Location).Path + "\Scripts\Functions.ps1"
	. ($path)
	$gitFolder = (Get-Location).Path

    #Podívám se jestli je něco nového na serveru, a jestli nemám něco nepushnutého
    git fetch
    $status = git status -- $gitFolder
    
    #Projekt je syncnutý
    if($status -like "*Your branch is up to date*" -and $status -like "*nothing to commit*")
    {
        #Zjistím jestli poslední commit má TAG
        $gitlog = git log --pretty=oneline --decorate=short -- $gitFolder
        $lastCommit = ""
        $lastCommit = $($gitlog -split "`r`n")[0]
		
        if($lastCommit -like "*tag: *")
        {
            #Získám poslední TAG
            $tag = GetLastTag $gitlog
            $version = GetProductVersion
            if($tag -ne $version)
            {
                Write-Error "Tag a verze se neshodují !"
                exit 3
            }
        }
        else
        {
            Write-Error "Není nastaven tag na commitu !"
            exit 2
        }
    }
    else
    {
        Write-Error "Projekt není synchronizovaný !"
        exit 1
    }
}
