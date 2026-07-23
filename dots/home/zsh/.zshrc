export ZSH="$HOME/.oh-my-zsh"

alias vim="nvim"

ZSH_THEME="robbyrussell"

ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" "af-magic" )

plugins=(git emoji gpg-agent)

source $ZSH/oh-my-zsh.sh

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

eval "$(zoxide init --cmd cd zsh)"
eval "$(fzf --zsh)"

fpath=(~/ $fpath)

autoload -Uz compinit
compinit

export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/.spicetify:$HOME/.cargo/bin"

alias vim='nvim'

export NVM_DIR="$HOME/.nvm"
