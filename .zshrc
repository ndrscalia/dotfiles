export PATH="/opt/homebrew/opt/python@3.14/libexec/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"

# enable 24-bit colors
if [[ -z "$TMUX" ]]; then
  export TERM=xterm-256color
fi
export COLORTERM=truecolor

eval "$(oh-my-posh init zsh --config ~/dotfiles/.config/ohmyposh/amro-enhanced.omp.json)"
eval "$(zoxide init zsh)"

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^H' autosuggest-accept

export PATH="$HOME/.local/bin:$PATH"
