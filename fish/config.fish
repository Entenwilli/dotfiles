if status is-interactive
    set -x GPG_TTY $(tty)
    set -x SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket
end
