# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias grep='grep --color' alias egrep='egrep --color' alias fgrep='fgrep --color'
# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/usr/local/sbin:/opt/X11/bin




# cd Finder path
# 兼容 Finder/TotalFinder、Terminal/iTerm2，兼容 Finder 处于隐藏或最小化状态
# TODO：在处理隐藏或最小化状态时没有找到合适API，实现太绕
function cd.() {
    # 检查 Finder 是否执行
    if [ "`osascript -e 'tell application "System Events" to "Finder" is in (get name of processes)'`" = "true" ]; then
        # 检查当前状态是否可以获取路径
        if [ "`osascript -e 'tell application "Finder" to get collapsed of front window' 2>/dev/null`" != "false" ]; then
            if [ "`osascript -e 'tell application "System Events" to "TotalFinderCrashWatcher" is in (get name of processes)'`" = "true" ];then
                # 隐藏TotalFinder(最小化（commond+m）报错)
                open .
                osascript -e 'tell application "System Events" to tell process "Finder" to keystroke "w" using {command down}' -e 'tell application "System Events" to tell process "Finder" to keystroke "h" using {command down}'
            else
                # 最小化Finder(隐藏状态(commond+h) 报错)
                finderState=`osascript -e 'tell application "System Events" to set visible of application process "Finder" to true' -e 'tell application "Finder" to set collapsed of front window to true' 2>/dev/null`
            fi
        fi
        finder=`osascript -e 'tell application "Finder" to set curName to (POSIX path of (target of front window as alias))' 2>/dev/null`
        # 检查返回值是否为空字符串
        if [ -z "$finder" ]; then
            echo "Failed to find \"Finder\""
        else
            echo "$finder"
            cd "$finder"
        fi
    else
        echo "\"Finder\" is not running"
    fi
    }
PATH=$HOME/bin:/usr/local/share/npm/bin:$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# 路径别名
hash -d st2cfg="$HOME/Library/Application Support/Sublime Text 2"
hash -d st3cfg="$HOME/Library/Application Support/Sublime Text 3"
hash -d nginx="/usr/local/opt/nginx"
hash -d ngetc="/usr/local/etc/nginx"

# man 命令彩色提示
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
