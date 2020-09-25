#!/usr/bin/env bash
#################
git_clone_termux_font_files() {
    git clone https://gitee.com/ak2/termux-fonts.git --depth=1 "${TMOE_ZSH_FONTS_PATH}"
    cd ${TMOE_ZSH_FONTS_PATH}
    tar -Jxvf fonts.tar.xz
}
###################
android_git_clone_fonts() {
    mkdir -p "${TERMUX_PATH}"
    if [ ! -d "${TMOE_ZSH_FONTS_PATH}/fonts" ]; then
        git_clone_termux_font_files
    fi
    chsh -s zsh
}
###########################################
modify_termux_color_and_font() {
    if [ ! -e "${TERMUX_KEYBOARD_FILE}" ]; then
        cp -f ${TMOE_ZSH_TERMUX_PATH}/termux.properties ${TERMUX_KEYBOARD_FILE}
    fi
    if [ ! -e "${TMOE_ZSH_TERMUX_PATH}/colors.properties" ]; then
        cp -f ${TMOE_ZSH_TERMUX_PATH}/colors.properties ${TERMUX_PATH}/colors.properties
    fi
}
###############
do_you_want_to_backup_zsh_folder() {
    cp "${HOME}/.zshrc" "${HOME}/.zshrc.bak.$(date +%Y.%m.%d-%H:%M:%S)" 2>/dev/null
    case "${LINUX_DISTRO}" in
    Android)
        check_termux_dependencies
        android_git_clone_fonts
        git_clone_tmoe_zsh
        if [ -f ${TERMUX_KEYBOARD_FILE} ]; then
            cp -f ${TERMUX_KEYBOARD_FILE} "${TERMUX_KEYBOARD_BACKUP_FILE}"
        fi
        modify_termux_color_and_font
        ;;
    *)
        check_gnu_linux_dependencies
        install_gnu_linux_dependencies
        git_clone_tmoe_zsh
        ;;
    esac
    onekey_configure_tmoe_zsh
}
################################
add_zsh_alias() {
    #外面双引号，里面单引号。
    sed -i '/alias zshcolor=/d' "${HOME}/.zshrc"
    sed -i "$ a\alias zshcolor='bash ${TMOE_ZSH_TERMUX_PATH}/colors.sh'" "${HOME}/.zshrc"
    sed -i '/alias zshfont=/d' "${HOME}/.zshrc"
    sed -i "$ a\alias zshfont='bash ${TMOE_ZSH_TERMUX_PATH}/fonts.sh'" "${HOME}/.zshrc"
    sed -i '/alias zshtheme=/d' "${HOME}/.zshrc"
    sed -i "$ a\alias zshtheme='bash ${TMOE_ZSH_TERMUX_PATH}/themes.sh'" "${HOME}/.zshrc"
    if [ -e "${HOME}/.profile" ]; then
        sed -i '/alias zshtheme=/d' "${HOME}/.profile"
        sed -i "$ a\alias zshtheme='bash ${TMOE_ZSH_TERMUX_PATH}/themes.sh'" "${HOME}/.profile"
    fi
    sed -i '/alias zsh-i=/d' "${HOME}/.zshrc"
    if [ -e "${HOME}/.bashrc" ]; then
        sed -i '/alias zsh-i=/d' "${HOME}/.bashrc"
    fi
    if [ ! -e "${PREFIX}/bin/zsh-i" ]; then
        source ${TMOE_ZSH_TOOL_DIR}/update.sh -download
    fi
}
###########
git_clone_zinit_and_omz() {
    #git clone oh-my-zsh
    mkdir -p ${ZINIT_DIR}
    cd ${ZINIT_DIR}
    if [ ! -e "bin/.git" ]; then
        rm -rv bin
        git clone --depth=1 https://gitee.com/ak2/zinit.git ${ZINIT_DIR}/bin || git clone --depth=1 git://github.com/zdharma/zinit ${ZINIT_DIR}/bin
    fi

    if [ ! -e "omz/.git" ]; then
        rm -rv omz
        git clone https://gitee.com/mirrors/oh-my-zsh.git "${OMZ_DIR}" --depth 1 || git clone --depth=1 git://github.com/ohmyzsh/ohmyzsh "${OMZ_DIR}"
    fi
    zinit_ascii
    neko_01
    if [ -f "${HOME}/.zshrc" ]; then
        if ! egrep -q '^[^#]*zinit ice lucid wait' "${HOME}/.zshrc"; then
            sed -i 's@^@#&@g' "${HOME}/.zshrc"
            sed -i "1r ${TMOE_ZSH_GIT_DIR}/config/zshrc.zsh" "${HOME}/.zshrc"
        fi
    else
        cp ${TMOE_ZSH_GIT_DIR}/.config/zshrc.zsh "${HOME}/.zshrc"
        touch ${HOME}/.zsh_history
        #cp "${OMZ_DIR}/templates/zshrc.zsh-template" "${HOME}/.zshrc" || wget -O "${HOME}/.zshrc" 'https://gitee.com/mirrors/oh-my-zsh/raw/master/templates/zshrc.zsh-template'
    fi
    ZSH_PATH=''
    for i in ${ZINIT_DIR} ${HOME}/.zshrc ${TMOE_ZSH_GIT_DIR} ${HOME}/.zsh_history; do
        CURRENT_USER_ZSH_FILE_PERMISSION=$(ls -l ${i} | awk -F ' ' '{print $3}')
        case ${CURRENT_USER_ZSH_FILE_PERMISSION} in
        ${CURRENT_USER_NAME}) ;;
        *) ZSH_PATH="${ZSH_PATH} ${i}" ;;
        esac
    done
    unset i
    #ZSH_PATH="${ZINIT_DIR} ${HOME}/.zshrc ${TMOE_ZSH_GIT_DIR} ${HOME}/.zsh_history"
    case ${ZSH_PATH} in
    "") ;;
    *)
        echo "检测到${ZSH_PATH}文件权限所属非当前用户（${CURRENT_USER_NAME}）"
        fix_zsh_folder_permissions
        ;;
    esac
}
##########
link_omz_plugin_to_zinit() {
    #create zsh plugins目录
    #if [ ! -e "${ZINIT_DIR}/plugins/_local---colored-man-pages" ]; then
    mkdir -p "${ZINIT_DIR}/plugins"
    cd "${ZINIT_DIR}/plugins"

    cd ${OMZ_DIR}/plugins
    for i in $(ls ${PWD}); do
        if [ -d "${i}" ] && [ ! -e "${ZINIT_DIR}/plugins/_local---${i}" ]; then
            ln -sv ${PWD}/${i} ${ZINIT_DIR}/plugins/_local---${i}
        fi
    done
    #fi
}
###########
add_zinit_plugin_command_not_found() {
    sed -i 's@^.*/command-not-found@#&@g' "${HOME}/.zshrc"
    cat >>${HOME}/.zshrc <<-'EOF'
[[ -e /usr/lib/command-not-found ]] && zinit ice lucid wait='0' && zinit light _local/command-not-found
EOF
}
############
configure_command_not_found() {
    #COMMAND_NOT_FOUND_PLUGIN_DIR="${ZINIT_DIR}/plugins/_local---command-not-found"
    if [ -e "/usr/lib/command-not-found" ]; then
        case "${LINUX_DISTRO}" in
        debian)
            if ! egrep -q '^[^#]*zinit.*/command-not-found' "${HOME}/.zshrc"; then
                add_zinit_plugin_command_not_found
            fi
            case "${DEBIAN_DISTRO}" in
            ubuntu) ;;
            *)
                case $(id -u) in
                0)
                    apt-file update 2>/dev/null
                    update-command-not-found 2>/dev/null
                    ;;
                *)
                    sudo apt-file update 2>/dev/null
                    sudo update-command-not-found 2>/dev/null
                    ;;
                esac
                ;;
            esac
            ;;
        esac
    fi
}
############
add_zinit_plugin_fzf_tab() {
    sed -i 's@^.*/fzf-tab@#&@g' "${HOME}/.zshrc"
    cat >>${HOME}/.zshrc <<-'EOF'
[[ ! $(command -v fzf) ]] || zinit light _local/fzf-tab
EOF
}
############
git_clone_fzf_tab() {
    git clone --depth=1 https://gitee.com/mo2/fzf-tab.git "${FZF_TAB_PLUGIN_DIR}" || git clone --depth=1 git://github.com/Aloxaf/fzf-tab.git "${FZF_TAB_PLUGIN_DIR}"
    chmod 755 -R "${FZF_TAB_PLUGIN_DIR}"
    if ! egrep -q '^[^#]*zinit.*/fzf-tab' "${HOME}/.zshrc"; then
        add_zinit_plugin_fzf_tab
    fi
}
############
fzf_tab_extra_opt() {
    case "${ENABLE_FZF_TAB_EXTRA_OPT}" in
    true)
        if ! grep -q 'extract=' "${FZF_TAB_PLUGIN_DIR}/fzf-tab.zsh"; then
            cat >>"${FZF_TAB_PLUGIN_DIR}/fzf-tab.zsh" <<-'EndOFfzfTab'
							    #额外步骤
								    local extract="
								# 提取当前选择的内容
								in=\${\${\"\$(<{f})\"%\$'\0'*}#*\$'\0'}
								# 获取当前补全状态的上下文
								local -A ctxt=(\"\${(@ps:\2:)CTXT}\")
								"
								    zstyle ':fzf-tab:complete:*:*' extra-opts --preview=$extract'ls -A1 --color=always ${~ctxt[hpre]}$in 2>/dev/null'
						EndOFfzfTab
        fi
        ;;
    esac
}
################
configure_zinit_plugin_fzf_tab() {
    FZF_TAB_PLUGIN_DIR="${ZINIT_DIR}/plugins/_local---fzf-tab"
    ENABLE_FZF_TAB_EXTRA_OPT='true'
    if grep -Eq 'buster|stretch|jessie|Bionic Beaver|Xenial|Cosmic|Disco' "/etc/os-release" 2>/dev/null; then
        ENABLE_FZF_TAB_EXTRA_OPT='false'
    fi
    case ${TMOE_PROOT} in
    true) ENABLE_FZF_TAB_EXTRA_OPT='false' ;;
    esac
    case ${TMOE_CHROOT} in
    true | false) ENABLE_FZF_TAB_EXTRA_OPT='false' ;;
    esac

    case "${LINUX_DISTRO}" in
    Android | debian) ;;
    *) ENABLE_FZF_TAB_EXTRA_OPT='false' ;;
    esac

    if [ $(command -v fzf) ]; then
        if [ ! -d "${FZF_TAB_PLUGIN_DIR}/.git" ]; then
            git_clone_fzf_tab
            fzf_tab_extra_opt
        fi
    fi
}
############
add_zinit_plugin_fast_syntax_highlighting() {
    sed -i 's@^.*/fast-syntax-highlighting@#&@g' "${HOME}/.zshrc"
    cat >>${HOME}/.zshrc <<-'EOF'
zinit ice wait lucid atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" && zinit light _local/fast-syntax-highlighting
EOF
}
#########
git_clone_fast_syntax_highlighting() {
    if [ ! -d "${FAST_SYNTAX_HIGH_LIGHTING_PLUGIN_DIR}/.git" ]; then
        echo '正在克隆zsh语法高亮插件fast-syntax-highlighting...'
        echo "${YELLOW}github.com/zdharma/fast-syntax-highlighting${RESET}"
        #sed -i '/fast-syntax-highlighting.zsh/d' "${HOME}/.zshrc"
        git clone --depth=1 https://gitee.com/mo2/fast-syntax-highlighting.git ${FAST_SYNTAX_HIGH_LIGHTING_PLUGIN_DIR} || git clone --depth=1 git://github.com/zdharma/fast-syntax-highlighting ${FAST_SYNTAX_HIGH_LIGHTING_PLUGIN_DIR}
        chmod 755 -R "${FAST_SYNTAX_HIGH_LIGHTING_PLUGIN_DIR}"
    fi

    if ! egrep -q '^[^#]*zinit.*/fast-syntax-highlighting' "${HOME}/.zshrc"; then
        add_zinit_plugin_fast_syntax_highlighting
    fi
}
###########
add_zinit_plugin_zsh_autosuggestions() {
    sed -i 's@^.*/zsh-autosuggestions@#&@g' "${HOME}/.zshrc"
    #zinit ice pick"zsh-autosuggestions.zsh"
    cat >>${HOME}/.zshrc <<-'EOF'
zinit ice wait lucid atload"_zsh_autosuggest_start" && zinit light _local/zsh-autosuggestions
EOF
}
##################
git_clone_zsh_autosuggestions() {
    if [ ! -d "${ZSH_AUTO_SUGGESTIONS_PLUGIN_DIR}/.git" ]; then
        echo '正在克隆zsh-autosuggestions自动建议插件...'
        echo "${YELLOW}github.com/zsh-users/zsh-autosuggestions${RESET}"
        #sed -i '/zsh-autosuggestions.zsh/d' "${HOME}/.zshrc"
        git clone --depth=1 https://gitee.com/mo2/zsh-autosuggestions.git ${ZSH_AUTO_SUGGESTIONS_PLUGIN_DIR} || git clone --depth=1 git://github.com/zsh-users/zsh-autosuggestions ${ZSH_AUTO_SUGGESTIONS_PLUGIN_DIR}
        chmod 755 -R "${ZSH_AUTO_SUGGESTIONS_PLUGIN_DIR}"
    fi
    if ! egrep -q '^[^#]*zinit.*/zsh-autosuggestions' "${HOME}/.zshrc"; then
        add_zinit_plugin_zsh_autosuggestions
    fi
}
#################
onekey_configure_tmoe_zsh() {
    git_clone_zinit_and_omz
    link_omz_plugin_to_zinit
    case "${LINUX_DISTRO}" in
    Android) ;;
    *) configure_command_not_found ;;
    esac
    #################
    add_zsh_alias
    #################
    configure_zinit_plugin_fzf_tab
    git_clone_fast_syntax_highlighting
    git_clone_zsh_autosuggestions
    #######################
    #配置完成后的提示内容。
    tips_of_tmoe_zsh_01
    ####################
    change_zsh_theme_and_termux_color
}
###########################################
tips_of_tmoe_zsh_01() {
    echo "您已安装${BOLD}zsh${RESET},之后可以单独输${YELLOW}zshtheme${RESET}来更改${BLUE}主题${RESET},${YELLOW}zshcolor${RESET} 来更改${BLUE}配色${RESET}，输 ${YELLOW}zshfont${RESET}来更改${BLUE}字体${RESET},输 ${YELLOW}zsh-i${RESET}进入zsh插件${BLUE}管理工具${RESET}。"
    echo "You have installed ${BOLD}zsh${RESET}, you can type ${GREEN}zshcolor${RESET} to change the ${BLUE}color${RESET}, type ${GREEN}zshfont${RESET} to change the ${BLUE}font${RESET}, type ${GREEN}zshtheme${RESET} to change the ${BLUE}theme${RESET},type ${GREEN}zsh-i${RESET} to start ${BLUE}tmoe-zsh tool${RESET}."
    echo "当前已为您加载了z插件，若您曾访问过/sdcard/Download，则您可以输${YELLOW}z Down${RESET}或${YELLOW}z load${RESET}来快速跳转，访问列表可以输 ${YELLOW}z ${RESET}获取。"
    echo "还为您加载了解压插件extract，例如某文件名为233.tar.xz，则您无需输${YELLOW}tar -Jxf 233.tar.xz${RESET}，只需输${YELLOW}x 233.tar.xz${RESET}。同理，若另一文件为233.7z，则您只需输入${YELLOW}x 233.7z${RESET}即可解压。"
    echo '注意：您在解压前必须先安装相关依赖，例如：zip需要unzip，7z需要p7zip，安装方法类似于apt install -y unzip'
    echo 'Plugins such as syntax highlighting, extract, and z have been configured for you. Enjoy the fun of zsh!'
}
######################
change_zsh_theme_and_termux_color() {
    cd ${CURRENT_DIR}
    case "${LINUX_DISTRO}" in
    Android)
        echo "Choose your color scheme now~"
        #echo '请选择您的配色'
        bash ${TMOE_ZSH_TERMUX_PATH}/colors.sh
        echo ''
        echo "Choose your font now~"
        #echo '请选择您的字体'
        bash ${TMOE_ZSH_TERMUX_PATH}/fonts.sh
        ;;
    esac
    echo ''
    echo "Choose your theme now~"
    #echo '请选择您的主题'
    #mkdir -p "${ZINIT_DIR}/themes/_local"
    source ${TMOE_ZSH_TERMUX_PATH}/themes.sh
}
##################
do_you_want_to_backup_zsh_folder
