if status is-interactive
    # Commands to run in interactive sessions can go here
end
starship init fish | source

# bind -M insert -k nul accept-autosuggestion
bind -M insert \cJ backward-char
bind -M insert \cl accept-autosuggestion
bind -M insert \cK forward-single-char
bind -M insert \cP history-search-backward
bind -M insert \cN history-search-forward
bind -M insert \cC kill-whole-line repaint
# bind '' self-insert

abbr -g c clear
abbr -g vifm vifmrun
abbr -g bit beet import -t
abbr -g bmv beet move
abbr -g sf source ~/.config/fish/config.fish

abbr -g ca chezmoi add
abbr -g ca. chezmoi add .
abbr -g ce chezmoi edit
abbr -g cf chezmoi forget
abbr -g cf. chezmoi forget .

set -g fish_greeting
set -g fish_key_bindings fish_vi_key_bindings

fish_add_path -gp "/home/og_saaz/go/bin"
fish_add_path -gp "/usr/local/go/bin"
fish_add_path -gp "/home/og_saaz/Android/Sdk/platform-tools/"
set -gx EDITOR 'nvim --listen /tmp/nvim.sock'
set -gx VISUAL 'nvim --listen /tmp/nvim.sock'
set -gx MANPAGER 'nvim +Man!'
set -gx LS_COLORS (vivid generate lava)
set -gx FZF_DEFAULT_COMMAND "fd --hidden --type f --follow --color always . $HOME"
set -gx FZF_ALT_C_COMMAND "fd --hidden --type d --color=always --follow . $HOME"
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -gx FZF_CTRL_R_OPTS " --preview 'echo {}' --preview-window top:2:wrap "
set -gx FZF_ALT_C_OPTS '
--preview "exa --all --sort name --tree --level 1 --classify --git --long --color=always --no-user --no-permissions :500 {}"
--preview-window right:100:nowrap:hidden
'
set -gx FZF_DEFAULT_OPTS '
--preview "bat --style=numbers --color=always --line-range :500 {}"
--cycle --ansi --keep-right --multi  --no-height --no-reverse
--bind "?:toggle-preview" --preview-window right:wrap:hidden --marker="*"
'
set -gx EXA_GRID_ROWS 10
set -gx EXA_ICON_SPACING 2

function l
  exa -laG --sort name --group-directories-first --git --no-user --icons --color always --color-scale --no-time
end

