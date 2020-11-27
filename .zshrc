if [ "$TMUX" = "" ]; then TERM=xterm-256color tmux; fi

# Turn off all beeps
unsetopt BEEP

# vim mode
bindkey -v
export KEYTIMEOUT=1

# set history file
export HISTFILE=~/.zsh_history
# ignore saving duplicates to zsh history
setopt HIST_IGNORE_ALL_DUPS

# set default pager
export PAGER=less

# open config/files aliases
alias alacritty='vi ~/.alacritty.yml'
alias delta.conf='vi ~/.delta.conf'
alias gitconfig='vi ~/.gitconfig'
alias il='vi ~/.config/nvim/init.lua'
alias iv='vi ~/.config/nvim/init.vim'
alias note='cd ~/notes/; vi'
alias info='cd ~/info/; vi'
alias tmux.conf='vi ~/.tmux.conf'
alias zshrc='vi ~/.zshrc'

# shorthand aliases
alias cdf='cd $(fd -t d | fzf)'
alias fs='cd /Users/elelango/Documents/dev/freshsales'
alias mux='tmuxinator'
alias vi='nvim'
alias vif='vi $(fzf)'
alias tmux='TERM=xterm-256color tmux'

# cargo aliases
alias cru='cargo run'
alias cch='cargo check'
alias cte='cargo test'

# git aliases
alias gc='git commit'
alias gcos='git checkout origin/staging' 
alias gcs='git checkout staging'
alias gd='git diff'
alias gdh='git diff HEAD'
alias gl='git pull'
alias glo='git pull origin'
alias glos='git pull origin staging'
alias gp='git push'
alias gpo='git push origin'
alias grf='git checkout origin/staging $(fzf)' 
alias gs='git stash --include-untracked'
alias gsp='git stash pop'
alias gst='git status'

# dotfiles bare repo alises
alias df='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# default editor
export EDITOR="nvim"
export VISUAL="nvim"

# language environment
export EDITOR='nvim'
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# export mysql@5.7.28
export PATH="/usr/local/mysql/bin:$PATH"

# make fzf use output of rg --files
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
export NVM_DIR="$HOME/.nvm"
export JAVA_HOME="/usr/libexec/java_home -v 1.8.0_192"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="/usr/local/opt/llvm/bin:$PATH"

# enable fzf autocomplete feature
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# shims for lazy-loading
nvm() {
  unfunction "$0"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
  nvm "$@"
}

rbenv() {
  unfunction "$0"
  eval "$(command rbenv init -)"
  rbenv "$@"
}

rails() {
  unfunction "$0"
  rbenv
  rails "$@"
}

rake() {
  unfunction "$0"
  rbenv
  rake "$@"
}

bundle() {
  unfunction "$0"
  rbenv
  bundle "$@"
}

ember() {
  unfunction "$0"
  nvm
  ember "$@"
}

git() {
  unfunction "$0"
  ci
  git "$@"
}

# enable completion feature
ci() {
  autoload -Uz compinit && compinit
}

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '(%b) '

# set prompt style
setopt PROMPT_SUBST
PROMPT='%(?.%F{green}.%F{red})$%f%F{magenta} %1~%f %F{cyan}${vcs_info_msg_0_}%f'

# auto suggestions plugin
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# syntax highlighting plugin
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
