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




sudo systemctl enable --now redis-server

sudo systemctl enable --now pteroq.service



