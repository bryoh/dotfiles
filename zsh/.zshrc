# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

export TERM='xterm-256color'
typeset -U path PATH
path=(
  "$HOME/.local/bin"
  "$HOME/.cargo/bin"
  /usr/local/go/bin
  /usr/local/bin
  $path
)

# Path to your oh-my-zsh installation.
#export ZSH="/home/nyamu01b/.oh-my-zsh"

if command -v java >/dev/null 2>&1; then
  JAVA_BIN=$(readlink -f "$(command -v java)" 2>/dev/null)
  if [[ -n "$JAVA_BIN" ]]; then
    export JAVA_HOME="${JAVA_BIN%/bin/java}"
    path=("$JAVA_HOME/bin" $path)
  fi
fi

# Import colorscheme from 'wal' asynchronously.
if [[ -f "$HOME/.cache/wal/sequences" ]]; then
  (cat "$HOME/.cache/wal/sequences" &)
fi

if [[ -f "$HOME/.cache/wal/colors.sh" ]]; then
  source "$HOME/.cache/wal/colors.sh"
fi

# Load Powerlevel10k theme
zinit ice depth'1'
zinit light romkatv/powerlevel10k

# Load Oh-My-Zsh library
zinit snippet OMZ::lib/completion.zsh
zinit snippet OMZ::lib/history.zsh

# Background loading (Turbo Mode)
zinit ice wait'0' lucid
zinit light zsh-users/zsh-autosuggestions

zinit ice wait'0' lucid
zinit light zsh-users/zsh-syntax-highlighting

zinit ice wait'1' lucid
zinit light zsh-users/zsh-completions

# Forgit (Interactive Git with FZF)
zinit ice wait'0' lucid
zinit light wfxr/forgit

# OMZ plugins
zinit ice wait'2' lucid; zinit snippet OMZ::plugins/git
zinit ice wait'2' lucid; zinit snippet OMZ::plugins/pip
zinit ice wait'2' lucid; zinit snippet OMZ::plugins/docker-compose
zinit ice wait'2' lucid; zinit snippet OMZ::plugins/heroku
zinit ice wait'2' lucid; zinit snippet OMZ::plugins/fzf

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
setopt HIST_IGNORE_DUPS SHARE_HISTORY EXTENDED_HISTORY
#bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/brian/.zshrc'

# Optimize compinit (only run once a day)
autoload -Uz compinit
_comp_path="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/.zcompdump"
if [[ -n "${_comp_path}(#qN.m-1)" ]]; then
  compinit -C -d "$_comp_path"
else
  compinit -d "$_comp_path"
fi
# # End of lines added by compinstall


# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes
# source <(kubectl completion zsh)

#source $ZSH/oh-my-zsh.sh


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
# Lazy-load virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=$(command -v python3)

zsh-defer-virtualenvwrapper() {
  local venv_sh="/usr/share/virtualenvwrapper/virtualenvwrapper.sh"
  [[ -r "$venv_sh" ]] || venv_sh="$(command -v virtualenvwrapper.sh)"
  if [[ -n "$venv_sh" ]]; then
    source "$venv_sh"
  fi
}

# Create stubs that load the real thing on first use
workon() { unfunction workon mkvirtualenv; zsh-defer-virtualenvwrapper; workon "$@" }
mkvirtualenv() { unfunction workon mkvirtualenv; zsh-defer-virtualenvwrapper; mkvirtualenv "$@" }
# Display 
# export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
if grep -qi microsoft /proc/version 2>/dev/null; then
  export DISPLAY="$(hostname).mshome.net:0.0"
fi

export FZF_DEFAULT_OPTS="--extended --cycle --bind=alt-j:preview-down --bind=alt-k:preview-up"

walset() {
  "$HOME/dotfiles/scripts/wal-set" "$@"
}

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.

# Docker container management aliases
alias dps='docker ps'
alias dstart='docker start'
alias dstop='docker stop'
alias drm='docker rm'
alias dexit='docker exec -it'
alias dlogs='docker logs -f'
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias nw='tmux new-window'
alias bb='alias | fzf'
#alias exa='exa --sort created -lha --git'
#alias vim='nvim'
# alias rn='ranger --choosedir=$HOME/rangerdir;cd "$(cat $HOME/rangerdir)"'
command -v mate >/dev/null 2>&1 && alias zshconfig="mate ~/.zshrc"
command -v mate >/dev/null 2>&1 && alias ohmyzsh="mate ~/.oh-my-zsh"
alias xclip='xclip -selection c'
alias dotfiles="cd ~/dotfiles"
#alias rn='nano /root/.bashrc' #no more nano, big boi tings from now 
alias rv='vi /root/.bashrc'
alias sgl='git log --oneline --pretty=format:"%an %s"'
#alias gl='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias gll='git log --pretty=format:" %Creset%s% Cblue\\ %C(yellow)%an\\%C(red)%cr" --decorate --date=short'
alias glv='nvim -c GV'
alias gld='git log --ext-diff -p . | cdiff -s'
#alias gd='git diff | cdiff -s -w 100 '
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
#alias l='ls -CF'
#alias la='ls -A'
if command -v exa >/dev/null 2>&1; then
  alias ll='exa -lhs modified --git'
  alias lsd='exa -lhs modified */ --git'
