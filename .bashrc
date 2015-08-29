# Prompt
export PS1="\u@\h:\w $ "

# Path(s)
NPM_PACKAGES="$HOME/.npm-packages"
export PATH="$PATH:$NPM_PACKAGES/bin"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules"

# Useful Aliases
alias ..='cd ../'
alias ll='ls -FGAlh'
alias fnd='open -a Finder ./'
