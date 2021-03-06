# ================================================================================
# .bashrc
# ================================================================================


# Detect OS And Settings
# ================================================================================

if [ "$(uname)" == 'Darwin' ]; then
  # echo '[MacOS] .bashrc'
  # ==============================================================================
  
  # Git Prompt
  test -r "${HOME}/.git-prompt.sh" && . "${HOME}/.git-prompt.sh"
  export PS1='\n\[\033[32m\]\u@\h \[\033[35m\]\D{%F %T} \[\033[33m\]\w\[\033[36m\]$(__git_ps1)\[\033[0m\]\n$ '
  
  # ls
  export CLICOLOR='1'
  export LSCOLORS='gxfxcxdxbxegedabagacad'
  alias ls='ls -G'
  
  # open = start
  alias start='open'
  
  # sed
  if type gsed > /dev/null 2>&1; then
    alias sed='gsed'
  fi
  
  # tree
  alias tree='tree -N'
  
  # Open App
  alias chrome='open -a "Google Chrome"'
  alias firefox='open -a Firefox'
  alias cot='open -a CotEditor'
  
  # Nodebrew
  alias nb='nodebrew'
  
  # Sudo コマンドの補完を有効にする
  complete -cf sudo
  
  # Finder のアクティブウィンドウのディレクトリに移動する
  function cdf() {
    local target="$(osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)')"
    if [ "$target" != '' ]; then
      cd "$target" && pwd && ls
    else
      echo 'No Finder window found' >&2
    fi
  }
  
  # CotEditor で開いているファイルを VSCode で開く
  alias cotvs='open -a '\''Visual Studio Code'\'' "$(osascript -e '\''tell application "CotEditor" to get path of document 1'\'')"'
  # CotEditor で開いているファイルを Chrome で開く
  alias cotchrome='open -a '\''Google Chrome'\'' "$(osascript -e '\''tell application "CotEditor" to get path of document 1'\'')"'
  
  # CotEditor で開く
  alias cotbp='open -a CotEditor "${HOME}/.bash_profile"'
  alias cotrc='open -a CotEditor "${HOME}/.bashrc"'
  
  # Customize --------------------------------------------------------------------
  
  # cd Aliases
  alias cdb='cd "${HOME}/Documents/Dev/BitBucket/" && pwd && ls'
  alias cdev='cd "${HOME}/Documents/Dev/" && pwd && ls'
  alias cdgh='cd "${HOME}/Documents/Dev/GitHub/" && pwd && ls'
  alias cds='cd "${HOME}/Documents/Dev/Sandboxes/" && pwd && ls'
  
  # ------------------------------------------------------------------------------
else
  # echo '[Windows] .bashrc'
  # ==============================================================================
  
  # Git Prompt : 標準の __git_ps1 が Windows 環境で遅いので簡易版を自作した
  function __git_ps1() {
    # ブランチ名 : symbolic-ref はブランチ名しか出せないが、タグなどにも対応している describe よりは若干高速
    local branch_name="$(git symbolic-ref --short HEAD 2> /dev/null)"  # "$(git describe --all 2> /dev/null | sed 's/heads\///' 2> /dev/null)"
    # ブランチ名がなければ Git リポジトリ配下ではないと見なす・何も出力せず中断する
    if [ -z "$branch_name" ]; then
      exit 0
    fi
    # どうしてもパフォーマンスが出ないのでブランチ名だけ出すことにする
    echo " [$branch_name]"
  }
  # test -r "${HOME}/.git-prompt.sh" && . "${HOME}/.git-prompt.sh"
  export PS1='\n\[\033[32m\]\u@\h \[\033[35m\]\D{%F %T} \[\033[33m\]\w\[\033[36m\]`__git_ps1`\[\033[0m\]\n$ '
  
  # ls
  alias ls='ls -F --color=auto --show-control-chars --time-style=long-iso'
  # C:\Program Files\Git\etc\ や C:\git-sdk-64\etc\ 配下の DIR_COLORS が色設定を持っている
  # 「DIR 01;34」を「DIR 01;36」にするとディレクトリが水色になる
  eval "$(dircolors /etc/DIR_COLORS 2> /dev/null)"
  
  # start = open
  alias open='start'
  
  # Open App
  alias chrome='cmd //c start chrome.exe'
  alias firefox='cmd //c start firefox.exe'
  alias npp='cmd //c start notepad++.exe'
  
  # Customize --------------------------------------------------------------------
  
  # cd Aliases
  alias cdb='cd '\''/c/Neos21/Dev/BitBucket/'\'' && pwd && ls'
  alias cdev='cd '\''/c/Neos21/Dev/'\'' && pwd && ls'
  alias cdgh='cd '\''/c/Neos21/Dev/GitHub/'\'' && pwd && ls'
  alias cds='cd '\''/c/Neos21/Dev/Sandboxes/'\'' && pwd && ls'
  
  # ------------------------------------------------------------------------------
