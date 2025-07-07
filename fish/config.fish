if status is-interactive
    set fish_greeting

    # Check if fisher is installed
    if not functions -q fisher
        echo "Installing Fisher plugin manager..."
        curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher

        fisher install ilancosman/tide@v6
        fisher install patrickf1/fzf.fish
        fisher install jhillyerd/plugin-git

        tide configure --auto --style=Rainbow --prompt_colors='True color' --show_time='12-hour format' \
            --rainbow_prompt_separators=Angled --powerline_prompt_heads=Sharp --powerline_prompt_tails=Flat \
            --powerline_prompt_style='Two lines, frame' --prompt_connection=Disconnected \
            --powerline_right_prompt_frame=No --prompt_connection_andor_frame_color=Lightest --prompt_spacing=Compact \
            --icons='Many icons' --transient=No
    end
end

alias ls="lsd"

alias nv="nvim"
alias vi="nvim"
alias vim="nvim"

alias dnfupd="sudo dnf update --refresh"
alias dnfi="sudo dnf install"
alias dnfr="sudo dnf remove"
alias dnfca="sudo dnf clean all"
alias full-upgrade="sudo dnf update --refresh -y; flatpak update -y"

alias fu="flatpak update"
alias fin="flatpak install"

alias cddesk="cd ~/Desktop/"
alias cddown="cd ~/Downloads/"

alias tmux="tmux -2"

set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx SUDO_EDITOR nvim
