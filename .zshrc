if [[ $TTY == *"tty"* ]]; then
        in_tty=true
else
        in_tty=false
fi

# Tmux
if [[ $in_tty == false ]]; then
        case $- in *i*)
                if [[ -z $TMUX_PANE ]] || [[ ${TMUX_PANE#"%"} == 0 ]]; then 
                        [[ -z $TMUX ]] && tmux -u && exit 
                fi
        esac
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="$HOME/neovim/bin:$PATH"
export PATH="/var/tmp/portage/sys-apps/ripgrep-14.1.0/image/usr/bin:$PATH"
export PATH="/var/tmp/portage/sys-apps/fd-9.0.0/image/usr/bin:$PATH"
export PATH="/home/Faris/.cargo/bin:$PATH"
export PATH="/home/Faris/.local/bin:$PATH"
export GTK_THEME="Catppuccin-Mocha-Standard-Green-Dark"

# Ghidra braucht das
export JAVA_HOME="/home/Faris/jdk-21.0.3+9"
export PATH=$JAVA_HOME/bin:$PATH

# Bat
export BAT_THEME="Catppuccin Mocha"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
alias cat=bat


# Python
# source ~/venv/bin/activate

# SSH
eval $(ssh-agent) > /dev/null

bindkey -r "^S"
ulimit -c unlimited # Segmentation fault

export EDITOR=nvim # I use neovim by the way

# function run_info() { 
#   # Prepend "info" to the command line and run it.
#   BUFFER="info $BUFFER"
#   zle accept-line
# }
#
# # Define a widget called "run_info", mapped to our function above.
# zle -N run_info
#
# # Bind it to ESC-i.
# bindkey "^[i" run_info


# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
PS1="%F{green}%n%f %F{cyan}%~%f\$(git branch 2>/dev/null | grep -e '\* ' | sed 's/^..\(.*\)/ %F{yellow}(\1)%f/') %F{white}$ "

# ZSH_THEME="random"
# ZSH_THEME="intheloop"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
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
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
        git
)

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
alias c="cargo"
alias cb="cargo build"
alias cr="cargo run"
alias lg="lazygit"
alias ls="exa -1 -F -T -L=1 --group-directories-first --icons"

# Init
if [[ $in_tty == false ]]; then
        eval "$(zoxide init zsh --cmd cd)"
        # source /usr/share/zsh/site-contrib/zsh-vi-mode/zsh-vi-mode.plugin.zsh
        . /usr/share/zsh/site-functions/zsh-autocomplete/zsh-autocomplete.plugin.zsh
        . /usr/share/zsh/site-functions/zsh-autosuggestions.zsh
        source /usr/share/zsh/site-functions/zsh-syntax-highlighting.zsh
fi

# bun completions
[ -s "/home/Faris/.bun/_bun" ] && source "/home/Faris/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
