# If using MariaDB (v11.0.0+)
mariadb -u root -p

# If using MySQL
mysql -u root -p



# Remember to change 'somePassword' below to be a unique password specific to this account.
CREATE USER 'pterodactyl'@'127.0.0.1' IDENTIFIED BY 'somePassword';



CREATE DATABASE panel;

GRANT ALL PRIVILEGES ON panel.* TO 'pterodactyl'@'127.0.0.1';


# You should change the username and password below to something unique.
CREATE USER 'pterodactyluser'@'127.0.0.1' IDENTIFIED BY 'somepassword';




GRANT ALL PRIVILEGES ON *.* TO 'pterodactyluser'@'127.0.0.1' WITH GRANT OPTION;




[mysqld]
bind-address=0.0.0.0

