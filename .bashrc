# Prompt
export PS1="\u@\h:\w $ "

# Path(s)
NPM_PACKAGES="$HOME/.npm-packages"
export PATH="$NPM_PACKAGES/bin:$PATH"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"

# Useful Aliases
alias ..='cd ../'
alias ll='ls -FGAlh'
alias fnd='open -a Finder ./'
