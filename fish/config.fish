set GEM_ROOT /usr/lib/ruby/3.0.0
set -g fish_greeting
if status is-interactive
    set -x GPG_TTY $(tty)
    set -x SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket
    set -gx SSH_ASKPASS /usr/lib/ssh/gnome-ssh-askpass3
		ssh-add
		clear
		neofetch
end
fish_add_path /home/felix/.spicetify

alias ls "colorls"
