#! /bin/zsh

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# tmux configs
ln -sf "$CURRENT_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"

# git configs
ln -sf "$CURRENT_DIR/git/.gitconfig" "$HOME/.gitconfig"

# nvim configs
if [ -f ~/.config/nvim ]
then
	rm ~/.config/nvim
fi
ln -sfn "$CURRENT_DIR/nvim" "$HOME/.config/nvim"
