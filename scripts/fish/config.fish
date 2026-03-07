if status is-interactive
    alias android-studio-x "Xwayland :1 &; set -x DISPLAY :1; android-studio"
end

#if not type -q node
#    nvm use default --silent
#end

set -U fish_greeting "MAH NINJA!"

function fish_prompt
    # 1. Custom Time (using brblack for a gray look)
    set_color brblack
    echo -n "["(date "+%H:%M:%S")"] "

    # 2. Username and Hostname
    set_color cyan
    echo -n $USER
    set_color normal
    echo -n "@"
    set_color blue
    echo -n (prompt_hostname)

    # 3. Full Working Directory (using pwd for the full path)
    set_color yellow
    echo -n " "(pwd)

    # 4. NEW: Move the cursor to the line BELOW
    echo ""
    set_color green
    echo -n " ~> "
    set_color normal
end

# Ensure the path never shortens
set -gx fish_prompt_pwd_dir_length 0

# nvm-fish integration - added automatically
# You must call it on initialization or directory switching won't work
#load_nvm >/dev/stderr

fastfetch
# This displays a small image once when you start the shell