fi


# --------------------------------------------------------------------------------
# Alias
# --------------------------------------------------------------------------------


# Alias : General
# ================================================================================

alias quit='exit'

alias cls='reset'
alias tc='clear && tmux clear-history'

# ls
alias la='ls -a'
alias ll='ls -l'
alias lal='ls -la'
alias lla='ls -la'
alias la1='ls -a -1'
alias ls1='ls -1'

# cd
alias ..='cd .. && pwd && ls'
alias ...='cd ../.. && pwd && ls'
alias -- -='cd - && ls'
alias -- --='cd - && ls'

# カレントディレクトリ配下の .DS_Store を全て消す
alias delds='find . -name '\''.DS_Store'\'' -delete'

# grep : 検索文字列を色付けする
alias grep='grep --color'
alias grepinr='grep -inR'

# df : バイト表示を単位変換する
alias df='df -h'

# PostgreSQL : パスワードは .pgpass (pgpass.conf) で設定
alias mpsql='psql -U postgres --dbname=my_local_db'

# vi = vim
alias vi='vim'

# Edit And Reload Setting Files
alias ebp='vi "${HOME}/.bash_profile"'
alias rbp='.  "${HOME}/.bash_profile"'
alias erc='vi "${HOME}/.bashrc"'
alias rrc='.  "${HOME}/.bashrc"'

# SSH Config のリストを表示する
alias sshls='grep -rh '\''^Host '\'' "${HOME}/.ssh/" | grep -v '\''*'\'' | sed '\''s/Host /ssh /'\'' | sort'
# SSH 接続先で使いたい PS1 プロンプトをコピペ用に出力する
alias echops1='echo '\''export PS1="\n\[\033[31m\]\u@\h \[\033[35m\]\D{%F %T} \[\033[33m\]\w\[\033[0m\]\n$ "'\'''


# Alias : Git
# ================================================================================

alias g='git'
alias ga='git add'
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -D'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcl='git clone'
alias gc='git commit'
alias gce='git commit --allow-empty'
alias gcem='git commit --allow-empty -m'
alias gcm='git commit -m'
alias gdf='git diff'
alias gdfc='git diff --cached'
alias gdfcw='git diff --color-words --word-diff-regex='\''\\w+|[^[:space:]]'\'' --cached'
alias gdfn='git diff --name-only'
alias gdfnc='git diff --name-only --cached'
alias gdfw='git diff --color-words --word-diff-regex='\''\\w+|[^[:space:]]'\'''
alias gdfwc='git diff --color-words --word-diff-regex='\''\\w+|[^[:space:]]'\'' --cached'
alias gdfwo='git diff --word-diff'
alias gdfwoc='git diff --word-diff --cached'
alias gfe='git fetch'
alias gl=' git log -10 --date=short --pretty=format:"%C(Yellow)%h %C(Cyan)%cd %C(Reset)%s %C(Blue)[%cn]%C(Red)%d"'
alias glf='git log --pretty=fuller'
alias glo='git log'
alias glr='git log -10 --date=short --pretty=format:"%C(Yellow)%h %C(Cyan)%cd %C(Reset)%s %C(Blue)[%cn]%C(Red)%d" --graph'
alias gm='git merge'
alias gpl='git pull'
alias gps='git push'
alias gre='git reset'
alias greh='git reset --hard'
alias gr='git remote'
alias grv='git remote -v'
alias grs='git remote set-url origin'
alias gst='git status'
alias gs='git status -s -b'
alias gt='git tag'

