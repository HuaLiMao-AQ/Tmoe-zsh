# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
: <<\EOF
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
EOF
#记得取消注释
#更新p10k配置
#fortune替换ps
#配置自动同步zsh-syntax-highlighting
#neon和monokai
#konsole终端配色
#fortune
############
source ~/.zinit/bin/zinit.zsh
load_omz_lib() {
    for i in theme-and-appearance.zsh git.zsh history.zsh; do
        zinit snippet ~/.zinit/omz/lib/${i}
    done
    for i in completion.zsh key-bindings.zsh; do
        zinit ice lucid wait='1'
        zinit snippet ~/.zinit/omz/lib/${i}
    done
    unset i
}
########
load_omz_lib
ZINIT_THEME_DIR="${HOME}/.zinit/themes/_local"
#skip_global_compinit=1
##THEME
#theme-and-appearance的加载顺序要先于主题
#zinit snippet ~/.zinit/omz/themes/ys.zsh-theme
#source ~/.zinit/omz/oh-my-zsh.sh
zinit ice pick"powerlevel10k.zsh-theme" && zinit light ${ZINIT_THEME_DIR}/powerlevel10k
#######
zinit ice lucid wait='1' && zinit light _local/extract
zinit ice lucid as"completion" wait='1' && zinit snippet ~/.zinit/omz/plugins/extract/_extract
#########
zinit ice lucid wait='1' && zinit light _local/z && unsetopt BG_NICE
########
zinit ice lucid pick"git.plugin.zsh" wait='1' && zinit snippet _local/git
##########
[[ ! $(command -v fzf) ]] || zinit light _local/fzf-tab
##########
[[ -e /usr/lib/command-not-found ]] && zinit ice lucid wait='0' && zinit light _local/command-not-found
#zinit snippet ~/.zinit/omz/plugins/command-not-found/command-not-found.plugin.zsh

#zinit ice wait='2' lucid pick"zsh-syntax-highlighting.zsh"
#zinit light _local/zsh-syntax-highlighting
# ~/.zinit/omz/custom/plugins/zsh-syntax-highlighting/

zinit ice lucid wait='3' && zinit light _local/colored-man-pages

zinit ice wait lucid atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" && zinit light _local/fast-syntax-highlighting

zinit ice wait lucid pick"zsh-autosuggestions.zsh" atload'_zsh_autosuggest_start' && zinit light _local/zsh-autosuggestions

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
#######
#ALIAS
alias ...=../..
alias ....=../../..
alias .....=../../../..
alias ......=../../../../..
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'
alias _='sudo '
alias afind='ack -il'
alias egrep='egrep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
alias fgrep='fgrep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
alias gc1='git clone --recursive --depth=1'
alias globurl='noglob urlglobber '
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'
alias md='mkdir -p'
alias rd=rmdir
#######
if [ $(command -v exa) ]; then
    DISABLE_LS_COLORS=true
    alias ls="exa -b --color=auto"
    alias l='exa -lbah'
    alias la='exa -lbahgR'
    alias ll='exa -lbgh'
    alias lsa='exa -labgh'
    alias lst='exa -lTabgh'
else
    alias ls='ls --color=auto'
    alias la='ls -lAh'
    alias ll='ls -lh'
    alias lsa='ls -lah'
fi
[[ ! $(command -v tmoe) ]] || alias t=tmoe
######
if [ $(command -v batcat) ]; then
    alias cat='batcat'
elif [ -e /bin/bat ]; then
    alias cat='/bin/bat'
elif [ -e /usr/local/bin/bat ]; then
    alias cat='/usr/local/bin/bat'
fi
######
#compaudit
autoload -Uz compinit
compinit
zinit cdreplay -q
#zinit times
#########
