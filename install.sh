clear

CYAN="\033[1;36m"
GREEN="\033[1;32m"
WHITE="\033[1;37m"
RESET="\033[0m"

echo -e "${CYAN}"
echo "███╗   ██╗ ██████╗ ██████╗ ███████╗ ██████╗██████╗  █████╗ ████████╗"
echo "████╗  ██║██╔═══██╗██╔══██╗██╔════╝██╔════╝██╔══██╗██╔══██╗╚══██╔══╝"
echo "██╔██╗ ██║██║   ██║██║  ██║█████╗  ██║     ██████╔╝███████║   ██║   "
echo "██║╚██╗██║██║   ██║██║  ██║██╔══╝  ██║     ██╔══██╗██╔══██║   ██║   "
echo "██║ ╚████║╚██████╔╝██████╔╝███████╗╚██████╗██║  ██║██║  ██║   ██║   "
echo "╚═╝  ╚═══╝ ╚═════╝ ╚═════╝ ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   "
echo
echo "██╗  ██╗ ██████╗ ███████╗████████╗██╗███╗   ██╗ ██████╗ "
echo "██║  ██║██╔═══██╗██╔════╝╚══██╔══╝██║████╗  ██║██╔════╝ "
echo "███████║██║   ██║███████╗   ██║   ██║██╔██╗ ██║██║  ███╗"
echo "██╔══██║██║   ██║╚════██║   ██║   ██║██║╚██╗██║██║   ██║"
echo "██║  ██║╚██████╔╝███████║   ██║   ██║██║ ╚████║╚██████╔╝"
echo "╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝ "
echo -e "${RESET}"

echo -e "${GREEN}============================================================${RESET}"
echo -e "${WHITE}           NODECRAT HOSTING INSTALLER v1.0${RESET}"
echo -e "${WHITE}        Automatic Pterodactyl Panel Installer${RESET}"
echo -e "${GREEN}============================================================${RESET}"
echo
echo
echo -ne "\033[1;32mInstalling NODECRAT"
sleep 1
echo -ne "."
sleep 1
echo -ne "."
sleep 1
echo -ne "."
sleep 1
echo -ne "."
sleep 1
echo -e " Done!\033[0m"

echo -ne "\033[1;32mInstalling NODECRAT... \033[0m"

for i in {1..20}; do
    for s in "/" "-" "\\" "|"; do
        echo -ne "\r\033[1;32mInstalling NODECRAT... $s\033[0m"
        sleep 0.25
    done
done

echo -e "\r\033[1;32mInstalling NODECRAT... ✔ Done!\033[0m"

echo "Checking operating system..."
sleep 1
echo "Preparing installer..."
sleep 1
echo
echo "Welcome to NODECRAT HOSTING"
apt update
apt install -y nginx
echo "Done!"

# Add "add-apt-repository" command
apt -y install software-properties-common curl apt-transport-https ca-certificates gnupg

# Add additional repositories for PHP (Ubuntu 22.04)
LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php

# Add Redis official APT repository
curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list

# Update repositories list
apt update

# Install Dependencies
apt -y install php8.3 php8.3-{common,cli,gd,mysql,mbstring,bcmath,xml,fpm,curl,zip} mariadb-server nginx tar unzip git redis-server




#dontty


mkdir -p /var/www/pterodactyl
cd /var/www/pterodactyl



#donty endy



curl -Lo panel.tar.gz https://github.com/pterodactyl/panel/releases/latest/download/panel.tar.gz
tar -xzvf panel.tar.gz
chmod -R 755 storage/* bootstrap/cache/







cp .env.example .env
COMPOSER_ALLOW_SUPERUSER=1 composer install --no-dev --optimize-autoloader

# Only run the command below if you are installing this Panel for
# the first time and do not have any Pterodactyl Panel data in the database.
php artisan key:generate --force








php artisan p:environment:setup
php artisan p:environment:database

# To use PHP's internal mail sending (not recommended), select "mail". To use a
# custom SMTP server, select "smtp".
php artisan p:environment:mai








php artisan migrate --seed --force









php artisan p:user:make




# If using NGINX, Apache or Caddy (not on RHEL / Rocky Linux / AlmaLinux)
chown -R www-data:www-data /var/www/pterodactyl/*

# If using NGINX on RHEL / Rocky Linux / AlmaLinux
chown -R nginx:nginx /var/www/pterodactyl/*

# If using Apache on RHEL / Rocky Linux / AlmaLinux
chown -R apache:apache /var/www/pterodactyl/*






* * * * * php /var/www/pterodactyl/artisan schedule:run >> /dev/null 2>&1





# Pterodactyl Queue Worker File
# ----------------------------------

[Unit]
Description=Pterodactyl Queue Worker
After=redis-server.service

[Service]
# On some systems the user and group might be different.
# Some systems use `apache` or `nginx` as the user and group.
User=www-data
Group=www-data
Restart=always
ExecStart=/usr/bin/php /var/www/pterodactyl/artisan queue:work --queue=high,standard,low --sleep=3 --tries=3
StartLimitInterval=180
StartLimitBurst=30
RestartSec=5s

[Install]
WantedBy=multi-user.target









sudo systemctl enable --now redis-server

sudo systemctl enable --now pteroq.service



























dane@pterodactyl:~$ sudo dmidecode -s system-manufacturer
VMware, Inc.





curl -sSL https://get.docker.com/ | CHANNEL=stable bash





sudo systemctl enable --now docker

GRUB_CMDLINE_LINUX_DEFAULT="swapaccount=1"





sudo mkdir -p /etc/pterodactyl
curl -L -o /usr/local/bin/wings "https://github.com/pterodactyl/wings/releases/latest/download/wings_linux_$([[ "$(uname -m)" == "x86_64" ]] && echo "amd64" || echo "arm64")"
sudo chmod u+x /usr/local/bin/wings




sudo wings --debug







[Unit]
Description=Pterodactyl Wings Daemon
After=docker.service
Requires=docker.service
PartOf=docker.service

[Service]
User=root
WorkingDirectory=/etc/pterodactyl
LimitNOFILE=4096
PIDFile=/var/run/wings/daemon.pid
ExecStart=/usr/local/bin/wings
Restart=on-failure
StartLimitInterval=180
StartLimitBurst=30
RestartSec=5s

[Install]
WantedBy=multi-user.target





sudo systemctl enable --now wings



curl -L -O https://raw.githubusercontent.com/XpartFrags/janina/refs/heads/main/database.sql

chmod +x panel.sh



echo "Starting panel installer..."



bash panel.sh
