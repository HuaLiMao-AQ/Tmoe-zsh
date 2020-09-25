#!/usr/bin/env bash
RED=$(printf '\033[31m')
GREEN=$(printf '\033[32m')
YELLOW=$(printf '\033[33m')
BLUE=$(printf '\033[34m')
BOLD=$(printf '\033[1m')
RESET=$(printf '\033[m')
##############
FONTS_DIR=${HOME}/.config/tmoe-zsh/fonts/fonts
TERMUX_PATH="${HOME}/.termux"
count=0

echo -e "The default font is Iosevka.\nYou can choose another one from list below."
echo "您可以在${BLUE}此列表${RESET}中选择终端${YELLOW}字体${RESET}。"
for font in $FONTS_DIR/*/{*.ttf,*.otf}; do
	font_file[count]=$font
	echo "[$count] $(echo ${font_file[count]} | awk -F'/' '{print $NF}')"
	count=$(($count + 1))
done
count=$(($count - 1))

while true; do
	read -p '请输入选项数字,并按回车键,留空不更改。Please type the option number and press Enter:' number

	if [[ -z "$number" ]]; then
		break
	elif ! [[ $number =~ ^[0-9]+$ ]]; then
		echo "Please type the right number."
	elif (($number >= 0 && $number <= $count)); then
		#eval choice=${font_name[number]}
		#cp -pfr "${choice}" "${TERMUX_PATH}/font.ttf"
		cp -fr "${font_file[number]}" "${TERMUX_PATH}/font.ttf"
		break
	else
		echo "Please type the right number."
	fi
done
echo "您可以输 ${YELLOW}zshfont${RESET}来更改${BLUE}字体${RESET}, you can type ${GREEN}zshfont${RESET} to change the ${BLUE}font${RESET}."
termux-reload-settings
