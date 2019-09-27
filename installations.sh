#!/bin/bash

install_git () {
    apt update;
    apt install -y git;
}

add_my_sql_root_password () {
    echo -n Please enter your new mysql root password\;
    read -s newpassword </dev/tty;
    sudo mysql -u root -e "
        DROP USER 'root'@'localhost';
        CREATE USER 'root'@'localhost' IDENTIFIED BY '${newpassword}';
        GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
        FLUSH PRIVILEGES;
    ";
}

install_my_sql () {
    apt update;
    apt install -y mysql-server mysql-client;
    service mysql start
    add_my_sql_root_password;
}

install_php () {
    apt update;
    apt install -y php7.2-bcmath php7.2-curl php7.2-gd php7.2-json php7.2-opcache php7.2-recode
    apt install -y php7.2-tidy php7.2-bz2 php7.2-dba php7.2-gmp php7.2-ldap php7.2-pgsql php7.2-snmp 
    apt install -y php7.2-xml php7.2-mbstring php7.2-soap php7.2-cli php7.2-mysql php7.2-common php7.2-intl php7.2-zip;
    apt install -y php7.2 php7.2-cgi libapache2-mod-php php7.2-common php7.2-pear php7.2-mbstring php7.2-gettext;
}

install_apache () {
    apt install -y apache2 </dev/tty;
    a2enconf php7.2-cgi;
    service apache2 reload;
}

install_phpmyadmin () {
    apt-get install -y phpmyadmin;
    apache2_conf_file='/etc/apache2/apache2.conf';
    added_conf='Include /etc/phpmyadmin/apache.conf';
    grep -qF -- "$added_conf" "$apache2_conf_file" || echo "$added_conf" >> "$apache2_conf_file";
    service apache2 restart;
    # FIX: count(): Parameter must be an array or an object that implements Countable;
    sudo sed -i "s/|\s*\((count(\$analyzed_sql_results\['select_expr'\]\)/| (\1)/g" /usr/share/phpmyadmin/libraries/sql.lib.php;
}

install_mongo () {
    wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -;
    echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list;
    apt-get update;
    apt-get install -y mongodb-org;
    echo "mongodb-org hold" | sudo dpkg --set-selections;
    echo "mongodb-org-server hold" | sudo dpkg --set-selections;
    echo "mongodb-org-shell hold" | sudo dpkg --set-selections;
    echo "mongodb-org-mongos hold" | sudo dpkg --set-selections;
    echo "mongodb-org-tools hold" | sudo dpkg --set-selections;
}

install_mongo_php_extension () {
    apt-get install libcurl4-openssl-dev pkg-config libssl-dev;
    pecl install mongodb;
    file='/etc/php/7.2/cli/php.ini';
    line='extension=mongodb.so';
    if ! grep -qF "$line" $file ; then sed -i "2i$line" $file; fi
}

install_composer () {
    apt update;
    apt install -y wget php-cli php-zip unzip curl;
    curl -sS https://getcomposer.org/installer |php;
    mv composer.phar /usr/local/bin/composer;
}

install_laravel () {
    composer global require "laravel/installer";
}

install_oh_my_zsh () {
    apt update;
    apt install -y zsh;
    chsh -s /bin/zsh;
    wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh;
    cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc;
    echo 'export PATH=$HOME/.config/composer/vendor/bin:$PATH' >> ~/.zshrc;
    source ~/.zshrc;
}

install_nodejs () {
    apt update;
    apt install -y nodejs;
    apt install -y npm;
    npm cache clean -f;
    npm install -yg n;
    n stable;
    ln -sf /usr/local/n/versions/node/10.16.0/bin/node /usr/bin/node;
}

install_vscode () {
    apt update;
    apt install -y software-properties-common apt-transport-https wget;
    wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add -;
    add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main";
    apt update;
    apt install -y code;
}

install_genome_tweaks () {
    apt update;
    apt install -y gnome-tweak-tool;
}