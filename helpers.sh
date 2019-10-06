        ## Helper Methods ##
#####################################
print () {
    reset=`tput sgr0`;
    for msg in "$@"; do
        echo -e "${color} $msg ${reset}";
    done
}

print_success () {
    color=`tput setaf 2`; # green
    print $color "$@"
}

print_warning () {
    color=`tput setaf 3`; # yellow
    print $color "$@"
}

print_danger () {
    color=`tput setaf 1`; # red
    print $color "$@"
}