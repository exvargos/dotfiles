if [ -f "~/.tmux.conf" ]; then
    rm ~/.tmux.conf
fi

ln -s tmux.conf ~/.tmux.conf
