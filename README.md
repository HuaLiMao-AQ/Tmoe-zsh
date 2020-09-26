# Tmoe-zsh 介绍

```bash
. <(curl -L gitee.com/mo2/zsh/raw/2/2)
```

> 为 GNU/Linux 和 Android-Termux 配置数百个 zsh 主题和插件。  
> **Easily configure zsh themes for GNU/Linux and Android-Termux**

## 预览 Preview

### 部分主题预览截图 Screenshot

![Capture__2020-03-24-17-29-552.png](https://gitee.com/mo2/pic_api/raw/test/2020/03/24/3luF9hHGPnPuhwHu.png)

![Snipaste_2020-03-24_17-12-57.png](https://gitee.com/mo2/pic_api/raw/test/2020/03/24/YsZou4mIXZUFUYdZ.png)

### 目前可选 200 多种主题

![Snipaste_2020-03-24_17-34-37.png](https://gitee.com/mo2/pic_api/raw/test/2020/03/24/ZSIBFuC1v3AKcTFX.png)

### 100 多种配色

![Snipaste_2020-03-24_17-16-22.png](https://gitee.com/mo2/pic_api/raw/test/2020/03/24/3JQSGux51j6Fj5cp.png)

### 近 50 种字体

![Snipaste_2020-03-24_17-20-59.png](https://gitee.com/mo2/pic_api/raw/test/2020/03/24/K9PweO1nbWok8XUh.png)

### 管理器界面预览

![86K2M8.png](https://s1.ax1x.com/2020/03/20/86K2M8.png)
![Capture__2020-03-24-17-41-46.png](https://gitee.com/mo2/pic_api/raw/test/2020/03/24/hSQuBsUxPRbjSgUM.png)

为 Linux 和 Termux 配置 zsh 环境，目前支持修改 200 多种主题，100 多种配色和近 50 种字体。

基于 [zinit](https://github.com/zdharma/zinit),默认情况下，使用“Turbo Mode”延迟加载插件。

2020-03-19 更新内容：

增加了对其它 linux 系统的支持！

2020-03-24 更新内容：  
支持 Gentoo/Funtoo

2020-08-13 更新内容：  
支持管理约 283 款插件。

2020-09：基本上重写了一遍，由于更新幅度过大，故不兼容旧版。  
您可以执行以下命令，删除旧版

```shell
ZSHRC_FILE="${HOME}/.zshrc"
TMOE_ZSH_GIT_DIR="${HOME}/.config/tmoe-zsh/git"
rm -rv "${TMOE_ZSH_GIT_DIR}" "$(command -v zsh-i)"
mv "${ZSHRC_FILE}" "${ZSHRC_FILE}-$(date +%Y%m%d).bak"
```

## 2.安装说明

### 2-1.使用脚本安装

1.Android-[Termux](https://termux.com/)

```bash
    . <(curl -L gitee.com/mo2/zsh/raw/2/2)
```

2.Debian/Ubuntu/Mint/Kali

```bash
    sudo apt update
    sudo apt install -y wget
    bash -c "$(wget -qO- gitee.com/mo2/zsh/raw/2/2)"
```

3.RedHat/Fedora/CentOS

```bash
    sudo dnf install -y curl || sudo yum install -y curl
    bash -c "$(curl -L gitee.com/mo2/zsh/raw/2/2)"
```

4.Arch/Manjaro

```bash
    [[ $(command -v curl) ]] || sudo pacman -Syu curl
    bash -c "$(curl -L gitee.com/mo2/zsh/raw/2/2)"
```

5.OpenWRT/Entware(只测试了 mipsel 架构路由器的 Entware 系统)

> 202009 不再对路由器提供支持，请自行解决依赖关系。

```bash
    opkg update
    opkg install libustream-openssl ca-bundle ca-certificates wget bash
    bash -c "$(wget --no-check-certificate -qO- https://gitee.com/mo2/zsh/raw/2/2)"
```

6.Alpine/iOS-[iSH](https://ish.app/)

```bash
    sudo apk add wget bash
    wget -O /tmp/.tmoe-zsh gitee.com/mo2/zsh/raw/2/2
    bash /tmp/.tmoe-zsh
```

7.Void

```bash
    sudo xbps-install -Sy wget
    bash -c "$(wget -qO- gitee.com/mo2/zsh/raw/2/2)"
```

8.Gentoo/Funtoo

```bash
    emerge -avk net-misc/wget
    bash -c "$(wget -qO- gitee.com/mo2/zsh/raw/2/2)"
```

9.OpenSUSE

```bash
    sudo zypper in curl
    bash -c "$(curl -L gitee.com/mo2/zsh/raw/2/2)"
```

10.其它 system 未测试,以下系统请自行解决依赖关系。  
例如:**GuixSD**等发行版。  
还有 Unix 系统，例如：**MacOS、FreeBSD、OpenBSD、NetBSD**和**SunOS**等。  
相关依赖为 `zsh git pv wget tar xz newt(whiptail)`

### 2-2.MUNUALLY GIT CLONE 手动克隆

```bash
TMOE_ZSH_DIR="${HOME}/.config/tmoe-zsh"
TMOE_ZSH_GIT_DIR="${TMOE_ZSH_DIR}/git"
mkdir -p ${TMOE_ZSH_DIR}
git clone --depth=1 https://gitee.com/mo2/zsh "${TMOE_ZSH_GIT_DIR}"
bash ${TMOE_ZSH_GIT_DIR}/zsh.sh
```

使用`-h`或者`--help`参数获取帮助信息。

## 3. INSTRUCTIONS 使用说明

### 3-1.COMMAND 基本命令

**修改主题 Change theme:**
​  
​`​ zshtheme ​`

**修改配色 Change color scheme:**
​  
​`​ zshcolor ​`
​  
**修改字体 Change font:**
​  
​`​ zshfont ​`

**启动管理器 Start zsh manager:**
​  
​`​ zsh-i ​`

### 3-2. zshtheme 命令说明

![zshtheme](https://images.gitee.com/uploads/images/2020/0926/103629_85422bd6_7793225.png)

```bash
  COMMAND: zshtheme
  命令: zshtheme
  Description: This command can change the ZSH theme.
  描述: 此命令能修改ZSH主题。
  --------------
  -h      --help
  get-help-info 获取帮助信息
  --------------
  -n      --no-color
  In this mode, the theme list will have no color.
  若您安装了lolcat，则主题列表将输出五彩斑斓的颜色，而-n参数将禁用此模式。
  --------------
  -num    --number list. This is the default mode.
  If the parameter is empty, it will enter this mode.
  It is interactive, you need to type zshtheme or zshtheme -num to start this mode first, and then type the option number,finally press Enter key.
  序号列表模式。若参数为空，则将进入此模式。
  此模式为交互式操作，您可以先输zshtheme启动,接着输入数字序号。
  --------------
  NOTES of manual mode
  手动模式的说明
  You can type zshtheme $THEME_NAME to change the zsh theme.
  For example.01: If you type zshtheme agnosterzak,then zsh theme will be changed to agnosterzak.
  02:   zshtheme xiong-chiamiov-plus
  您可以输zshtheme $主题名称来修改主题。
  例如： 输入zshtheme powerlevel10k或者zshtheme p10k，将主题修改为powerlevel10k。
  --------------
  LIST OF ZSH THEMES:
  3den , abaykan , adben , af-magic , afowler , agnoster , agnosterzak , alanpeabody , amuse , aphrodite , apple , arrow , asciigit , aussiegeek , avit , avit-da2k , awesomepanda , bender , bira , blinks , blokkzh , bullet-train , bunnyruni , bureau , candy , candy-kingdom , chi , chill , classyTouch , clean , cloud , cordial , crcandy , crunch , cypher , dallas , darkblood , daveverwer , dieter , docker , dogenpunk , dpoggi , drofloh , dst , dstufft , ducula , duellj , eastwood , edvardm , elessar , emotty , enlightenment , essembeh , evan , fino , fino-time , fishy , fishy2 , flazz , fletcherm , fox , frisk , frontcube , funky , funkyberlin , fwalch , gallifrey , gallois , garyblessington , gentoo , geoffgarside , gianu , gitster , gnzh , gozilla , half-life , halil , haribo , hedgehog , humza , hyper-oh-my-zsh , hyperzsh , igorsilva , imajes , imp , imperator-root , intheloop , intika , itchy , jaischeema , jbergantine , jispwoso , jnrowe , jonathan , josh , jovial , jreese , jtriley , juanghurtado , junkfood , kafeitu , kardan , kayid , kennethreitz , kimwz , kinda-fishy , kiwi , kmac , kolo , kphoen , lambda , lambda-gitster , lambda-mod , lambda-v , linuxonly , lukerandall , macovsky , maran , maza , McQuen , mgutz , mh , michelebologna , mikeh , miloshadzic , minimal , minimal2 , minimal_improve , mira , mortalscumbag , mrtazz , murilasso , muse , nanotech , nebirhos , nicoulaj , node , nodeys , norm , nox , nt9 , nuts , obraun , odin , ohwonder , oxide , peepcode , philips , philthy , pi , pmcgee , powerlevel10k , punctual , pygmalion , pygmalion-virtualenv , rafiki , random , random-emoji , re5et , refined , reggae , rgm , risto , rixius , rkj , rkj-repos , robbyrussell , robbyrussell-WIP , sammy , shayan , simonoff , simple , skaro , sm , smt , sobole , Soliah , sonicradish , sorin , sporty_256 , staples , steeef , strug , sunaku , sunrise , superjarin , suvash , takashiyoshida , terminalparty , theunraveler , tjkirch , tjkirch_mod , tonotdo , traditional-plus , trapd00r , typewritten , vero , via , wedisagree , wezm , wezm+ , windows , wuffers , xiong-chiamiov , xiong-chiamiov-plus , xxf , ys , zeroastro , zeta , zhann
```

### 3-3. zshcolor 命令说明

![zshcolor](https://images.gitee.com/uploads/images/2020/0926/104752_29cbd46a_7793225.png)

```bash
  COMMAND: zshcolor
  命令: zshcolor
  Description: This command can change the terminal color scheme.
  描述: 此命令能修改终端配色。
  --------------
  -h      --help
  --------------
  -n      --no-color
  --------------
  -num    --number list. This is the default mode.
  If the parameter is empty, it will enter this mode.
  It is interactive, you need to type zshcolor or zshcolor -num to start this mode first, and then type the option number,finally press Enter key.
  序号列表模式。若参数为空，则将进入此模式。
  此模式为交互式操作，您可以先输zshcolor启动,接着输入数字序号。
  --------------
  NOTES of manual mode
  手动模式的说明
  You can type zshcolor $COLOR_NAME to change the terminal color scheme.
  For example.01: If you type zshcolor monokai.dark,then terminal color will be changed to monokai.dark.
  您可以输zshcolor $配色名称来修改配色。
  例如： 输入zshcolor neon，将配色修改为neon。
  --------------
  LIST OF COLOR SCHEMES:
 3024.dark // 3024.light // aci // aco // apathy.dark // apathy.light // argonaut // ashes.dark // ashes.light // atelierdune.dark // atelierdune.light // atelierforest.dark // atelierforest.light // atelierheath.dark // atelierheath.light // atelierlakeside.dark // atelierlakeside.light // atelierseaside.dark // atelierseaside.light // azu // base16.solarized.dark // base16.solarized.light // bespin.dark // bespin.light // bim // black.on.white // brewer.dark // brewer.light // bright.dark // bright.light // cai // chalk // chalk.dark // chalk.light // codeschool.dark // codeschool.light // colors.dark // colors.light // default // default.dark // default.light // dracula // eighties.dark // eighties.light // elementary // elic // elio // embers.dark // embers.light // flat // flat.dark // flat.light // freya // gnometerm // google.dark // google.light // gotham // grayscale.dark // grayscale.light // greenscreen.dark // greenscreen.light // gruvbox.dark // gruvbox.light // harmonic16.dark // harmonic16.light // hemisu.dark // hemisu.light // hybrid // isotope.dark // isotope.light // jup // londontube.dark // londontube.light // mar // marrakesh.dark // marrakesh.light // materia // material // miu // mocha.dark // mocha.light // monokai.dark // monokai.light // nancy // neon // nep // nord // ocean.dark // ocean.light // one.dark // one.light // pali // paraiso.dark // paraiso.light // peppermint // railscasts.dark // railscasts.light // rydgel // sat // shapeshifter.dark // shapeshifter.light // shel // smyck // solarized.dark // solarized.light // summerfruit.dark // summerfruit.light // tango // tin // tomorrow // tomorrow.dark // tomorrow.light // tomorrow.night // tomorrow.night.blue // tomorrow.night.bright // tomorrow.night.eighties // twilight.dark // twilight.light // ura // vag // white.on.black // wild.cherry // zenburn
```

### 3-4. PLUGINS 预装插件说明

![plugin_01](https://images.gitee.com/uploads/images/2020/0926/105252_7b96060e_7793225.png "截图_2020-09-26_10-52-43.png")  
本工具在执行初始化安装时，将预装某些插件。

```bash
________       ___      ________       ___      __________
 \_____  \     |\  \    |\   ___  \     |\  \    |\___   ___\
 \|___/  /|    \ \  \    \ \  \ \  \    \ \  \   \|___ \  \_|
     /  / /     \ \  \    \ \  \ \  \    \ \  \       \ \  \
    /  /_/__     \ \  \    \ \  \ \  \    \ \  \       \ \  \
   |\________\    \ \__\    \ \__\ \__\    \ \__\       \ \__\
    \|_______|     \|__|     \|__| \|__|     \|__|        \|__|
您可以在安装完成后，输 zsh-i进入zsh插件管理工具。
插件的加载方式基于zinit。
You can type zsh-i to start tmoe-zsh tool.
    ------------
    以下是部分插件的说明：
    插件名称PLUGIN NAME:z
    命令COMMAND:z
    若您曾访问过~/sd/Download，则您可以输"z Down"或"z load"来快速跳转，访问列表可以输"z"获取。
    ------------
    插件名称PLUGIN NAME:extract
    命令COMMAND:x
    Description: This plugin defines a function called "extract" that extracts the archive file you pass it, and it supports a wide variety of archive filetypes.

    例如某文件名为233.tar.xz，则您无需输"tar -Jxf 233.tar.xz"，只需输"x 233.tar.xz"。
    同理，若另一文件为233.7z，则您只需输入"x 233.7z"即可解压。
    注意：您在解压前必须先安装相关依赖，例如：zip需要unzip，7z需要p7zip，安装方法类似于"apt install unzip"
    -----------
    应用名称 APP NAME:exa
    命令COMMAND:exa
    alias ls=exa
    若您的系统满足依赖条件，则ls将alias为exa.
    exa是一款优秀的ls替代品,拥有更好的文件展示体验,输出结果更快,使用rust编写。
    Exa is a modern version of ls.
    输入lst,将展示类似于tree的树状列表。
    输入l,将显示当前目录的文件列表。
    -----------

```

![plugin_02](https://images.gitee.com/uploads/images/2020/0926/105611_54a9c847_7793225.png "截图_2020-09-26_10-55-48.png")

```bash
  应用名称 APP NAME:bat
    命令COMMAND:bat
    alias cat=bat
    bat是cat的替代品，支持多语言语法高亮。
    支持自动分页，对于大文本，以 less 命令输出，可使用类似 vim 的快捷键移动光标。 你可以输q退出bat的页面视图，you can type q to quit bat.
    用法示例：bat -l zsh /etc/os-release
    输入bat -L获取支持的语言
    ------------
    插件名称PLUGIN NAME:colored-man-pages
    命令COMMAND:man
    Description: man手册彩色输出 This plugin adds colors to man pages..
    输入man 软件包或命令名称获取该软件包的文档。
    用法示例：man ssh高亮显示ssh-client的文档（用户手册）。
    man bash获取bash的用户手册。
    ------------
    Other
    补全插件用法：
    输入已知命令或函数的部分字符后，按下TAB键
    You can press TAB KEY to use auto completion plugin.
    ------------
    Plugins such as extract, git ,fast-syntax-highlighting , fzf-tab and z have been configured for you. Enjoy the fun of zsh!

```

作为一款插件管理器，本工具的亮点是自动添加注释内容。

以下是`bat ~/.zshrc`输出的部分内容的截图
![bat ~/.zshrc](https://images.gitee.com/uploads/images/2020/0926/110553_bcc3c060_7793225.png "截图_2020-09-26_11-05-33.png")
因为本工具基于 zinit，所以加载命令都是用 zinit 。  
类似于如下格式

```bash
zinit ice wait lucid pick"fast-syntax-highlighting.plugin.zsh" atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" && zinit light _local/fast-syntax-highlighting    #语法高亮插件，速度比zsh-syntax-highlighting更快。(Short name F-Sy-H). Syntax-highlighting for Zshell – fine granularity, number of features, 40 work hours themes
```

## 4.相关项目

**[zdharma/zinit](https://github.com/zdharma/zinit)**  
**[romkatv/powerlevel10k](https://github.com/romkatv/powerlevel10k)**  
**[Aloxaf/fzf-tab](https://github.com/Aloxaf/fzf-tab)**  
**[zsh-users/zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)**  
**[oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)**  
**[Cabbagec/termux-ohmyzsh](https://github.com/Cabbagec/termux-ohmyzsh)**  
**[zdharma/fast-syntax-highlighting](https://github.com/zdharma/fast-syntax-highlighting)**

zsh 里面的额外主题是我从[oh-my-zsh/external-themes](https://github.com/ohmyzsh/ohmyzsh/wiki/External-themes)里介绍的 Github 仓库里一个个下载下来的，不保证全都能用。  
If you find a theme loading error, then you can submit an issue.
