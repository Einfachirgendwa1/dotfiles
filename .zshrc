if [[ $TTY == *"tty"* ]]; then
        in_tty=true
else
        in_tty=false
fi

# Tmux
if [[ $in_tty == false ]]; then
        case $- in *i*)
                if [[ -z $TMUX_PANE ]] || [[ ${TMUX_PANE#"%"} == 0 ]]; then 
                        [[ -z $TMUX ]] && tmux -f /home/Faris/.tmux.conf -u && exit 
                fi
        esac
fi

export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="$HOME/neovim/bin:$PATH"
export PATH="/var/tmp/portage/sys-apps/ripgrep-14.1.0/image/usr/bin:$PATH"
export PATH="/var/tmp/portage/sys-apps/fd-9.0.0/image/usr/bin:$PATH"
export PATH="/home/Faris/.cargo/bin:$PATH"
export PATH="/home/Faris/.local/bin:$PATH"

export GTK_THEME="Catppuccin-Mocha-Standard-Green-Dark"

export JAVA_HOME="/home/Faris/jdk-21.0.3+9"
export PATH=$JAVA_HOME/bin:$PATH

export BAT_THEME="Catppuccin Mocha"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
alias cat="bat --paging=never"
export JQ_LIB_DIR=/usr/lib64

eval $(ssh-agent) > /dev/null
export $(dbus-launch)
gsettings set org.gnome.desktop.interface color-scheme prefer-dark

xhost si:localuser:root > /dev/null

bindkey -r "^S"
ulimit -c unlimited

export EDITOR=nvim
export VISUAL=nvim


export ZSH="$HOME/.oh-my-zsh"

PS1="%F{green}%n%f %F{cyan}%~%f\$(git branch 2>/dev/null | grep -e '\* ' | sed 's/^..\(.*\)/ %F{yellow}(\1)%f/') %F{white}$ "

CASE_SENSITIVE="false"
HYPHEN_INSENSITIVE="true"

zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 14

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

HIST_STAMPS="dd/mm/yyyy"

plugins=(
        git
)

source $ZSH/oh-my-zsh.sh

alias c="cargo"
alias cb="cargo build"
alias cr="cargo run"
alias ca="cargo add"
alias cn="cargo new"
alias ctd="cargo tauri dev"
alias lg="lazygit"
alias ls="exa -1 -F -T -L=1 --group-directories-first --icons"
alias lsl="exa -1 -L -F -T --group-directories-first --icons"

export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

cdi_function() {
    BUFFER="cdi && clear $BUFFER"
    zle accept-line
}


zle -N cdi_function
bindkey "^[d" cdi_function

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
