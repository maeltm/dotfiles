# auto start tmux not in tmux; only via ssh connection
if command -v tmux > /dev/null; then
    if [ -z $TMUX ] && [ -n "$SSH_CLIENT" ]; then
        echo $DISPLAY
        read "?Press <ENTER> to continue."
        if tmux ls | grep -q dev; then
            exec tmux attach -t dev
        else
            exec tmux new -s dev
        fi
    fi
fi
