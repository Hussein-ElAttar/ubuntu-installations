#Git
#--------------------
apt update;
apt install -y git;

#MySQL
#--------------------

apt update;
apt install -y mysql-server mysql-client;
systemctl start mysql;
echo -n Please enter your current mysql root password(if you have one):;
read -s password;
echo -n Please enter your new mysql root password:;
read -s newpassword;

mysql -u root -p${password} -e "
    DROP USER 'root'@'localhost';
    CREATE USER 'root'@'localhost' IDENTIFIED BY '${newpassword}';
    GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
    FLUSH PRIVILEGES;
";


#PHP + Apache2
#--------------------
apt update;
apt install -y php7.2-bcmath php7.2-curl php7.2-gd php7.2-json php7.2-opcache php7.2-recode php7.2-tidy php7.2-bz2 php7.2-dba php7.2-gmp php7.2-ldap php7.2-pgsql php7.2-snmp php7.2-xml php7.2-mbstring php7.2-soap php7.2-cli php7.2-mysql php7.2-common php7.2-intl php7.2-zip;
apt install -y apache2;
apt-get install -y php php-cgi libapache2-mod-php php-common php-pear php-mbstring;
a2enconf php7.2-cgi;
systemctl reload apache2.service;
apt-get install -y phpmyadmin php-gettext;
echo "Include /etc/phpmyadmin/apache.conf" >> /etc/apache2/apache2.conf;
/etc/init.d/apache2 restart;
service apache2 restart;
# FIX: count(): Parameter must be an array or an object that implements Countable;
sed -i s/"')))"/"'))"/g /usr/share/phpmyadmin/libraries/sql.lib.php;
sed -i s/"] == 1)"/"]) == 1)"/g /usr/share/phpmyadmin/libraries/sql.lib.php;


#Mongodb
#--------------------
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -;
echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list;
sudo apt-get update;
sudo apt-get install -y mongodb-org;
echo "mongodb-org hold" | sudo dpkg --set-selections
echo "mongodb-org-server hold" | sudo dpkg --set-selections
echo "mongodb-org-shell hold" | sudo dpkg --set-selections
echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
echo "mongodb-org-tools hold" | sudo dpkg --set-selections

#Mongodb ext via pecl
#--------------------
sudo apt-get install libcurl4-openssl-dev pkg-config libssl-dev;
sudo pecl install mongodb;
sed -i '2i\extension=mongodb.so\' /etc/php/7.2/cli/php.ini;

#Composer And laravel
#--------------------
apt update;
apt install -y wget php-cli php-zip unzip curl;
curl -sS https://getcomposer.org/installer |php;
mv composer.phar /usr/local/bin/composer;
composer global require "laravel/installer";

#OH-My-Zsh;
#----------
apt update;
apt install zsh;
chsh -s /bin/zsh;
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh;
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc;
echo 'export PATH=$HOME/.config/composer/vendor/bin:$PATH' >> ~/.zshrc;
source ~/.zshrc;

#Nodejs
#--------------------;
apt update;
apt install -y nodejs;
apt install -y npm;
npm cache clean -f;
npm install -yg n;
n stable;
ln -sf /usr/local/n/versions/node/10.16.0/bin/node /usr/bin/node;


#VsCode
#-----
apt update;
apt install -y software-properties-common apt-transport-https wget;
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add -;
add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main";
apt update;
apt install -y code;


#GNOME TWEAKS
#------------
apt update;
apt install -y gnome-tweak-tool;

#PAPER THEME
#-----------
add-apt-repository ppa:snwh/ppa;
apt-get install -y paper-icon-theme;

#FIX POSTMAN NOT SYNCING
#-----------
sudo snap switch --channel=candidate postman
sudo snap refresh postman