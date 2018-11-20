
git fetch
$status = git status

if($status -like "*Your branch is up to date*" -and $status -like "*nothing to commit*")
{
    write-host Update
}
else
{
    write-host
    exit 1
}
