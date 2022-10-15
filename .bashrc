# Mark's .bashrc
# Comments limited to 80 columns, please

# Use `__git_ps1` for branchname printing through git alias
# https://stackoverflow.com/a/24716445
source /etc/profile.d/git-prompt.sh

alias bashedit='code ~/.bashrc'
alias bs='npm run build && npm start'
# Delete merged local branches
alias gitdelete='git branch --merged | egrep -v "(^\*|main)" | xargs git branch -d'
# Git Push New branch, works for existing branches as well
alias gpn='git push --set-upstream origin $(__git_ps1 "%s")'
# Create a PR branch to review changes locally
alias pr='git status && git branch -D pr && git checkout -b pr && git reset main'
# Source Bash Run Commands
alias sbrc='source ~/.bashrc'

# Aliases for autohotkey-scripts repo. Should be moved out of this file, :shrug:
# Stash and pop all autohotkey-scripts changes in all submodules
# Go from bottom up to be safe, I'm not comfortable with submodules yet
alias stash='cd ~/source/repos/autohotkey-scripts/lib/Chrome.ahk/lib/AutoHotkey-JSON && git stash && cd ../WebSocket.ahk && git stash && cd ../.. && git stash && cd ../.. && git stash'
alias pop='cd ~/source/repos/autohotkey-scripts/lib/Chrome.ahk/lib/AutoHotkey-JSON && git stash pop; cd ../WebSocket.ahk && git stash pop; cd ../.. && git stash pop; cd ../.. && git stash pop'
# Checkout branches for different versions of AHK
alias v1='cd ~/source/repos/autohotkey-scripts && git co main && git pull'
alias v2='cd ~/source/repos/autohotkey-scripts && git co v2 && git pull'

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
# Yellow current working directory
# Light blue git branch in parentheses
# newline
# White "[last: {N}s]", N an integer time in seconds for last command to execute
  # N can be off by +/- 1
PS1='\[\033[33m\]\w\[\033[36m\]`__git_ps1`\[\033[0m\]\n[last: ${timer_show}s] \$ '

# Every time the user enters a command, print date and call `timer_start`
# Do the trap last so we don't have excessive commands being run while sourcing
trap 'date +"%F %T" && timer_start' DEBUG