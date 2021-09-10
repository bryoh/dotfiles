# If you come from bash you might have to change your $PATH.
#export PATH=$HOME/bin:/usr/local/bin:$PATH
export TERM='xterm-256color'

# Path to your oh-my-zsh installation.
#export ZSH="/home/nyamu01b/.oh-my-zsh"

source $HOME/dotfiles/antigen.zsh
export JAVA_HOME='/usr/lib/jvm/java-1.11.0-openjdk-amd64'
export PATH="$JAVA_HOME/bin:${PATH}:${HOME}/.local/bin/:${HOME}/.cargo/bin/:${HOME}/go/bin/"

# Import colorscheme from 'wal' asynchronously
# # &   # Run the process in the background.
# # ( ) # Hide shell job control messages.
(cat ~/.cache/wal/sequences &)
#
# # Alternative (blocks terminal for 0-3ms)
#cat ~/.cache/wal/sequences
# To add support for TTYs this line can be optionally added.
source ~/.cache/wal/colors-tty.sh
source ~/.cache/wal/colors.sh 
antigen use oh-my-zsh

#Load some bundles
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle unixorn/docker-helpers.zshplugin
antigen bundle sroze/docker-compose-zsh-plugin
antigen bundle lukechilds/zsh-better-npm-completion

# Load the theme.
#antigen theme robbyrussell
antigen theme eendroroy/alien alien
#antigen theme bhilburn/powerlevel9k powerlevel9k
antigen apply

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#export ZSH_THEME="eendroroy/alien alien"
#ZSH_THEME="robbyrussell"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
#export ZSH_THEME_RANDOM_CANDIDATES=( "powerlevel9k" "agnoster" "alien" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

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
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="ddmmyyyy"
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
#bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/nyamu01b/.zshrc'

autoload -Uz compinit
compinit
# # End of lines added by compinstall

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  docker
  docker-compose
  heroku
  postgres
  git-flow
  fzf
)
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes
source <(kubectl completion zsh)

#source $ZSH/oh-my-zsh.sh


# Enable powerline status 

#if [[ -r /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh ]]; then
	#source /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
#fi

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

# Compilation flags
# export ARCHFLAGS="-arch x86_64"
# remove windows notification sound 
unsetopt beep 
# Virtualenv
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/src
source /usr/local/bin/virtualenvwrapper.sh 
# Display 
export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0


# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias nw='tmux new-window'
alias exa='exa --sort created -rlha --git'
alias vim='nvim'
alias rn='ranger --choosedir=$HOME/rangerdir;cd "$(cat $HOME/rangerdir)"'
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias xclip='xclip -selection c'
alias dotfiles="cd ~/dotfiles"
#alias rn='nano /root/.bashrc' #no more nano, big boi tings from now 
alias rv='vi /root/.bashrc'
alias sgl='git log --oneline --pretty=format:"%an %s"'
alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias gll='git log --pretty=format:" %Creset%s% Cblue\\ %C(yellow)%an\\%C(red)%cr" --decorate --date=short'
alias glv='nvim -c GV'
alias gld='git log --ext-diff -p | cdiff -s -w 100'
alias gd='git diff | cdiff -s -w 100 '
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
#alias l='ls -CF'
#alias la='ls -A'
alias ll='exa -lhs modified --git'
alias lsd='exa -lhs modified */ --git'
alias treee="tree -L"
alias treel='tree | less'
alias skim="""sk --ansi -i -c 'rg --color=always --line-number "{}"'"""  
alias grim="nvim -c :Rg"
alias downloads='cd /mnt/c/Users/B_Nyamu/Downloads/'

# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=$HOME/.cache/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;
[ -f ~/.fzf.zsh  ] && source ~/.fzf.zsh

