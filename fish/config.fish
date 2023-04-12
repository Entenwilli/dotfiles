set -g fish_greeting
if status is-interactive
    set -x GPG_TTY $(tty)
    set -x SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket
		ssh-add
		clear
		neofetch
end
fish_add_path /home/felix/.spicetify
