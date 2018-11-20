
git fetch
$status = git status

if($status -eq "*Your branch is up to date*" -and $status -eq "*nothing to commit*")
{
    write-host Update
}
else
{
    write-host
    exit 1
}
