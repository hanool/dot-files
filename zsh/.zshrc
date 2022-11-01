#⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽ALIAS
# tmux
alias ta="tmux attach -t $1"

# exa, ls alternative
alias ls="exa"
alias ll="exa -l --inode --header --git --no-user --no-time --icons"
alias ld="exa -l --inode --header --git --no-user --no-time --icons -d .*"

#⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽EXPORT_ENV
# Python
#export PY_DIR="$HOME/opt/homebrew/opt/python@3.10/libexec/bin"
export PY_DIR="/usr/bin"
export TMUX_TMPDIR="/private/tmp"

#⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽⎽FUNCTION
function tmux-remake-socket () {
  if [ ! $TMUX ]; then
    return
  fi

  tmux_socket_file=`echo $TMUX | awk -F, '{print $1}'`

  if [ ! -S $tmux_socket_file ]; then
    mkdir -m700 `dirname $tmux_socket_file` 2> /dev/null
    killall -SIGUSR1 tmux
  else
    echo "tmux unix domain socket exists! nothing to do."
  fi
  unset tmux_socket_file
}
