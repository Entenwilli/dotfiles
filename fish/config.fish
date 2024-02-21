set -g fish_greeting
set -g theme_date_format "+%a %H:%M"

if status is-interactive
    set -x GPG_TTY $(tty)
    set -x SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket
    set -gx SSH_ASKPASS /usr/lib/ssh/gnome-ssh-askpass3
		ssh-add
		clear
		neofetch
    alias cat "bat"
end
fish_add_path /home/felix/.spicetify
fish_add_path /home/felix/.cabal/bin
fish_add_path /home/felix/.ghcup/bin

alias ls "eza --icons"
alias ll "eza --icons -lah"
alias dmenu "rofi -dmenu"
