# uncomment zmodload zsh/zprof and zprof at the bottom to check load times.
#zmodload zsh/zprof
# TO RELOAD THIS FILE:
# omz reload
#
#
#
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH=/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH
export PATH=/opt/homebrew/opt/findutils/libexec/gnubin:$PATH
export PATH=/opt/homebrew/bin:$PATH
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export PATH="$PATH:$HOME/.composer/vendor/bin"
export LESS="-IRN --incsearch"
export RIPGREP_CONFIG_PATH="$HOME/.dotfiles/ripgrep/.ripgreprc"

#kubectl binary plugin
export USE_GKE_GCLOUD_AUTH_PLUGIN=true

# Path to your oh-my-zsh installation.
export ZSH="/Users/wexokk/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
 HIST_STAMPS="dd/mm/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

###################---NVM---#############################
export NVM_DIR="$HOME/.nvm"
export NVM_COMPLETION=true
export NVM_LAZY_LOAD=true

# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
###################///NVM\\\#############################

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

###################---PLUGINS---#############################
plugins=(zsh-nvm git zsh-syntax-highlighting zsh-autosuggestions)
#plugins+=(zsh-vi-mode)
###################///PLUGINS\\\#############################

## don't escape urls when pasted in the terminal
DISABLE_MAGIC_FUNCTIONS=true
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias ll='lsd -lha'
alias ls='lsd --group-dirs first'
alias fpm="wexo enter php"
alias ddb="wexo enter db"
alias vpnup="wg-quick up wg0"
alias vpndown="wg-quick down wg0"
alias gs="git status"
alias sail='[ -f sail ] && bash sail || bash vendor/bin/sail'
alias vim='nvim'
alias vi='nvim'
alias t='tmux'
alias odf='vim ~/.dotfiles'
alias wcm='wexocommit'
alias wgb='git branch | fzf | xargs git checkout'
alias wso='wexo stop'
alias wsa='wexo start'


setopt HIST_IGNORE_ALL_DUPS
setopt HIST_EXPIRE_DUPS_FIRST

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

autoload -U compinit && compinit -u
#export PATH="/opt/homebrew/opt/php@8.0/bin:$PATH"
export PATH="/opt/homebrew/opt/php@7.4/sbin:$PATH"


export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/bin/scripts

# Update PATH for Google Cloud SDK.
if [ -f '/Users/wexokk/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/wexokk/google-cloud-sdk/path.zsh.inc'; fi

# Enabled shell completion for gcloud.
if [ -f '/Users/wexokk/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/wexokk/google-cloud-sdk/completion.zsh.inc'; fi
[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# keybind
bindkey -r "^L"
bindkey '^ ' autosuggest-execute
bindkey '^P' up-line-or-beginning-search
bindkey '^N' down-line-or-beginning-search
#bindkey '^P' up-line-or-search
#bindkey '^N' down-line-or-search

source ~/.zsh_profile
# zprof
