### 1. Setup Docker Registry | Also enables pull through cache

Make sure your user is in the docker group first.
```bash
sudo usermod -aG docker $USER
su $USER
```

Create a directory for your registry
```bash
mkdir docker-registry && cd docker-registry
```

Download docker-compose and config files and set up the data folder.
```bash
curl -O https://raw.githubusercontent.com/HU-HPC/linux-scripts/master/docker-registry/setup.sh && chmod +x setup.sh && ./setup.sh
```

Run docker compose.
```bash
docker compose up -d
```