function gclcd() {
  git clone "$1" && cd "$(basename "$1" .git)" || return
}

function gplf() {
  local current_branch_name="$(git branch | grep -e '^* ' | sed 's/^* //g')"
  git branch --set-upstream-to="origin/${current_branch_name}" "${current_branch_name}"
  git pull
}

# tig
alias tiga='tig --all'


# Alias : Node
# ================================================================================

alias n='npm'
alias ni='npm install --progress=true'
alias nl='npm list --depth=0'
alias nls='npm list --depth=0'
alias nlg='npm list --depth=0 -g'
alias nlsg='npm list --depth=0 -g'
alias nr='npm run'
alias np='npm publish --access=public'
alias ns='npm start || npm run dev'
alias nt='npm test'
alias nu='npm uninstall --progress=true'
alias nunp='npm unpublish'

# For Angular CLI
alias nn='npm run ng'


# Alias : VSCode
# ================================================================================

function c() {
  if [ "$#" -eq 0 ]; then
    code .
  else 
    code "$@"
  fi
}

function ca() {
  if [ "$#" -eq 0 ]; then
    code --add .
  else 
    code --add "$@"
  fi
}

function cr() {
  if [ "$#" -eq 0 ]; then
    code --reuse-window .
  else 
    code --reuse-window "$@"
  fi
}


# Alias : Docker
# ================================================================================

alias d='docker'
alias da='docker attach'
alias db='docker build --no-cache --tag'
alias di='docker images'
alias dit='docker image tag'
alias dpl='docker pull'
alias dps='docker ps -a'
alias dpush='docker push'
alias dr='docker run -it'  # ex. docker run -it -v "$(pwd):/tmp/shared" -p 8080:8080 【Image Name】 bash
alias drm='docker rm -f'
alias drma='docker rm -f $(docker ps -aq)'
alias drmi='docker rmi'
alias drun='docker run -it'
alias ds='docker start'
alias dsta='docker start'
alias dsto='docker stop'

# 対象コンテナが止まっていても強制的に docker exec する
function de() {
  if [ "$#" -eq 0 ]; then
    echo '[de : docker exec function] Requires at least 1 argument.'
    return 1
  fi
  docker start "$1" > /dev/null
  if [ "$#" -eq 1 ]; then
    docker exec -it "$1" 'bash'
  else
    docker exec -it "$@"  # ex. 【Container ID or Container Name】 bash
  fi
}

alias dc='docker-compose'
alias dcb='docker-compose build --no-cache'
alias dcup='docker-compose up'
alias dcupd='docker-compose up -d'
alias dcr='docker-compose run --rm'
alias dcrm='docker-compose rm -sf'
alias dcrun='docker-compose run --rm'
alias dcsta='docker-compose start'
alias dcsto='docker-compose stop'


# Alias : Kubernetes
# ================================================================================

alias k='kubectl'
alias kaf='kubectl apply -f'
alias kd='kubectl describe'
alias kdd='kubectl describe deployment'
alias kdn='kubectl describe node'
alias kdp='kubectl describe pod'
alias kds='kubectl describe service'
alias kdsc='kubectl describe secret'
alias ke='kubectl edit'
alias kes='kubectl edit service'
alias kesh='kubectl exec -ti'
alias kg='kubectl get'
alias kgd='kubectl get deployment'
alias kgn='kubectl get node'
alias kgp='kubectl get pod'
alias kgpw='kubectl get pod -o wide'
alias kgs='kubectl get service'
alias kgsc='kubectl get secret'
alias kl='kubectl logs'
alias kp='kubectl proxy'


# Alias : Terraform
# ================================================================================

alias t='terraform'
alias ta='terraform apply'
alias td='terraform destroy'
alias ti='terraform init'
alias tp='terraform plan'
alias tpd='terraform plan -destroy'


# --------------------------------------------------------------------------------
# Customize
# --------------------------------------------------------------------------------


# --------------------------------------------------------------------------------
