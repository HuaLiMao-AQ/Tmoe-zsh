#!/usr/bin/env bash
#/data/data/com.termux/files/usr/bin/bash
################
tmoe_color_main() {
  terminal_color
  tmoe_termux_color_env
  CATCAT_COLOR=false
  case "$1" in
  h | -h | help | --help | --get-help-info)
    CATCAT_COLOR=true
    get_tmoe_termux_color_help_info
    ;;
  -n | --no-color)
    get_tmoe_termux_color_help_info
    ;;
  -num | --number | "")
    get_tmoe_termux_color_help_info
    choose_termux_color
    ;;
  '3024.dark' | '3024.light' | 'aci' | 'aco' | 'apathy.dark' | 'apathy.light' | 'argonaut' | 'ashes.dark' | 'ashes.light' | 'atelierdune.dark' | 'atelierdune.light' | 'atelierforest.dark' | 'atelierforest.light' | 'atelierheath.dark' | 'atelierheath.light' | 'atelierlakeside.dark' | 'atelierlakeside.light' | 'atelierseaside.dark' | 'atelierseaside.light' | 'azu' | 'base16.solarized.dark' | 'base16.solarized.light' | 'bespin.dark' | 'bespin.light' | 'bim' | 'black.on.white' | 'brewer.dark' | 'brewer.light' | 'bright.dark' | 'bright.light' | 'cai' | 'chalk' | 'chalk.dark' | 'chalk.light' | 'codeschool.dark' | 'codeschool.light' | 'colors.dark' | 'colors.light' | 'default' | 'default.dark' | 'default.light' | 'dracula' | 'eighties.dark' | 'eighties.light' | 'elementary' | 'elic' | 'elio' | 'embers.dark' | 'embers.light' | 'flat' | 'flat.dark' | 'flat.light' | 'freya' | 'gnometerm' | 'google.dark' | 'google.light' | 'gotham' | 'grayscale.dark' | 'grayscale.light' | 'greenscreen.dark' | 'greenscreen.light' | 'gruvbox.dark' | 'gruvbox.light' | 'harmonic16.dark' | 'harmonic16.light' | 'hemisu.dark' | 'hemisu.light' | 'hybrid' | 'isotope.dark' | 'isotope.light' | 'jup' | 'londontube.dark' | 'londontube.light' | 'mar' | 'marrakesh.dark' | 'marrakesh.light' | 'materia' | 'material' | 'miu' | 'mocha.dark' | 'mocha.light' | 'monokai.dark' | 'monokai.light' | 'nancy' | 'neon' | 'nep' | 'nord' | 'ocean.dark' | 'ocean.light' | 'one.dark' | 'one.light' | 'pali' | 'paraiso.dark' | 'paraiso.light' | 'peppermint' | 'railscasts.dark' | 'railscasts.light' | 'rydgel' | 'sat' | 'shapeshifter.dark' | 'shapeshifter.light' | 'shel' | 'smyck' | 'solarized.dark' | 'solarized.light' | 'summerfruit.dark' | 'summerfruit.light' | 'tango' | 'tin' | 'tomorrow' | 'tomorrow.dark' | 'tomorrow.light' | 'tomorrow.night' | 'tomorrow.night.blue' | 'tomorrow.night.bright' | 'tomorrow.night.eighties' | 'twilight.dark' | 'twilight.light' | 'ura' | 'vag' | 'white.on.black' | 'wild.cherry' | 'zenburn') TMOE_COLOR="$1" ;;
  esac
  case_tmoe_zsh_color_scheme
}
###############
terminal_color() {
  PURPLE=$(printf '\033[0;35m')
  RED=$(printf '\033[31m')
  GREEN=$(printf '\033[32m')
  YELLOW=$(printf '\033[33m')
  BLUE=$(printf '\033[34m')
  BOLD=$(printf '\033[1m')
  RESET=$(printf '\033[m')
}
###############
case_tmoe_zsh_color_scheme() {
  case ${TMOE_COLOR} in
  "") ;;
  *)
    TMOE_TERMUX_COLOR="${TMOE_COLOR}"
    cp -rvf "${COLORS_DIR}/${TMOE_TERMUX_COLOR}" "${TERMUX_COLOR_FILE}"
    termux-reload-settings
    ;;
  esac
}
############
tmoe_termux_color_env() {
  TMOE_COLOR=''
  case $(uname -o) in
  Android) [[ -e "${HOME}/.termux" ]] || mkdir -pv ${HOME}/.termux ;;
  *)
    get_tmoe_termux_color_help_info
    printf "%s\n" "${RED}Sorry${RESET}????????????????????????GNU/Linux"
    printf "%s\n" "??????zsh-i???????????????????????????"
    printf "%s\n" "The function of changing color scheme is only suitable for termux."
    exit 1
    ;;
  esac
  TERMUX_COLOR_FILE="${HOME}/.termux/colors.properties"
  COLORS_DIR=${HOME}/.config/tmoe-zsh/git/share/colors
}
##############
get_tmoe_termux_color_help_info() {
  CATCAT=''
  for i in /bin/lolcat /usr/games/lolcat; do
    #batcat | bat)
    #[[ ! $(command -v ${i}) ]] || CATCAT=""${i}" "--language" "zsh""
    [[ ! -f ${i} ]] || CATCAT="${i}"
  done
  unset i
  case ${CATCAT} in
  "") CATCAT='cat' ;;
  esac
  case ${CATCAT_COLOR} in
  false) CATCAT='cat' ;;
  esac
  cat <<-ENDOFTMOEZSHHELP01
  ${BOLD}${YELLOW}COMMAND${RESET}${RESET}: ${GREEN}zshcolor${RESET} 
  ${BOLD}${YELLOW}??????${RESET}${RESET}: ${GREEN}zshcolor${RESET}
  ${BOLD}${YELLOW}Description${RESET}${RESET}: ${BLUE}This command can change the terminal color scheme${RESET}.
  ${BOLD}${YELLOW}??????${RESET}${RESET}: ${BLUE}??????????????????????????????${RESET}???
  --------------
  ${YELLOW}-h${RESET}      --help 
  get-help-info ??????????????????
  --------------
  ${YELLOW}-n${RESET}      --no-color
  In this mode, the color scheme list will have no color.
  ???????????????lolcat??????????????????????????????????????????????????????${YELLOW}-n${RESET}?????????${RED}??????${RESET}????????????
  --------------
  ${YELLOW}-num${RESET}    --number list. This is the default mode.
  If the parameter is empty, it will enter this mode.
  It is interactive, you need to type ${GREEN}zshcolor${RESET} or ${GREEN}zshcolor -num${RESET} to start this mode first, and then type the option number,finally press ${YELLOW}Enter${RESET} key.
  ${GREEN}????????????${RESET}???????????????????????????????????????????????????
  ?????????????????????????????????????????????${GREEN}zshcolor${RESET}??????,???????????????????????????
  --------------
  ${BOLD}${YELLOW}NOTES${RESET}${RESET} of ${GREEN}manual mode${RESET} 
  ${GREEN}????????????${RESET}???${BOLD}${YELLOW}??????${RESET}${RESET}
  You can type ${GREEN}zshcolor${RESET} ${BLUE}\$COLOR_NAME${RESET} to change the terminal color scheme.
  For example.01: If you type ${GREEN}zshcolor${RESET} ${BLUE}monokai.dark${RESET},then terminal color will be changed to ${BLUE}monokai.dark${RESET}.
  ????????????${GREEN}zshcolor${RESET} ${BLUE}\$????????????${RESET}??????????????????
  ????????? ??????${GREEN}zshcolor${RESET} ${BLUE}neon${RESET}?????????????????????${BLUE}neon${RESET}???
  --------------
  ${BOLD}${YELLOW}LIST OF COLOR SCHEMES${RESET}${RESET}:
ENDOFTMOEZSHHELP01
  ${CATCAT} <<-'ENDOFTMOEZSHHELP02'
    '3024.dark' | '3024.light' | 'aci' | 'aco' | 'apathy.dark' | 'apathy.light' | 'argonaut' | 'ashes.dark' | 'ashes.light' | 'atelierdune.dark' | 'atelierdune.light' | 'atelierforest.dark' | 'atelierforest.light' | 'atelierheath.dark' | 'atelierheath.light' | 'atelierlakeside.dark' | 'atelierlakeside.light' | 'atelierseaside.dark' | 'atelierseaside.light' | 'azu' | 'base16.solarized.dark' | 'base16.solarized.light' | 'bespin.dark' | 'bespin.light' | 'bim' | 'black.on.white' | 'brewer.dark' | 'brewer.light' | 'bright.dark' | 'bright.light' | 'cai' | 'chalk' | 'chalk.dark' | 'chalk.light' | 'codeschool.dark' | 'codeschool.light' | 'colors.dark' | 'colors.light' | 'default' | 'default.dark' | 'default.light' | 'dracula' | 'eighties.dark' | 'eighties.light' | 'elementary' | 'elic' | 'elio' | 'embers.dark' | 'embers.light' | 'flat' | 'flat.dark' | 'flat.light' | 'freya' | 'gnometerm' | 'google.dark' | 'google.light' | 'gotham' | 'grayscale.dark' | 'grayscale.light' | 'greenscreen.dark' | 'greenscreen.light' | 'gruvbox.dark' | 'gruvbox.light' | 'harmonic16.dark' | 'harmonic16.light' | 'hemisu.dark' | 'hemisu.light' | 'hybrid' | 'isotope.dark' | 'isotope.light' | 'jup' | 'londontube.dark' | 'londontube.light' | 'mar' | 'marrakesh.dark' | 'marrakesh.light' | 'materia' | 'material' | 'miu' | 'mocha.dark' | 'mocha.light' | 'monokai.dark' | 'monokai.light' | 'nancy' | 'neon' | 'nep' | 'nord' | 'ocean.dark' | 'ocean.light' | 'one.dark' | 'one.light' | 'pali' | 'paraiso.dark' | 'paraiso.light' | 'peppermint' | 'railscasts.dark' | 'railscasts.light' | 'rydgel' | 'sat' | 'shapeshifter.dark' | 'shapeshifter.light' | 'shel' | 'smyck' | 'solarized.dark' | 'solarized.light' | 'summerfruit.dark' | 'summerfruit.light' | 'tango' | 'tin' | 'tomorrow' | 'tomorrow.dark' | 'tomorrow.light' | 'tomorrow.night' | 'tomorrow.night.blue' | 'tomorrow.night.bright' | 'tomorrow.night.eighties' | 'twilight.dark' | 'twilight.light' | 'ura' | 'vag' | 'white.on.black' | 'wild.cherry' | 'zenburn'
  --------------
