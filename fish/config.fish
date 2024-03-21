# User
set -gx DEFAULT_USER (whoami)
set -gx HOME /Users/$DEFAULT_USER

# Greeting
set fish_greeting ""

# Colors
set -gx TERM xterm-256color

# Theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

# Aliases
alias ls "ls -p -G"
alias la "ls -A"
alias l='ls -lh'
alias ll "ls -la"
alias lla "ll -A"
alias g git
alias vim='nvim'
alias zshconfig="vim ~/.zshrc"
alias hostsfile="vim /etc/hosts"

# Default NVIM editor
command -qv nvim && alias vim nvim
set -gx EDITOR nvim

# Ssh
set -gx SSH_PUB_KEY '~/.ssh/id_rsa.pub'
set -gx SSH_KEY_PATH '~/.ssh/dsa_id'

# M1 Homebrew path
set -gx BREW /opt/homebrew

# Node
set -gx NODENV_GLOBAL_NODE_VERSION (nodenv global)
set -gx NODENV_GLOBAL_NODE $HOME/.nodenv/versions/$NODENV_GLOBAL_NODE_VERSION/bin
set -gx PATH $PATH $NODENV_GLOBAL_NODE

# Homebrew
set -gx HOMEBREW $BREW/bin:$BREW/sbin
set -gx PATH $PATH $HOMEBREW

# Homebrew Yarn
set -gx HOMEBREW_YARN_VERSION (yarn -v)
set -gx HOMEBREW_YARN $BREW/Cellar/yarn/$HOMEBREW_YARN_VERSION/bin
set -gx PATH $PATH $HOMEBREW_YARN

# Homebrew Nodenv
set -gx HOMEBREW_NODENV_VERSION (nodenv -v)
set -gx HOMEBREW_NODENV $BREW/Cellar/nodenv/$HOMEBREW_NODENV_VERSION/bin:$BREW/Cellar/nodenv/$HOMEBREW_NODENV_VERSION/completions:$BREW/Cellar/nodenv/$HOMEBREW_NODENV_VERSION/shims:$HOME/.nodenv/shims
set -gx PATH $PATH $HOMEBREW_NODENV
set -Ux fish_user_paths $NODENV_GLOBAL_NODE $fish_user_paths

# Homebrew Rabbitmq
set -gx HOMEBREW_RABBITMQ_VERSION (rabbitmqctl version)
set -gx HOMEBREW_RABBITMQ $BREW/Cellar/rabbitmq/$HOMEBREW_RABBITMQ_VERSION/sbin/
set -gx PATH $PATH $HOMEBREW_RABBITMQ

# Homebrew Haskell
set -gx HOMEBREW_HASKELL $HOME/.ghcup/bin/
set -gx PATH $PATH $HOMEBREW_HASKELL

# Haskell
set -gx CABAL_HASKELL $HOME/.cabal/bin/
set -gx PATH $PATH $CABAL_HASKELL

# Homebrew LLVM
set -gx HOMEBREW_LLVM $BREW/Cellar/llvm@12/12.0.1_1/bin
set -gx PATH $PATH $HOMEBREW_LLVM

# Homebrew PostgresSQL
set -gx HOMEBREW_POSTGRES $BREW/opt/postgresql@15/bin
set -gx PATH $PATH $HOMEBREW_POSTGRES

# Personal
set -gx PERSONAL bin $PERSONAL
set -gx PERSONAL $HOME/bin $PERSONAL
set -gx PERSONAL $HOME/.local/bin $PERSONAL
set -gx PATH $PATH $PERSONAL

# System path
set -gx PATH $PATH /usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin

# Temporary
set -e GREP_OPTIONS
alias grep='grep --color=auto'

# Initialize nodenv
status --is-interactive; and source (nodenv init -|psub)

# Initialize thefuck
thefuck --alias | source

# Haskell GHC (TODO make this work)
# set -gx LDFLAGS= -L$BREW/Cellar/llvm@12/12.0.1_1/lib
# set -gx CPPFLAGS -I$BREW/Cellar/llvm@12/12.0.1_1/include

# ChatGPT
set -gx OPENAI_API_KEY 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

# Python
set -gx PATH $PATH $HOME/.pyenv/shims
status --is-interactive; and pyenv init - | source
status --is-interactive; and pyenv virtualenv-init - | source

# Config load
switch (uname)
    case Darwin
        source (dirname (status --current-filename))/config-osx.fish
    case Linux
        source (dirname (status --current-filename))/config-linux.fish
    case '*'
        source (dirname (status --current-filename))/config-osx.fish
end

set LOCAL_CONFIG (dirname (status --current-filename))/config-local.fish
if test -f $LOCAL_CONFIG
    source $LOCAL_CONFIG
end

# Zellij
eval (zellij setup --generate-auto-start fish | string collect)
set -g ZELLIJ_AUTO_EXIT true
