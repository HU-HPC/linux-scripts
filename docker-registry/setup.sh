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

---------------- Docker Registry script ----------------

EOF

mkdir data

wget https://raw.githubusercontent.com/HU-HPC/linux-scripts/master/docker-registry/config.yml
wget https://raw.githubusercontent.com/HU-HPC/linux-scripts/master/docker-registry/docker-compose.yml

cat << "EOF"

------ Run the following command to start docker registry! ------

docker compose up -d

EOF
