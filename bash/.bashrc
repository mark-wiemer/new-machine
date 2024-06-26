# Mark's .bashrc
# Comments limited to 80 columns, please

# Use `__git_ps1` for branchname printing through git alias
# https://stackoverflow.com/a/24716445
source /etc/profile.d/git-prompt.sh

alias bashedit='code ~/.bashrc'
alias bs='npm run build && npm start'
alias brd='bun run dev'
# Git Diff main Shortstat
alias gds='git diff main --shortstat'
# Delete merged local branches
alias gitdelete='git branch --merged | egrep -v "(^\*|main)" | xargs git branch -d'
# Git Push New branch, works for existing branches as well
alias gpn='git push --set-upstream origin $(__git_ps1 "%s")'
# Git Pull and Merge main
alias gpm='b=$(__git_ps1 "%s") && git checkout main && git pull && git checkout $b && git merge main'
# npm Install with Legacy peer deps
alias npmil='npm i --legacy-peer-deps'
# npm install with version 6, then revert back to version 8
alias npmi6='npm install npm@^6 --global && npm i && npm install npm@^8 --global'
# Create a PR branch to review changes locally
alias pr='git status && git branch -D pr; git checkout -b pr && git reset main'
# Source Bash Run Commands
alias sbrc='source ~/.bashrc'

# Store time in seconds for last command
# Adapted from https://stackoverflow.com/a/1862762

# set timer to current magic `SECONDS` variable
function timer_start {
  timer=${timer:-$SECONDS}
}

# update timer_show to diff between current time and last set time
function timer_stop {
  timer_show=$(($SECONDS - $timer))
  unset timer
}

# Every time the prompt is shown, call `timer_stop`
PROMPT_COMMAND=timer_stop

# PROMPT
# White "[last: {N}s]", N an integer time in seconds for last input to execute
  # N can be off by +/- 1
  # Works with multiple commands entered at once, e.g. `echo 1 && echo 2` :)
# newline
# Yellow current working directory
# Light blue git branch in parentheses
# newline
# $
PS1='[last: ${timer_show}s]\n\[\033[33m\]\w\[\033[36m\]`__git_ps1`\[\033[0m\]\n\$ '

# Every time the user enters a command, print date and call `timer_start`
# Do the trap last so we don't have excessive commands being run while sourcing
trap 'date +"%F %T" && timer_start' DEBUG