ENDOFTMOEZSHHELP02
}
######
select_termux_color() {
  #cat <<-ENDOFTMOEZSHHELP03
  #ENDOFTMOEZSHHELP03
  PS3="?????????${YELLOW}????????????${RESET},??????${BLUE}?????????${RESET}???\
  Please type the ${GREEN}option number${RESET} and press ${BLUE}Enter${RESET}${YELLOW}[1-123]:${RESET}"
  select TERMUX_COLOR_NAME in '3024.dark' '3024.light' 'aci' 'aco' 'apathy.dark' 'apathy.light' 'argonaut' 'ashes.dark' 'ashes.light' 'atelierdune.dark' 'atelierdune.light' 'atelierforest.dark' 'atelierforest.light' 'atelierheath.dark' 'atelierheath.light' 'atelierlakeside.dark' 'atelierlakeside.light' 'atelierseaside.dark' 'atelierseaside.light' 'azu' 'base16.solarized.dark' 'base16.solarized.light' 'bespin.dark' 'bespin.light' 'bim' 'black.on.white' 'brewer.dark' 'brewer.light' 'bright.dark' 'bright.light' 'cai' 'chalk' 'chalk.dark' 'chalk.light' 'codeschool.dark' 'codeschool.light' 'colors.dark' 'colors.light' 'default' 'default.dark' 'default.light' 'dracula' 'eighties.dark' 'eighties.light' 'elementary' 'elic' 'elio' 'embers.dark' 'embers.light' 'flat' 'flat.dark' 'flat.light' 'freya' 'gnometerm' 'google.dark' 'google.light' 'gotham' 'grayscale.dark' 'grayscale.light' 'greenscreen.dark' 'greenscreen.light' 'gruvbox.dark' 'gruvbox.light' 'harmonic16.dark' 'harmonic16.light' 'hemisu.dark' 'hemisu.light' 'hybrid' 'isotope.dark' 'isotope.light' 'jup' 'londontube.dark' 'londontube.light' 'mar' 'marrakesh.dark' 'marrakesh.light' 'materia' 'material' 'miu' 'mocha.dark' 'mocha.light' 'monokai.dark' 'monokai.light' 'nancy' 'neon' 'nep' 'nord' 'ocean.dark' 'ocean.light' 'one.dark' 'one.light' 'pali' 'paraiso.dark' 'paraiso.light' 'peppermint' 'railscasts.dark' 'railscasts.light' 'rydgel' 'sat' 'shapeshifter.dark' 'shapeshifter.light' 'shel' 'smyck' 'solarized.dark' 'solarized.light' 'summerfruit.dark' 'summerfruit.light' 'tango' 'tin' 'tomorrow' 'tomorrow.dark' 'tomorrow.light' 'tomorrow.night' 'tomorrow.night.blue' 'tomorrow.night.bright' 'tomorrow.night.eighties' 'twilight.dark' 'twilight.light' 'ura' 'vag' 'white.on.black' 'wild.cherry' 'zenburn' 'skip??????'; do
    case ${TERMUX_COLOR_NAME} in
    'skip??????')
      cat <<-ENDOFTMOEZSHHELP04
      skipped.
		  ???${YELLOW}zshcolor h${RESET}?????????${BLUE}????????????????????????${RESET}???
		  You can type ${GREEN}zshcolor h${RESET} to get the ${BLUE}help info of terminal color schemes${RESET}.
	ENDOFTMOEZSHHELP04
      break
      ;;
    '3024.dark' | '3024.light' | 'aci' | 'aco' | 'apathy.dark' | 'apathy.light' | 'argonaut' | 'ashes.dark' | 'ashes.light' | 'atelierdune.dark' | 'atelierdune.light' | 'atelierforest.dark' | 'atelierforest.light' | 'atelierheath.dark' | 'atelierheath.light' | 'atelierlakeside.dark' | 'atelierlakeside.light' | 'atelierseaside.dark' | 'atelierseaside.light' | 'azu' | 'base16.solarized.dark' | 'base16.solarized.light' | 'bespin.dark' | 'bespin.light' | 'bim' | 'black.on.white' | 'brewer.dark' | 'brewer.light' | 'bright.dark' | 'bright.light' | 'cai' | 'chalk' | 'chalk.dark' | 'chalk.light' | 'codeschool.dark' | 'codeschool.light' | 'colors.dark' | 'colors.light' | 'default' | 'default.dark' | 'default.light' | 'dracula' | 'eighties.dark' | 'eighties.light' | 'elementary' | 'elic' | 'elio' | 'embers.dark' | 'embers.light' | 'flat' | 'flat.dark' | 'flat.light' | 'freya' | 'gnometerm' | 'google.dark' | 'google.light' | 'gotham' | 'grayscale.dark' | 'grayscale.light' | 'greenscreen.dark' | 'greenscreen.light' | 'gruvbox.dark' | 'gruvbox.light' | 'harmonic16.dark' | 'harmonic16.light' | 'hemisu.dark' | 'hemisu.light' | 'hybrid' | 'isotope.dark' | 'isotope.light' | 'jup' | 'londontube.dark' | 'londontube.light' | 'mar' | 'marrakesh.dark' | 'marrakesh.light' | 'materia' | 'material' | 'miu' | 'mocha.dark' | 'mocha.light' | 'monokai.dark' | 'monokai.light' | 'nancy' | 'neon' | 'nep' | 'nord' | 'ocean.dark' | 'ocean.light' | 'one.dark' | 'one.light' | 'pali' | 'paraiso.dark' | 'paraiso.light' | 'peppermint' | 'railscasts.dark' | 'railscasts.light' | 'rydgel' | 'sat' | 'shapeshifter.dark' | 'shapeshifter.light' | 'shel' | 'smyck' | 'solarized.dark' | 'solarized.light' | 'summerfruit.dark' | 'summerfruit.light' | 'tango' | 'tin' | 'tomorrow' | 'tomorrow.dark' | 'tomorrow.light' | 'tomorrow.night' | 'tomorrow.night.blue' | 'tomorrow.night.bright' | 'tomorrow.night.eighties' | 'twilight.dark' | 'twilight.light' | 'ura' | 'vag' | 'white.on.black' | 'wild.cherry' | 'zenburn')
      printf "%s\n" "${BLUE}${TERMUX_COLOR_NAME}${RESET}"
      cp -rvf "${COLORS_DIR}/${TERMUX_COLOR_NAME}" "${TERMUX_COLOR_FILE}"
      break
      ;;
    *)
      printf '%s\n' "${BOLD}--------------${RESET}"
      printf "%s\n" "Please ${BLUE}type${RESET} the right ${BOLD}${RED}pure number${RESET}${RESET}!"
      printf "%s\n" "???${BLUE}??????${RESET}?????????${BOLD}${RED}?????????${RESET}${RESET}!"
      ;;
    esac
  done
}
############
choose_termux_color() {
  printf "%s\n" "The ${YELLOW}default color scheme${RESET} is ${PURPLE}monokai dark${RESET}."
  printf "%s\n" "You can choose ${GREEN}another one${RESET} from ${BLUE}list below${RESET}."
  printf "%s\n" "????????????${BLUE}?????????${RESET}???????????????${YELLOW}??????${RESET}???"
  select_termux_color
  #printf "%s\n"  "????????????${YELLOW}zshcolor${RESET} ?????????${BLUE}??????${RESET},you can type ${GREEN}zshcolor${RESET} to change the ${BLUE}color${RESET}."
  termux-reload-settings
}
##############
tmoe_color_main "$@"
