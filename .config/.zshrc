# Path to your Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Theme setup (Starship handles the prompt theme)
ZSH_THEME=""

# Oh My Zsh Plugins
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# Preferred Editor
export EDITOR='nvim'

# Modern Replacement Aliases (Ubuntu Specific)
alias ls='eza --icons'
alias ll='eza -l --icons --group-directories-first'
alias la='eza -la --icons --group-directories-first'
alias lt='eza --tree --level=2 --icons'

# Ubuntu binary name adjustments
alias cat='batcat --style=plain'
alias bat='batcat'
alias grep='rg'
alias find='fdfind'
alias fd='fdfind'
alias help='tldr'

# Shell Integrations
if command -v fzf &> /dev/null; then
    eval "$(fzf --zsh)" 2>/dev/null || {
        [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
        [ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
    }
fi

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
source /opt/ros/lyrical/setup.zsh

# Auto-source workspace if it has been built
if [ -f "$HOME/RoboSub/install/setup.zsh" ]; then
    source "$HOME/RoboSub/install/setup.zsh"
fi

# Automatically jump to the RoboSub directory on startup
if [ -d "$HOME/RoboSub" ]; then
    cd "$HOME/RoboSub"
fi