elif command -v eza >/dev/null 2>&1; then
  alias ll='eza -lhs modified --git'
  alias lsd='eza -lhs modified */ --git'
fi
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
#echo 'eval "$(gh copilot alias -- zsh)"' >> ~/.zshrc

# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=$HOME/.cache/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;
[ -f ~/.fzf.zsh  ] && source ~/.fzf.zsh


path=(
  "$HOME/.yarn/bin"
  "$HOME/.config/yarn/global/node_modules/.bin"
  $path
)

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

if [[ -o interactive && -t 0 ]]; then
  if [ ! "$SSH_AUTH_SOCK" ] || [ "$agent_run_state" = 2 ]; then
      agent_start
      ssh-add
  elif [ "$SSH_AUTH_SOCK" ] && [ "$agent_run_state" = 1 ]; then
      ssh-add
  fi
fi

unset env
# Domino ====================================================================================================

glNoGraph() {
  git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr %C(auto)%an" "$@"
}

git_log_line_to_hash() {
  sed -E 's/^[^a-f0-9]*([a-f0-9]{7,40}).*/\1/'
}

view_git_log_line() {
  local commit_hash
  commit_hash="$(printf '%s\n' "$1" | git_log_line_to_hash)"
  [[ -n "$commit_hash" ]] || return 1

  if command -v diff-so-fancy >/dev/null 2>&1; then
    git show --ext-diff --color=always "$commit_hash" | diff-so-fancy
  else
    git show --ext-diff --color=always "$commit_hash"
  fi
}

 #fcoc_preview - checkout git commit with previews
fcoc_preview() {
  local commit
  commit=$(glNoGraph |
    fzf --no-sort --reverse --tiebreak=index --no-multi \
        --ansi --preview 'view_git_log_line {}') || return
  git checkout "$(printf '%s\n' "$commit" | git_log_line_to_hash)"
}

# fshow_preview - git commit browser with previews
fshow_preview() {
    glNoGraph |
        fzf --no-sort --reverse --tiebreak=index --no-multi \
            --ansi --preview 'view_git_log_line {}' \
                --header "enter to view, alt-y to copy hash" \
                --bind 'enter:execute:view_git_log_line {}' \
                --bind 'alt-y:execute-silent:printf %s {} | git_log_line_to_hash | xclip'
}
fshow_commits(){
    glNoGraph | fzf --no-sort --reverse --tiebreak=index --no-multi --ansi --preview 'view_git_log_line {}' \
        --header "enter2view|alt-j to preview-down|alt-k to preview-up|ctrl-f to preview-page-down|ctrl-b to preview-page-up|PgUp to preview-page-up|PgDn to preview-page-down|q to abort" \
        --bind 'alt-j:preview-down,alt-k:preview-up,ctrl-f:preview-page-down,ctrl-b:preview-page-up,PgUp:preview-page-up,PgDn:preview-page-down,q:abort,enter:execute:view_git_log_line {}'
}
RIG_MAC_OR_IPADDR=""
rig_lookup() {
    local query="${1:-}"
    [[ -n "$query" ]] || {
      printf 'usage: %s <query>\n' "${funcstack[2]}"
      return 1
    }
    command -v curl >/dev/null 2>&1 || return 1
    curl -fsSL "https://rig-server.domino-printing.org/" |
      grep -i -- "$query" |
      cut -d',' -f3 |
      head -n1
}

