NPM_PACKAGES="$HOME/.npm-packages"
PATH="$NPM_PACKAGES/bin:$PATH"
NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"

# make sure npm man pages can be found.
export MANPATH="$NPM_PACKAGES/lib/node_modules/npm/man:$(manpath)"
