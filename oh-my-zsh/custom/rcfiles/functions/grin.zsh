function bug()
{
  ticket_branch 'bug' $1 $2
}

function epic()
{
  ticket_branch 'epic' $1 $2
}

function story()
{
  ticket_branch 'story' $1 $2
}

function task()
{
  ticket_branch 'task' $1 $2
}

function revert()
{
  ticket_branch 'revert' $1 $2
}

function ticket_branch()
{
  gcb "$1/GN-$2/${3// /-}"
}

function copy_branch()
{
  gcb "$(git_current_branch)_WITH_PLATFORM_CPE"
}

function ticket_number()
{
  printf "%q" $(git_current_branch)  | sed 's/^.*GN-//g' | sed 's/\/.*$//g'
}

function git_commit_prefix()
{
  echo "[GN-$(ticket_number)] -"
}
