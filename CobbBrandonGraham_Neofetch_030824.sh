#!/bin/bash

# Function to get OS information
get_os_info() {
    if [ -e /etc/os-release ]; then
        source /etc/os-release
        OS="${NAME}"
        VERSION="${VERSION_ID}"
    elif [ $(uname -s) == "Darwin" ]; then
        OS="MacOS"
        VERSION=$(sw_vers -productVersion)
    else
        OS=$(uname -s)
        VERSION=$(uname -r)
    fi
}

# Function to get CPU information
get_cpu_info() {
    CPU=$(uname -p)
}

# Function to get GPU information
get_gpu_info() {
    GPU=$(lspci | grep -i 'VGA\|3D\|2D' | cut -d ':' -f 3 | awk '{$1=$1};1' | head -n 1)
}

# Function to get Memory information
get_memory_info() {
    MEMORY=$(free -h | awk '/^Mem/ {print $2}')
}

# Function to get Shell information
get_shell_info() {
    SHELL=$(basename "$SHELL")
}

# Function to get Desktop Environment information
get_de_info() {
    DE=$(echo "$XDG_CURRENT_DESKTOP" | sed 's/[^a-zA-Z]//g')
    if [ -z "$DE" ]; then
        DE="N/A"
    fi
}

# Function to display ASCII art for Arch Linux
print_arch_ascii() {
cat << "EOF"
\e[H\e[2J
           \e[0;36m.
          \e[0;36m/ \
         \e[0;36m/   \      \e[1;37m               #     \e[1;36m| *
        \e[0;36m/^.   \     \e[1;37m a##e #%" a#"e 6##%  \e[1;36m| | |-^-. |   | \ /
       \e[0;36m/  .-.  \    \e[1;37m.oOo# #   #    #  #  \e[1;36m| | |   | |   |  X
      \e[0;36m/  (   ) _\   \e[1;37m%OoO# #   %#e" #  #  \e[1;36m| | |   | ^._.| / \ \e[0;37mTM
     \e[1;36m/ _.~   ~._^\
    \e[1;36m/.^         ^.\ \e[0;37mTM
EOF
}

# Main function to display system information
main() {
    print_arch_ascii
    get_os_info
    get_cpu_info
    get_gpu_info
    get_memory_info
    get_shell_info
    get_de_info

    # Display the fetched information
    echo "OS: $OS $VERSION"
    echo "CPU: $CPU"
    echo "GPU: $GPU"
    echo "Memory: $MEMORY"
    echo "Shell: $SHELL"
    echo "DE: $DE"
}

# Call the main function to display system information
main
