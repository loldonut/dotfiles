export ZSH="$HOME/.oh-my-zsh"

alias prettyjson="cat $* | jq"
alias vim="nvim"
alias live-server="live-server --no-browser"
alias rewaybar='pkill waybar && hyprctl dispatch exec waybar'
alias brave='com.brave.Browser'

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

export PATH="$PATH:/home/ric/.local/bin:/home/ric/.local/share/bob/nvim-bin"

alias vim='nvim'

export NVM_DIR="$HOME/.nvm"
