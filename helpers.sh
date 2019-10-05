        ## Helper Methods ##
#####################################
print_success () {
    green=`tput setaf 2`;
    reset=`tput sgr0`;
    echo -e "${green} $1 ${reset}";
}

print_warning () {
    yellow=`tput setaf 3`;
    reset=`tput sgr0`;
    echo -e "${yellow} $1 ${reset}";
}

print_danger () {
    red=`tput setaf 1`;
    reset=`tput sgr0`;
    echo -e "${red} $1 ${reset}";
}