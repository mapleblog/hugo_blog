## Docker Concepts

1. Remove conflict packages first
   ```bash
   sudo apt remove $(dpkg --get-selections docker.io docker-compose docker-compose-v2 docker-doc podman-docker containerd runc | cut -f1)
   ```

2. Download and install docker repo

```bash
# Add Docker's official GPG key:
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

sudo apt update
```

3. Install latest cersion
   ```bash
   sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
   ```

   > [!NOTE]
   >
   > After installation, verify that Docker is running:
   >
   > ```console
   >  sudo systemctl status docker
   > ```
   >
   > If Docker is not running, start it manually:
   >
   > ```console
   >  sudo systemctl start docker
   > ```



---


### Operation command

1. docker images
2. docker ps -la
3. docker compose up -d
4. docker compose down
5. docker exec -it <docker_deamon> bash
6. 