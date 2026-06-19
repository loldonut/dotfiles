set SESSIONIZER "$HOME/.config/fish/.sessionize"

set -U fish_greeting
set -g fish_color_autosuggestion 7982a9
set -gx GPG_TTY (tty)
set -gx SSH_AUTH_SOCK (gpgconf --list-dir agent-ssh-socket)
gpgconf --launch gpg-agent

alias vim="nvim"

fish_add_path $HOME/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.local/bin

source ~/.config/fish/functions/zoxide.fish

if status is-interactive
    if not set -q TMUX
        exec $SESSIONIZER
    end
end
