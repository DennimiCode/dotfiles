export TERM="xterm-256color"
export KWIN_TRIPLE_BUFFER=1
export LC_ALL=en_US.UTF-8

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(host user dir)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator vcs battery time)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm|kubens|kubectx|oc|istioctl|kogito'

# ZPlug
if [[ ! -d ~/.zplug ]];then
    git clone https://github.com/b4b4r07/zplug ~/.zplug
fi
source ~/.zplug/init.zsh

# Theme
zplug romkatv/powerlevel10k, as:theme

# Aliases plugin
zplug "robbyrussell/oh-my-zsh", as:plugin, use:"lib/*.zsh"

# Plugins
zplug "plugins/archlinux",         from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/colorize",          from:oh-my-zsh
zplug "lib/completion",            from:oh-my-zsh
zplug "lib/history",               from:oh-my-zsh
zplug "lib/key-bindings",          from:oh-my-zsh
zplug "lib/termsupport",           from:oh-my-zsh
zplug "lib/directories",           from:oh-my-zsh
zplug "plugins/git",               from:oh-my-zsh
zplug "plugins/history",           from:oh-my-zsh

zplug "zsh-users/zsh-autosuggestions"
zplug "zdharma/fast-syntax-highlighting"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-history-substring-search"
zplug "MichaelAquilina/zsh-you-should-use"
zplug check || zplug install
zplug load

# Aliases
alias nv=nvim
alias vi=nvim
alias vim=nvim
alias ai="sudo apt install"
alias aupd="sudo apt update"
alias ar="sudo apt autoremove --purge"
alias aupg="sudo apt upgrade"
alias adu="sudo apt dist-upgrade"
alias afu="sudo apt full-upgrade"
alias nupd="sudo nala update"
alias nupg="sudo nala upgrade"
alias ni="sudo nala install"
alias nr="sudo nala remove --purge"
alias nar="sudo nala autoremove --purge"
alias fu="flatpak update"
alias fin="flatpak install"
alias full-upgrade="sudo nala update && sudo nala upgrade -y && flatpak update -y"
alias ls="ls -alc --color"
alias tmux='tmux -2'

# Add some paths to PATH var
export PATH=~/.cargo/bin:$PATH
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/opt/nvim/bin

# Use NeoVim as default editor
export EDITOR="/opt/nvim/bin"
export VISUAL="/opt/nvim/bin"
export SUDO_EDITOR="/opt/nvim/bin/nvim"
