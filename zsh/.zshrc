# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
#(cat ~/.cache/wal/sequences &)
#
# # Alternative (blocks terminal for 0-3ms)
#cat ~/.cache/wal/sequences
# To add support for TTYs this line can be optionally added.
#source ~/.cache/wal/colors-tty.sh
#source ~/.cache/wal/colors.sh 
antigen use oh-my-zsh

#Load some bundles
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle docker-compose
antigen bundle fzf
antigen bundle unixorn/docker-helpers.zshplugin
antigen bundle sroze/docker-compose-zsh-plugin
antigen bundle lukechilds/zsh-better-npm-completion
antigen theme romkatv/powerlevel10k
antigen bundle 'wfxr/forgit'
antigen bundle unixorn/fzf-zsh-plugin@main
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions


# Load the theme.
#antigen theme robbyrussell
#antigen theme eendroroy/alien alien
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
 export UPDATE_ZSH_DAYS=1

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
  #git-flow
  #fzf
  ag
  autoupdate
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
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
source /usr/local/bin/virtualenvwrapper.sh 
# Display 
export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0

export FZF_DEFAULT_OPTS="--extended --cycle --bind=alt-j:preview-down --bind=alt-k:preview-up"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias nw='tmux new-window'
alias bb='alias | fzf'
#alias exa='exa --sort created -lha --git'
#alias vim='nvim'
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
alias gld='git log --ext-diff -p . | cdiff -s'
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
#alias cat='bat'
alias compare_develop='git diff $(git_develop_branch)...$(git_current_branch ) | cdiff -s'
#alias python=/usr/local/bin/python3.7
#alias pip=/usr/local/bin/pip3

alias domino_docker_bash_local="docker container exec --workdir=/home/brian/ax-livia/test -u root -it $(docker ps -q -f name='regression-local-run') "
alias domino_docker_bash="docker container exec --workdir=/home/brian/ax-livia/test -u root -it $(docker ps -q -f name='regression-run') "
alias conda="/home/brian/anaconda3/bin/conda"
#echo 'eval "$(gh copilot alias -- zsh)"' >> ~/.zshrc

# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=$HOME/.cache/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;
[ -f ~/.fzf.zsh  ] && source ~/.fzf.zsh


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
(( ! ${+functions[p10k]} )) || p10k finalize
# Domino ====================================================================================================
env=~/.ssh/agent.env

agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }

agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }

agent_load_env

# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2=agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)

if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add
fi

unset env
# Domino ====================================================================================================

alias glNoGraph='git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$@"'
_gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
_viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --ext-diff  --color=always % | diff-so-fancy '"

 #fcoc_preview - checkout git commit with previews
fcoc_preview() {
  local commit
  commit=$( glNoGraph |
    fzf --no-sort --reverse --tiebreak=index --no-multi \
        --ansi --preview="$_viewGitLogLine" ) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

# fshow_preview - git commit browser with previews
fshow_preview() {
    glNoGraph |
        fzf --no-sort --reverse --tiebreak=index --no-multi \
            --ansi --preview="$_viewGitLogLine" \
                --header "enter to view, alt-y to copy hash" \
                --bind "enter:execute:$_viewGitLogLine   " \
                --bind "alt-y:execute:$_gitLogLineToHash | xclip"
}
fshow_commits(){
    glNoGraph | fzf --no-sort --reverse --tiebreak=index --no-multi --ansi --preview="$_viewGitLogLine" \
        --header "enter2view|alt-j to preview-down|alt-k to preview-up|ctrl-f to preview-page-down|ctrl-b to preview-page-up|q to abort" \
        --bind "alt-j:preview-down,alt-k:preview-up,ctrl-f:preview-page-down,ctrl-b:preview-page-up,q:abort,enter:execute:$_gitLogLineToHash |\
        xargs -I % sh -c 'git show --ext-diff  % | \
        cdiff -s -w 100 '"
}
wget-jenkins() {
  wget --auth-no-challenge \
       --http-user=brian.nyamu@domino-uk.com \
       --http-password=11a4db2ab39dce6d0cafca6c5da6278e77 \
       "$@"
}
RIG_MAC_OR_IPADDR=""
get_mac() {
    RIG_MAC_OR_IPADDR=$(curl -s "https://rig-server.domino-printing.org/" | grep -i "$@" | cut -d',' -f3)
    echo $RIG_MAC_OR_IPADDR
}
get_ath_logs() {
    watch -n 2 "wget -qO- $@ | tac |sed 's/CMD:/\nCMD:/g'| tail"
}
get_picard_ath_logs() {
    local old_result=""
    local ath_logs_file="/tmp/ath_logs.txt"
    echo $old_result > $ath_logs_file
    while true; do
      result=$(curl -s http://$@:8001/Picard_ATH/log | 
          sed 's/CMD:/\nCMD:/g' |
          sed '/{.*/d' |
          sed 's/,/,\t/g' |
          head -n5)
      if [ "$result" != "$old_result" ]; then
        old_result=$result
        echo $result | tac >> $ath_logs_file
        echo $result
      fi
      sleep 0.05
    done

    #watch -n 2 "wget -qO- http://$@:8001/picard_ath/log | tac |sed 's/CMD:/\nCMD:/g'| head"
}
vnc_get_mac() {
    nohup xtigervncviewer  $(wget -qO- https://rig-server.domino-printing.org/ | grep -i "$@" | cut -d',' -f3 ) > /dev/null 2>&1&
}

ssh_get_mac() {
    ssh root@$(http https://rig-server.domino-printing.org/ | grep -i "$@" | cut -d',' -f3 ) 

}

#Copilot
eval "$(gh copilot alias -- zsh)"

