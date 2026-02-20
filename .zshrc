export PATH="/opt/homebrew/opt/python@3.14/libexec/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"

export EDITOR=nvim
export VISUAL=nvim

# make `ls` colorize its output
export CLICOLOR=1

# enable 24-bit colors
if [[ -z "$TMUX" ]]; then
  export TERM=xterm-256color
fi
export COLORTERM=truecolor

eval "$(oh-my-posh init zsh --config ~/dotfiles/.config/ohmyposh/amro-enhanced.omp.json)"
#eval "$(oh-my-posh init zsh --config ~/dotfiles/.config/ohmyposh/gruvbox-enhanced.omp.json)"
eval "$(zoxide init zsh)"

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^O' autosuggest-accept

# With these lines you can edit long commands in nvim with `ctrl+x+e`
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# aliases
alias python313="/opt/homebrew/opt/python@3.13/libexec/bin/python3"
alias grep="grep --color=always"
alias ll="ll -la"
