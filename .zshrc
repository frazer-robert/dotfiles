# if [ "$TMUX" = "" ]; then tmux; fi

# Turn off all beeps
unsetopt BEEP

bindkey -v
export KEYTIMEOUT=1

# User configuration

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

export EDITOR="nvim"
export VISUAL="nvim"

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '(%b) '

setopt PROMPT_SUBST
PROMPT='%F{magenta}$ %1~%f %F{cyan}${vcs_info_msg_0_}%f'

# enable fzf autocomplete feature

# make fzf use output of rg --files
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
export NVM_DIR="$HOME/.nvm"
export JAVA_HOME="/usr/libexec/java_home -v 1.8.0_192"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="/usr/local/opt/llvm/bin:$PATH"

# use fzf for history search
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
