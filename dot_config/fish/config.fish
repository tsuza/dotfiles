source /usr/share/cachyos-fish-config/cachyos-config.fish
starship init fish | source

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

# Alias's for multiple directory listing commands
alias ls='ls -aFh --color=always' # add colors and file type extensions
alias ll='ls -Flsa' # long listing format

# Alias for helix
alias hx='helix'

# Alias for plocate
alias plocate='plocate -i'

# pnpm
set -gx PNPM_HOME "/home/suza/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# Automatically do an ls after each cd
function cd
    if test -n "$argv"
        builtin cd $argv; and ls
    else
        builtin cd ~; and ls
    end
end

# Function to detect the current distribution
function distribution
    set dtype unknown # Default to unknown

    # Check if /etc/os-release exists and extract the ID
    if test -r /etc/os-release
        for line in (cat /etc/os-release)
            if echo $line | grep -q "^ID_LIKE="
                set dtype (string split "=" $line)[2]
                break
            end
        end
    end

    if test -n "$dtype"
        switch $dtype
            case "*fedora*" "*rhel*" "*centos*"
                set dtype redhat
            case "*sles*" "*opensuse*"
                set dtype suse
            case "*ubuntu*" "*debian*"
                set dtype debian
            case "*gentoo*"
                set dtype gentoo
            case "*arch*"
                set dtype arch
            case "*slackware*"
                set dtype slackware
            case "*"
                # If no match is found, keep dtype as unknown
                set dtype unknown
        end
    end

    echo $dtype
end

# Set DISTRIBUTION variable by calling distribution function
set -g DISTRIBUTION (distribution)

# Set alias based on the detected distribution
if test $DISTRIBUTION = redhat -o $DISTRIBUTION = arch
    alias cat="bat"
else
    alias cat="batcat"
end

alias whatismyip="whatsmyip"
function whatsmyip
    # Internal IP Lookup
    if type -q ip
        echo -n "Internal IP: "
        ip addr show wlan0 | grep "inet " | awk '{print $2}' | cut -d/ -f1
    else
        echo -n "Internal IP: "
        ifconfig wlan0 | grep "inet " | awk '{print $2}'
    end

    # External IP Lookup
    echo -n "External IP: "
    curl -s ifconfig.me
end

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/suza/.ghcup/bin # ghcup-env