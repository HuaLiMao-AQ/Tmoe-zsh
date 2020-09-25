#!/usr/bin/env bash
################
upgrade_zsh_plugins_main() {
    case "$1" in
    -download) download_tmoe_zsh ;;
    *)
        zinit_ascii
        update_command_not_found
        neko_01
        git_pull_powerlevel_10k
        #upgrade zsh plugins and tool
        #git_pull_tmoe_zsh
        git_clone_tmoe_zsh
        git_pull_oh_my_zsh
        git_pull_zinit
        upgrade_tmoe_zsh_script
        #tmoe_zsh_main_menu
        ;;
    esac
}
##############
curl_zsh_i() {
    curl -Lv -o ${PREFIX}/bin/zsh-i ${ZSH_I_URL}
}
##########
chmod_plus_x_zsh_i() {
    chmod +x .zsh-i
    sudo mv -f .zsh-i ${PREFIX}/bin/zsh-i || su -c "mv -f .zsh-i ${PREFIX}/bin/zsh-i"
}
##########
download_tmoe_zsh() {
    ZSH_I_URL="${TMOE_GIT_REPO}/raw/master/zsh.sh"
    case "${LINUX_DISTRO}" in
    Android)
        curl_zsh_i
        termux-fix-shebang ${PREFIX}/bin/zsh-i
        chmod +x ${PREFIX}/bin/zsh-i
        ;;
    alpine)
        cd /tmp
        wget -O .zsh-i ${ZSH_I_URL}
        chmod_plus_x_zsh_i
        ;;
    *)
        cd /tmp
        curl -Lv -o .zsh-i ${ZSH_I_URL}
        chmod_plus_x_zsh_i
        ;;
    esac
}
############
upgrade_tmoe_zsh_script() {
    download_tmoe_zsh
    sed -i '/alias zsh-i=/d' "${HOME}/.zshrc"
    if [ -e "${HOME}/.bashrc" ]; then
        sed -i '/alias zsh-i=/d' "${HOME}/.bashrc"
    fi
    echo "Update ${YELLOW}completed${RESET}, press ${GREEN}enter${RESET} to ${BLUE}return.${RESET}"
    echo "${YELLOW}更新完成，按回车键返回。${RESET}"
    read
    source ${PREFIX}/bin/zsh-i
}
##############
update_command_not_found() {
    if [ -e "/usr/lib/command-not-found" ]; then
        case "${LINUX_DISTRO}" in
        debian)
            grep -q 'command-not-found' "${HOME}/.zshrc" 2>/dev/null || sed -i "$ a\source ${OMZ_DIR}/plugins/command-not-found/command-not-found.plugin.zsh" "${HOME}/.zshrc"
            if ! grep -qi 'Ubuntu' '/etc/os-release'; then
                apt-file update 2>/dev/null || sudo apt-file update
                update-command-not-found 2>/dev/null || sudo update-command-not-found 2>/dev/null
            fi
            #apt update  2>/dev/null
            apt upgrade -y zsh git 2>/dev/null || sudo apt upgrade -y zsh git 2>/dev/null
            ;;
        esac
    fi
}
##############
git_pull_powerlevel_10k() {
    POWER_LEVEL_DIR="${ZINIT_THEME_DIR}/powerlevel10k"
    if [ -d "${POWER_LEVEL_DIR}" ]; then
        cd "${POWER_LEVEL_DIR}"
        tmoe_git_pull_origin_master
    fi
}
################
git_pull_zinit() {
    cd ${ZINIT_DIR}/bin
    tmoe_git_pull_origin_master
    git_pull_fast_syntax_highlighting
    git_pull_zsh_autosuggestions
}
#############
tmoe_git_pull_origin_master() {
    git reset --hard origin/master
    git pull --depth=1 origin master --allow-unrelated-histories
    case "${?}" in
    0) ;;
    *)
        git fetch --depth=2
        git reset --hard
        git pull --allow-unrelated-histories
        ;;
    esac
}
###########
git_pull_fast_syntax_highlighting() {
    cd ${FAST_SYNTAX_HIGH_LIGHTING_PLUGIN_DIR}
    tmoe_git_pull_origin_master
}
###########
git_pull_zsh_autosuggestions() {
    cd ${ZSH_AUTO_SUGGESTIONS_PLUGIN_DIR}
    tmoe_git_pull_origin_master
}
#############
git_pull_oh_my_zsh() {
    cd ${OMZ_DIR}
    git reset --hard origin/master
    git pull --depth=1 origin master --allow-unrelated-histories || echo "若oh-my-zsh更新失败，则请手动输${BLUE}zsh ${OMZ_DIR}/tools/upgrade.sh${RESET}" && zsh "${OMZ_DIR}/tools/upgrade.sh"
}
###########
upgrade_zsh_plugins_main "$@"
