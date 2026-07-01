+++
title = 'Ubuntu 22.04'
date = 2025-10-16T21:39:45+08:00
draft = true
slug = "45e4824"
description = ""
summary = ""
tags = [ "技术", "开发" ]
categories = [ "tech" ]
cover = ""
author = "MapleScraps"

+++

# Linux Ubuntu

### 基础操作命令
> 


### 安装 docker & docker compose
> 1. 移除旧的docker版本
>> ```bash
>> sudo apt remove $(dpkg --get-selections docker.io docker-compose docker-compose-v2 docker-doc podman-docker containerd runc | cut -f1)
>> ```
>

> 2. Set up Docker's `apt` repository.
> > ```bash
> > # Add Docker's official GPG key:
> > sudo apt update
> > sudo apt install ca-certificates curl
> > sudo install -m 0755 -d /etc/apt/keyrings
> > sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o 
> > /etc/apt/keyrings/docker.asc
> > sudo chmod a+r /etc/apt/keyrings/docker.asc
> > 
> > # Add the repository to Apt sources:
> > sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
> > Types: deb
> > URIs: https://download.docker.com/linux/ubuntu
> > Suites: $(. /etc/os-release && echo 
> > "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
> > Components: stable
> > Signed-By: /etc/apt/keyrings/docker.asc
> > EOF
> > 
> > sudo apt update
> > ```
>

> 3. Install the Docker packages.
>> ```bash
>> sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
>> ```
> 

> [!NOTE]
> The Docker service starts automatically after installation. To verify that Docker is running, use:
> ```bash
> sudo systemctl status docker
> ```
> Some systems may have this behavior disabled and will require a manual start:
> ```bash
> sudo systemctl start docker
> ```
> ---

> 4. Verify that the installation is successful by running the `hello-world` image:
>> ```bash
>> sudo docker run hello-world
>> ```
>

> [!TIP]
> - docker-compose 属于旧版本，新版本docker compose 之间没有杠 -
> 

## Install Tactical RMM
> [!IMPORTANT]
> Prepare a **Ubuntu Server 22.04 ( Only support 22.04 for Ubuntu )**
> 
> **Required:** Create TXT in DNS manager
> - api.domain.com
> - mesh.domain.com
> - rmm.domain.com
> 
> **Required:** Create A record in DNS manager
> - api.domain.com | server's public-IP | DNS only
> - mesh.domain.com | server's public-IP | DNS only
> - rmm.domain.com | server's public-IP | DNS only
> 

:one: Go to [Tactical Github](https://github.com/amidaware/tacticalrmm)
:two: Refer documentation --> RMM Server Installation --> Traditional Install
:three: Follow the instruction to installing and configuring RMM 



## Ubuntu Offline when startup, but Wi-Fi shows connected

1. `sudo nmcli networking off && sudo nmcli networking on`
2. Disable Wi-Fi Power Saving (If using Wi-Fi) 

NetworkManager aggressively enables power saving by default. To turn it off:
a. Open the configuration file with your editor:

```bash
sudo nano /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf
```

b. Locate the `wifi.powersave` line and change the value from `3` (enabled) to `2` (disabled). It should look like this:
```text
[connection]
wifi.powersave = 2
```

c. Save and close the file, then restart the network manager:
```bash
sudo systemctl restart NetworkManager
```



---



## Ubuntu Offline when startup, but Ethernet shows connected

1. Install `ethtool` if you don't have it:
   ```bash
   sudo apt install ethtool
   ```

2. Find your Ethernet interface name (e.g., `eth0` or `enp3s0`) by running:
   ```bash
   ip -br link
   ```

3. Disable EEE on that specific interface (replace `eth0` with your actual interface name):
   ```bash
   sudo ethtool --set-eee eth0 eee off
   ```

