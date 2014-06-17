ZSH=$HOME/.oh-my-zsh

DISABLE_AUTO_UPDATE="true"
DISABLE_AUTO_TITLE="true"

ZSH_THEME="eastwood"

alias bli="cd ~/ws/Blimpy"
alias sdk="bli; cd ios-sdk"
alias hh="cd ~/ws/hedgehog-ios"

plugins=(git history history-substring-search brew colored-man)

source $ZSH/oh-my-zsh.sh
export PATH=~/bin:/usr/local/bin:$PATH

# Configure Python virtualenvwrapper
export WORKON_HOME=~/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
alias workoff="deactivate"

export INFOPATH="~/info"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"
