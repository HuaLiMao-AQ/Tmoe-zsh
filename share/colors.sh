#!/usr/bin/env bash
#/data/data/com.termux/files/usr/bin/bash
RED=$(printf '\033[31m')
GREEN=$(printf '\033[32m')
YELLOW=$(printf '\033[33m')
BLUE=$(printf '\033[34m')
BOLD=$(printf '\033[1m')
RESET=$(printf '\033[m')
###############
TERMUX_COLOR_FILE="${HOME}/.termux/colors.properties"
COLORS_DIR=${HOME}/.config/tmoe-zsh/git/.termux/colors
count=0

echo -e "The default color scheme is monokai dark.\nYou can choose another one from the list below"
echo "您可以在${BLUE}此列表${RESET}中选择终端${YELLOW}配色${RESET}。"
for colors in "${COLORS_DIR}"/*; do
  colors_name[count]=$(echo $colors | awk -F'/' '{print $NF}')
  echo -e "($count) ${colors_name[count]}"
  count=$(($count + 1))
done
count=$(($count - 1))

while true; do
  read -p '请输入选项数字,并按回车键,留空不更改。Please type the option number and press Enter:' number
  if [[ -z "$number" ]]; then
    break
  elif ! [[ $number =~ ^[0-9]+$ ]]; then
    echo "Please type the right number!"
  elif (($number >= 0 && $number <= $count)); then
    eval choice=${colors_name[number]}
    cp -rf "${COLORS_DIR}/${choice}" "${TERMUX_COLOR_FILE}"
    break
  else
    echo "Please type the right number!"
  fi
done

echo "您可以输${YELLOW}zshcolor${RESET} 来更改${BLUE}配色${RESET},you can type ${GREEN}zshcolor${RESET} to change the ${BLUE}color${RESET}."
termux-reload-settings
