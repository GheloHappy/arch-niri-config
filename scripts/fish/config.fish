#Android Studio android-studio-x option to run android studio
# if status is-interactive
#     function android-studio-x
#         env _JAVA_AWT_WM_NONREPARENTING=1 GDK_BACKEND=x11 android-studio-x
#     end
# end

#Setting up default nvm node version
# nvm use 24.14.0 >/dev/null

# set -gx JAVA_HOME /usr/lib/jvm/java-17-openjdk

# Add Java binaries to your PATH
# fish_add_path $JAVA_HOME/bin

# Add SDK tools to PATH
# fish_add_path $ANDROID_HOME/emulator
# fish_add_path $ANDROID_HOME/platform-tools
# fish_add_path $ANDROID_HOME/cmdline-tools/latest/bin
# fish_add_path $ANDROID_HOME/build-tools/latest

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

fastfetch
# This displays a small image once when you start the shell
