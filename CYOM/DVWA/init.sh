#! /bin/bash

cat << "EOF"


 /$$   /$$ /$$   /$$       /$$   /$$ /$$$$$$$   /$$$$$$ 
| $$  | $$| $$  | $$      | $$  | $$| $$__  $$ /$$__  $$
| $$  | $$| $$  | $$      | $$  | $$| $$  \ $$| $$  \__/
| $$$$$$$$| $$  | $$      | $$$$$$$$| $$$$$$$/| $$      
| $$__  $$| $$  | $$      | $$__  $$| $$____/ | $$      
| $$  | $$| $$  | $$      | $$  | $$| $$      | $$    $$
| $$  | $$|  $$$$$$/      | $$  | $$| $$      |  $$$$$$/
|__/  |__/ \______/       |__/  |__/|__/       \______/

----------------  DVWA Install script ----------------

Github Link: https://github.com/digininja/DVWA

EOF

# Confirmation prompt
read -p "Do you want to proceed with the installation? (y/n): " choice

# Check the user's choice
if [[ $choice =~ ^[Yy]$ ]]; then

	# update kali
	apt update
	
	# install gd
	apt install php-gd -y
	
	# set vars
	workdir="/var/www/html"
	
	# Clone the repo
	git clone https://github.com/digininja/DVWA.git
	
	# Move the repo
	mv DVWA "$workdir"
	
	# start apache http service
	service apache2 start
	
	# copy the files
	cp "$workdir/DVWA/config/config.inc.php.dist" "$workdir/DVWA/config/config.inc.php"
	
	# start database
	service mariadb start
	
	# Create the database
	mysql -e "CREATE DATABASE dvwa;"
	mysql -e "CREATE USER 'dvwa'@'localhost' IDENTIFIED BY 'p@ssw0rd';"
	mysql -e "GRANT ALL ON dvwa.* TO 'dvwa'@'localhost';"
	mysql -e "FLUSH PRIVILEGES;"
	
	# Check if the php.ini file exists
	if [[ -f /etc/php/8.2/apache2/php.ini ]]; then
	    # Update the allow_url_include directive (needs to be updated if php verson changes)
	    sudo sed -i 's/allow_url_include = Off/allow_url_include = On/g' /etc/php/8.2/apache2/php.ini
	service apache2 restart
	    echo "allow_url_include directive has been updated."
	else
	    echo "php.ini file not found."
	fi
	cat << "EOF"
================== END OF SCRIPT ==================
	
Visit http://localhost/DVWA/setup.php and click "Create/Reset Database" to complete setup.
	
EOF

else
    echo "Installation aborted."
fi
