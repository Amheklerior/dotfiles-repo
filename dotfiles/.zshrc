### SHELL & SYSTEM-WIDE LANGUAGE

# NOTE. Priority order of these env vars:
# 1. LC_ALL   - overrides all other LC_* vars
# 2. LC_*     - set specific formats for various language and locale aspects (es. LC_MESSAGE, LC_TIME, LC_MEASUREMENTS, ...)
# 3. LANGUAGE - only for translations, takes precedence over the LANG var
# 4. LANG     - general default if no other specific locale or language variables are set.

# use US English as default language
export LANGUAGE=en_US
export LANG=en_US.UTF-8

# use metric system over imperial
export LC_MEASUREMENT=it_IT.UTF-8

# use day-month-year, 24-hour date and time formats
export LC_TIME=it_IT.UTF-8

# make sure there's no override
export LC_ALL=


### SHELL PROMPT 

# load the completion functions and initialize the completion system.
# -z: first unload any preloaded completion function.
autoload -Uz compinit && compinit

# load starship
eval "$(starship init zsh)"

# integrate fuzzy search on tab autocompletion
source $SHELL_PLUGINS/fzf-tab/fzf-tab.plugin.zsh

# setup zsh autouggestions
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# setup zsh syntax highlighting
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# improve history up/down traversal to limit results on the current shell input
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

# Allow moving back and forth across words with option+left/right
# NOTE: Ghostty terminal emulator uses lowercase chars (while others use uppercase chars) 
bindkey '^[b' backward-word
bindkey '^[f' forward-word

# Consider the following chars word-separators
export WORDCHARS="*?[]~=&;!#$%^(){}<>"

# Delete word by word with option+delete 
bindkey '^[^?' backward-kill-word

# Don’t record commands starting with a leading space
setopt HIST_IGNORE_SPACE


### ZOXIDE

# load zoxide
eval "$(zoxide init zsh)"


### BAT

# setup bat color theme
export BAT_THEME=gruvbox-dark

# setup bat as man pager
export MANPAGER="sh -c 'col -bx | bat --language=man --style=plain'"
# ...only if you experience formatting issues with man pages
# export MANROFFOPT="-c"

# integrate bat to the `-h` and `--help` command options
alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'


### FZF

# set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"

# customise default command behaviour, to search files only
export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# call fzf with a content previewer, using bat for syntax highlighting
export FZF_DEFAULT_OPTS="--preview 'bat --color=always --style=numbers --line-range=:500 {}'"


### NODE

# setup fnm env vars 
# --use-on-cd: automatically run fnm use when a directory contains a `.node-version` or `.nvmrc` file
eval "$(fnm env --use-on-cd)"

# define the root directory for node installations
export FNM_DIR="$HOME/.fnm"

# resolve `engines.node` field in `package.json` whenever a `.node-version`/`.nvmrc` file is not present
export FNM_RESOLVE_ENGINES="true"

# corepack install dir
export COREPACK_HOME="$HOME/.corepack"


### ALIASES & FUNCTIONS

source $HOME/.zalias
source $HOME/.zfunc

### WORK

if [ -e "$HOME/.zwork" ]; then source $HOME/.zwork; fi
