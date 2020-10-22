# if [ "$TMUX" = "" ]; then tmux; fi
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Turn off all beeps
unsetopt BEEP

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"
# ZSH_THEME=powerlevel10k/powerlevel10k

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

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
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
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
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export EDITOR='nvim'
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# export mysql@5.7.28
export PATH="/usr/local/mysql/bin:$PATH"

# aliases
alias alacritty='vi ~/.alacritty.yml'
alias delta.conf='vi ~/.delta.conf'
alias df='dotfiles' 
alias fs='cd /Users/elelango/Documents/dev/freshsales'
alias gitconfig='vi ~/.gitconfig'
alias il='vi ~/.config/nvim/init.lua'
alias iv='vi ~/.config/nvim/init.vim'
alias mux='tmuxinator'
alias note='cd ~/.notes && vi'
alias pii='vi ~/.pii/pii.md'
alias tmux.conf='vi ~/.tmux.conf'
alias vi='nvim'
alias vif='vi $(fzf)'
alias zshrc='vi ~/.zshrc'

alias cdf='cd $(fd -t d | fzf)'

# git aliases
alias gcs='git checkout staging'
alias gcos='git checkout origin/staging' 
alias grf='git checkout origin/staging $(fzf)' 
alias gl='git pull'
alias glo='git pull origin'
alias glos='git pull origin staging'
alias gp='git push'
alias gpo='git push origin'
alias gs='git stash --include-untracked'
alias gsp='git stash pop'
alias gst='git status'
alias gd='git diff'
alias gc='git commit'

# .files repo alises
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# alacritty required screen-256 and overrides xterm
alias tmux='TERM=xterm-256color tmux'

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#hide hostname
export DEFAULT_USER="$(whoami)"
# enable fzf autocomplete feature
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# make fzf use output of fd as default to ignore unwanted dirs
# export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

# make fzf use output of rg --files
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR="/Users/elelango/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
# export LDFLAGS="-L/usr/local/opt/mysql@5.7/lib"
# export CPPFLAGS="-I/usr/local/opt/mysql@5.7/include"
# export PKG_CONFIG_PATH="/usr/local/opt/mysql@5.7/lib/pkgconfig"
# export PATH=${PATH}:/usr/local/mysql/bin/
export JAVA_HOME="/usr/libexec/java_home -v 1.8.0_192"
# export CLASSPATH="/Users/elelango/lox/lox"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/.rvm/bin"
# export PATH="$HOME/local/ruby-2.3.7/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
if command -v rbenv &> /dev/null
then
  eval "$(rbenv init -)"
fi

export PATH="/usr/local/opt/llvm/bin:$PATH"
export PATH="/Users/elelango/ccls/Release:$PATH"

