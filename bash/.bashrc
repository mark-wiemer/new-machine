# Mark's .bashrc
# Comments limited to 80 columns, please

# Use `__git_ps1` for branchname printing through git alias
# https://stackoverflow.com/a/24716445
source /etc/profile.d/git-prompt.sh

#* Ad-hoc
alias update='cd ~/myStuff/games/Luanti/games/lanterns_flame && git pull'
alias ulf='cd ~/myStuff/repos/luanti/lanterns_flame && gpn && update && cd ~/myStuff/repos/luanti/lanterns_flame'

#* Scripts
alias bashedit='"C:\\Program Files\\VSCodium\\VSCodium.exe" ~/.bashrc'
alias bs='npm run build && npm start'
alias brd='bun run dev'
# Git Commit All with Message
alias gcam='git add . && git commit -m $!'
# Git Checkout Main, Pull, New branch
alias gcmpn='git stash && git checkout main && git pull && git new $1'
# Git Diff main Shortstat
alias gds='git diff main --shortstat'
# Delete merged local branches
alias gitdelete='git branch --merged | egrep -v "(^\*|main)" | xargs git branch -d'
# Git Push New branch, works for existing branches as well
alias gpn='git push --set-upstream origin $(__git_ps1 "%s")'
# Git Pull and merge Main
alias gpm='b=$(__git_ps1 "%s") && git checkout main && git pull && git checkout $b && git merge main'
# Git Pull and merge Upstream Main with Ours merge strategy
alias gpumo='b=$(__git_ps1 "%s") && git checkout upstream-main && git pull && git checkout $b && git merge upstream-main -X ours'
alias gsur='git submodule update --remote'
# npm Install with Legacy peer deps
alias npmil='npm i --legacy-peer-deps'
# npm install with version 6, then revert back to version 8
alias npmi6='npm install npm@^6 --global && npm i && npm install npm@^8 --global'
# Create a PR branch to review changes locally
alias pr='git status && git branch -D pr; git checkout -b pr && git reset main'
# Source Bash Run Commands
alias sbrc='source ~/.bashrc'
# Validate CI fix
alias vcf='npm run validate:ci:fix'

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

# fnm
FNM_PATH="/c/Users/markw/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi

# Every time the user enters a command, print date and call `timer_start`
# Do the trap last so we don't have excessive commands being run while sourcing
trap 'date +"%F %T" && timer_start' DEBUG

# RedwoodJS Grove
# grove.dev
export GROVE_INSTALL="/home/markwiemer/.grove"
export PATH="$GROVE_INSTALL/bin:$PATH"
