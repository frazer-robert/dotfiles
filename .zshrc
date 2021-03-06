if [ "$TMUX" = "" ]; then TERM=xterm-256color tmux; fi

# Turn off all beeps
unsetopt BEEP

# vim mode
bindkey -v
export KEYTIMEOUT=1

export HISTFILE=~/.zsh_history                  # set history file
setopt INC_APPEND_HISTORY                       # write to file immedieately
setopt HIST_IGNORE_ALL_DUPS                     # ignore saving duplicates to zsh history
setopt HIST_IGNORE_SPACE                        # Don't record an entry starting with a space.
HISTSIZE=10000000
SAVEHIST=10000000


export CM_DIR=~/                  # set history file

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
alias src='cd ~/src'
alias sz='source ~/.zshrc'
alias nginx.conf='vi /usr/local/etc/nginx/nginx.conf'

# shorthand aliases
alias cdf='cd $(fd -t d | fzf)'
alias fs='cd /Users/elelango/Documents/dev/freshsales'
alias mux='TERM=xterm-256color tmuxinator'
alias vi='nvim'
alias vif='vi $(fzf)'
alias tmux='TERM=xterm-256color tmux'
alias vic='vi --clean'

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
alias grh='git reset --hard'
alias gcl='git clean -fd'
alias gbs='git clean -f; git reset --hard; git cherry-pick -n bs; git reset;'
alias rmerge='git merge staging; git push -u origin HEAD;'

# ssh aliases
alias bastion='ssh -i ~/.ssh/id_rsa app-dev-eelangofreshworksco77197@34.199.190.215'

stage () {
  git -c color.status=always status \
    --short \
    --untracked-files=all | 
      fzf \
          --ansi \
          --reverse \
          --cycle \
          --preview-window 'right:70%' \
          --preview 'bash -c "
            if [[ {1} =~ \? ]]; then
              git diff /dev/null {-1} | delta --file-style=omit | sed 1d;
            else
              git diff HEAD -- {-1} | delta --file-style=omit | sed 1d;
            fi
          "' \
          --bind 'ctrl-s:execute-silent($HOME/.config/nvim/gst.sh {1} {2})+reload(git -c color.status=always status --short --untracked-files=all)' \
          --bind 'ctrl-x:execute-silent($HOME/.config/nvim/grm.sh {1} {2})+reload(git -c color.status=always status --short --untracked-files=all)' \
          --bind 'ctrl-c:execute(git commit)+reload(git -c color.status=always status --short --untracked-files=all)'
}

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
export PATH="$HOME/git-fuzzy/bin:$PATH"

# enable fzf autocomplete feature
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# shims for lazy-loading
nvm () {
  unfunction "$0"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
  nvm "$@"
}

rbenv () {
  unfunction "$0"
  eval "$(command rbenv init -)"
  rbenv "$@"
}

rails () {
  unfunction "$0"
  rbenv
  rails "$@"
}

rake () {
  unfunction "$0"
  rbenv
  rake "$@"
}

bundle () {
  unfunction "$0"
  rbenv
  bundle "$@"
}

ember () {
  unfunction "$0"
  nvm
  ember "$@"
}

git () {
  unfunction "$0"
  ci
  git "$@"
}

# enable context aware completion feature
ci () {
  autoload -Uz compinit && compinit
}

# ruby playground
play () {
  cd
  tmux split-window -v
  watch -btn1 ruby play.rb;
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
