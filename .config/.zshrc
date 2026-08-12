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
alias l='ls -lah'
alias ls='eza'
alias ll='eza -l --group-directories-first'
alias la='eza -la --group-directories-first'
alias lt='eza --tree --level=2'

# Ubuntu binary name adjustments
alias cat='batcat --style=plain'
alias bat='batcat'
alias grep='rg'
alias find='fdfind'
alias fd='fdfind'
alias help='tldr'

# ROS 2 Developer Aliases
alias cb='colcon build --symlink-install'
alias cbp='colcon build --symlink-install --packages-select'
alias rt='ros2 topic list'
alias rn='ros2 node list'
alias rdi='rosdep install --from-paths src --ignore-src -y'

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
if [ -n "$WS_DIR" ] && [ -f "$HOME/$WS_DIR/install/setup.zsh" ]; then
    source "$HOME/$WS_DIR/install/setup.zsh"
fi

# Automatically jump to the workspace directory on startup
if [ -n "$WS_DIR" ] && [ -d "$HOME/$WS_DIR" ]; then
    cd "$HOME/$WS_DIR"
fi