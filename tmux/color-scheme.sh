#! /usr/bin/env bash

# ColorScheme
declare -a color
color=(white dark_gray gray light_purple dark_purple cyan green orange red pink yellow)
color_white='#f8f8f2'
color_dark_gray='#282a36'
color_gray='#44475a'
color_light_gray='#333333'
color_light_purple='#bd93f9'
color_dark_purple='#6272a4'
color_cyan='#8be9fd'
color_green='#50fa7b'
color_orange='#ffb86c'
color_red='#ff5555'
color_pink='#ff79c6'
color_yellow='#f1fa8c'

# get options having color scheme value
declare -a names
names=( \
  $(tmux show -g | \
    awk -v color_key="$color_key" '($1 ~ /status\-/) && ($2 ~ color_key) { print $0 }' | \
    cut -d ' ' -f 1) \
  )

# each color keys, replace option value to color value
for name in "${names[@]}"
do
  opt="$(tmux show -g $name)"

  for color_key in "${color[@]}" ;
  do
    color_value="$(eval "echo \$color_$color_key")"
    opt=${opt//$color_key/$color_value}
  done

  # set replaced option values to tmux
  eval "tmux set -g $opt"
done
