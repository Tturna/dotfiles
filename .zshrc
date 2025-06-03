# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=500
SAVEHIST=500
setopt extendedglob
bindkey -v
# End of lines configured by zsh-newuser-install

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fz='fzf --preview='\''bat --theme="Monokai Extended" --style=full --color=always {}'\'''
alias calc='galculator'

export EDITOR="nvim"

export DOTNET_ROOT="$HOME/.dotnet"
export PATH="/home/tturna/.local/bin:$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools"
export DOTNET_CLI_TELEMETRY_OPTOUT=true

export MGFXC_WINE_PATH="/home/tturna/.winemonogame"
export PATH="$PATH:$MGFXC_WINE_PATH"

ZINIT_HOME="${HOME}/.local/share/zinit/zinit.git"

# This bit was mostly made by the zinit install script. I changed it so it uses the ZINIT_HOME variable. 
if [[ ! -f ${ZINIT_HOME}/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$ZINIT_HOME/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
# End of zinit installer added lines

# Plugins using zinit plugin manager ---------

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
# see completion suggestions with tab

zinit light zsh-users/zsh-autosuggestions
# autosuggestion options set below

# plugin that opens an fzf tab for zsh completions
zinit light Aloxaf/fzf-tab

# Done with plugins --------------------------

# load completions
autoload -U compinit && compinit

# replay cached completions
zinit cdreplay -q

# keybindings
# See this for info: https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html
# Especially this:   https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html#Zle-Builtins
# And this:          https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets
# Use "verbatim insert" (ctrl+v) to get codes representing special keys like arrow up.
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

# completion styling
# more about the styling of the completion system: https://zsh.sourceforge.io/Doc/Release/Completion-System.html#index-completion-system_002c-styles
#
# This makes completion case insensitive
# (I think) it works by taking what you've typed and applying the pattern before the = to it.
# If the pattern fits, completions for it are shown.
# The completion suggestions need to match the pattern after the =.
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
# This colors the completion suggestions
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
#
zstyle ':completion:*' menu off
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# zsh-autosuggestions options
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Enable the starship prompt
eval "$(starship init zsh)"

# Enable fzf (fuzzy finder)
eval "$(fzf --zsh)"
# ctrl-r to fuzzy find commands from history
# ctrl-t to fuzzy find files
# combine with commands like cd:
# type cd -> ctrl-t -> find file -> enter to paste into cli
# alternatively append path with ** to enter fzf:
# cd apps/**

# Enable zoxide for a better cd
eval "$(zoxide init --cmd cd zsh)"