get_mac() {
    RIG_MAC_OR_IPADDR="$(rig_lookup "$1")" || return
    printf '%s\n' "$RIG_MAC_OR_IPADDR"
}
get_ath_logs() {
    local target="${1:-}"
    [[ -n "$target" ]] || {
      printf 'usage: get_ath_logs <url>\n'
      return 1
    }
    watch -n 2 "curl -fsSL '$target' | tac | sed 's/CMD:/\\nCMD:/g' | tail"
}
get_picard_ath_logs() {
    local host="${1:-}"
    local old_result=""
    local ath_logs_file="/tmp/ath_logs.txt"
    [[ -n "$host" ]] || {
      printf 'usage: get_picard_ath_logs <host>\n'
      return 1
    }
    : > "$ath_logs_file"
    while true; do
      local result
      result=$(curl -fsSL "http://$host:8001/Picard_ATH/log" |
          sed 's/CMD:/\nCMD:/g' |
          sed '/{.*/d' |
          sed 's/,/,\t/g' |
          head -n 5) || return
      if [ "$result" != "$old_result" ]; then
        old_result=$result
        printf '%s\n' "$result" | tac >> "$ath_logs_file"
        printf '%s\n' "$result"
      fi
      sleep 0.05
    done

    #watch -n 2 "curl -fsSL http://$host:8001/picard_ath/log | tac |sed 's/CMD:/\nCMD:/g'| head"
}
vnc_get_mac() {
    local host
    host="$(rig_lookup "$1")" || return
    nohup xtigervncviewer "$host" > /dev/null 2>&1 &
}

ssh_get_mac() {
    local host
    host="$(rig_lookup "$1")" || return
    ssh "root@$host"

}

#Copilot
# if command -v gh >/dev/null 2>&1; then
#   eval "$(gh copilot alias -- zsh)"
# fi

findstring() {
  local initial="${1:-}"
  fzf --ansi --disabled --query "$initial" \
    --prompt 'rg> ' \
    --delimiter ':' \
    --bind "change:reload:rg --color=always --line-number --no-heading --smart-case -- {q} . || true" \
    --preview 'bat --style=numbers --color=always --highlight-line {2} {1} 2>/dev/null || sed -n "$(( {2}-20<1?1:{2}-20 )), $(( {2}+20 ))p" {1}' \
    --bind 'enter:execute(nvim +{2} {1})'
}
# Automatic NVM & Node Package Stubber
export NVM_DIR="$HOME/.nvm"

zsh-defer-nvm() {
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}

# Dynamically find the binary path and create stubs
() {
  local default_node
  default_node=$(cat "$NVM_DIR/alias/default" 2>/dev/null)
  [[ -z "$default_node" ]] && default_node="lts/*"
  
  local nvm_bin
  nvm_bin=$(ls -d $NVM_DIR/versions/node/v*/bin 2>/dev/null | tail -n 1)
  
  if [[ -d "$nvm_bin" ]]; then
    local cmds=($(ls "$nvm_bin"))
    cmds+=("nvm") # Always include nvm
    
    for cmd in ${cmds}; do
      eval "$cmd() { unfunction ${cmds}; zsh-defer-nvm; $cmd \"\$@\" }"
    done
  fi
}

# WSL Copy-Paste Aliases (wsl-copy-paste)
# Perfect clipboard integration between WSL and Windows
alias copy='powershell.exe -noprofile -command "$stdin = [Console]::OpenStandardInput(); $bytes = [System.IO.MemoryStream]::new(); $stdin.CopyTo($bytes); $text = [System.Text.Encoding]::UTF8.GetString($bytes.ToArray()); $text = $text -replace \"`n\", \"`r`n\"; Set-Clipboard -Value $text"'
alias paste='powershell.exe -noprofile -command "$text = Get-Clipboard -Raw; $bytes = [System.Text.Encoding]::UTF8.GetBytes($text); [Console]::OpenStandardOutput().Write($bytes, 0, $bytes.Length)" | tr -d "\r"'

# P10k Style Cycler
cycle-p10k() {
  local profile_dir="$HOME/dotfiles/zsh/p10k_profiles"
  local config="$HOME/.p10k.zsh"
  local current_profile
  current_profile=$(readlink -f "$config")

  local profiles=(
    "$profile_dir/lean.p10k.zsh"
    "$profile_dir/classic.p10k.zsh"
    "$profile_dir/rainbow.p10k.zsh"
  )

  local next_index=0
  for i in {1..$#profiles}; do
    if [[ "${profiles[$i]}" == "$current_profile" ]]; then
      next_index=$(( (i % $#profiles) + 1 ))
      break
    fi
  done

  if [[ $next_index -eq 0 ]]; then next_index=1; fi

  local next_profile="${profiles[$next_index]}"
  local style_name="$(basename "$next_profile" .p10k.zsh)"

  ln -sf "$next_profile" "$config"
  source "$config"
  p10k reload # Ensure p10k fully picks up changes
  
  echo -e "\n%F{33}Prompt Style: %F{220}$style_name%f"
  zle && zle reset-prompt
}
zle -N cycle-p10k
bindkey 'es' cycle-p10k # Alt+s

# Fuzzy checkout branch (fbr)
fbr() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# Fuzzy stash preview (fsh)
fsh() {
  local stash
  stash=$(git stash list | fzf +m --preview 'git stash show --color=always {1}') &&
  git stash apply $(echo "$stash" | cut -d: -f1)
}

