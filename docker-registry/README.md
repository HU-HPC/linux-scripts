## Setup Basic Docker Registry without Auth.
Use this only in a private network.

### 1. Setup Docker Registry | Also enables pull-through cache [Server]

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
### 2. Set up daemon on client devices [Client]
Create `/etc/docker/daemon.json` file and add the following data to it.

```json
{
  "insecure-registries" : ["http://server-host:port"]
}
```

### How to pull images using the registry

All default images on hub.docker.com such as nginx or ubuntu are part of the library user/org.<br>
Here is an example for [nginx](https://https://hub.docker.com/_/nginx) docker image
```bash
docker pull host:port/library/nginx
```

