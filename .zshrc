
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/andreascalia/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/andreascalia/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/andreascalia/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/andreascalia/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export PATH="/usr/local/bin:$PATH"

# enable 24-bit colors for starship
export TERM=xterm-256color
export COLORTERM=truecolor

eval "$(oh-my-posh init zsh --config craver)"

export PATH="$HOME/.local/bin:$PATH"
