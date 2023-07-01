#!/bin/bash

# Installation script

# Update packages and install build tools and development packages
sudo apt update
sudo apt-get install -y build-essential autoconf automake libtool pkg-config cmake git make gcc m4 libltdl7 libltdl-dev libxml2-dev libxml++2.6-dev zlib1g-dev gettext nasm yasm php-cli php-fpm php-curl php-gd php-mysql php-mbstring php-xml perl git

echo "Build tools and Development packages installed."

# Install Composer
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

echo "PHP, Perl, Composer, and Git installed."

# Install web server
echo "Please select a web server to install:"
echo "1. Apache"
echo "2. Nginx"
read -p "Enter your choice (1 or 2): " choice

if [ "$choice" == "1" ]; then
    # Install Apache with -y flag
    sudo apt install -y apache2

    # Enable Apache service
    sudo systemctl enable apache2
    sudo systemctl start apache2

    echo "Apache installed and started."
elif [ "$choice" == "2" ]; then
    # Install Nginx with -y flag
    sudo apt install -y nginx

    # Enable Nginx service
    sudo systemctl enable nginx
    sudo systemctl start nginx

    echo "Nginx installed and started."
else
    echo "Invalid choice. No web server installed."
    exit 1
fi

echo "Web server installation completed."

# Install database server
echo "Please select a database server to install:"
echo "1. MySQL"
echo "2. MariaDB"
echo "3. PostgreSQL"
read -p "Enter your choice (1, 2, or 3): " choice

if [ "$choice" == "1" ]; then
    read -p "Do you want to install MySQL? (y/n): " install_mysql
    if [ "$install_mysql" == "y" ]; then
        # Install MySQL
        sudo apt install -y mysql-server

        echo "MySQL installed."
    else
        echo "MySQL installation skipped."
    fi
elif [ "$choice" == "2" ]; then
    read -p "Do you want to install MariaDB? (y/n): " install_mariadb
    if [ "$install_mariadb" == "y" ]; then
        # Install MariaDB
        sudo apt install -y mariadb-server

        echo "MariaDB installed."
    else
        echo "MariaDB installation skipped."
    fi
elif [ "$choice" == "3" ]; then
    read -p "Do you want to install PostgreSQL? (y/n): " install_postgresql
    if [ "$install_postgresql" == "y" ]; then
        # Install PostgreSQL
        sudo apt install -y postgresql

        echo "PostgreSQL installed."
    else
        echo "PostgreSQL installation skipped."
    fi
else
    echo "Invalid choice. No database server installed."
    exit 1
fi

echo "Database server installation completed."

# Check if Apache is installed
if [ -x "$(command -v apache2)" ]; then
    echo "Apache web server is installed."

    # Install Apache modules
    sudo apt install -y libapache2-mod-php

    echo "Apache modules installed."
fi

# Check if Nginx is installed
if [ -x "$(command -v nginx)" ]; then
    echo "Nginx web server is installed."

    # Install Nginx modules
    sudo apt install -y nginx-extras

    echo "Nginx modules installed."
fi

echo "Module installation completed."

# Install phpMyAdmin
sudo apt install -y phpmyadmin

# Configure phpMyAdmin
sudo tee /etc/apache2/conf-available/phpmyadmin.conf > /dev/null <<EOF
Alias /phpmyadmin /usr/share/phpmyadmin
<Directory /usr/share/phpmyadmin>
    Options FollowSymLinks
    DirectoryIndex index.php
    AllowOverride All
</Directory>
EOF

# Enable phpMyAdmin configuration
sudo ln -s /etc/apache2/conf-available/phpmyadmin.conf /etc/apache2/conf-enabled/phpmyadmin.conf

# Restart Apache
sudo systemctl restart apache2

echo "phpMyAdmin installed, configured, and Apache restarted."

echo "Installation completed!"

# MySQL configuration
mysql -u root <<EOF
CREATE USER 'lalatendu'@'localhost' IDENTIFIED BY 'Password~!@594';
GRANT ALL PRIVILEGES ON myapp_db.* TO 'lalatendu'@'localhost';
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Password~!@594';
FLUSH PRIVILEGES;
EOF
