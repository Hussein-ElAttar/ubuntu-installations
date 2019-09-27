#!/bin/bash
if [[ $(id -u) -ne 0 ]] ; then echo "Please run as root" ; exit 1 ; fi

my_dir="$(dirname "$0")"

source $my_dir/installations.sh

rm -f ./a984j1a324lk852.tmp

# Menu Options
menu[0]="Git"
menu[1]="MySQL"
menu[2]="PHP 7.2"
menu[3]="Apache - PhpMyAdmin"
menu[4]="Mongo"
menu[5]="Mongo PHP Extension"
menu[6]="Composer"
menu[7]="Laravel Composer"
menu[8]="Oh My Zsh"
menu[9]="NodeJs 10.16"
menu[10]="Vscode"
menu[11]="Gnome tweaks"
menu[12]="Paper themes"
menu[13]="Add MySql root password"

# Actions
declare -A actions
actions["${menu[0]}"]="install_git"
actions["${menu[1]}"]="install_my_sql"
actions["${menu[2]}"]="install_php"
actions["${menu[3]}"]="install_apache_with_php_my_admin"
actions["${menu[4]}"]="install_mongo"
actions["${menu[5]}"]="install_mongo_php_extension"
actions["${menu[6]}"]="install_composer"
actions["${menu[7]}"]="install_laravel"
actions["${menu[8]}"]="install_oh_my_zsh"
actions["${menu[9]}"]="install_nodejs"
actions["${menu[10]}"]="install_vscode"
actions["${menu[11]}"]="install_genome_tweaks"
actions["${menu[12]}"]="install_paper_theme"

for Option in "${menu[@]}"; do
    whiptailArray+=("$Option" " " off)
done
whiptail --title "Test" --checklist --separate-output "Choose:" 20 78 15 "${whiptailArray[@]} | sort -n" 2>a984j1a324lk852.tmp

while read choice
do
    ${actions["$choice"]}
done < a984j1a324lk852.tmp

rm ./a984j1a324lk852.tmp
