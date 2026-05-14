# SnipeIT Asset Management

## Docker Setup

1. ```bash
   sudo apt update
   sudo apt install ca-certificates curl gnupg lsb-release -y
   
   # Add Docker’s official GPG key
   sudo mkdir -p /etc/apt/keyrings
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
   
   # Set up the repository
   echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
   
   sudo apt update
   sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
   
   ```

2. ```bash
   mkdir ~/snipe-it-docker && cd ~/snipe-it-docker
   ```

3. nano .env

   Copy and paste the following, replacing the placeholders with your own values:
   ```bash
   # Basic App Settings
   APP_URL=http://your_server_ip:8000
   APP_TIMEZONE=UTC
   APP_LOCALE=en
   APP_KEY=  # We will generate this in Step 5
   
   # Database Settings
   DB_CONNECTION=mysql
   DB_HOST=db
   DB_DATABASE=snipeit
   DB_USERNAME=snipeit_user
   DB_PASSWORD=YOUR_SECURE_PASSWORD
   DB_PORT=3306
   MYSQL_ROOT_PASSWORD=YOUR_ROOT_PASSWORD
   
   # Docker Specific
   APP_PORT=8000
   APP_DEBUG=false
   
   ```

4. **Create the docker-compose.yml**
   sudo vim docker-compose.yml

   ```yaml
   services:
     db:
       image: mariadb:10.11
       container_name: snipe-db
       restart: always
       volumes:
         - snipedb-data:/var/lib/mysql
       environment:
         - MYSQL_DATABASE=snipeit
         - MYSQL_USER=snipeit_user
         - MYSQL_PASSWORD=${DB_PASSWORD}
         - MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}
   
     snipeit:
       image: snipe/snipe-it:latest
       container_name: snipe-app
       restart: always
       depends_on:
         - db
       ports:
         - "${APP_PORT}:80"
       volumes:
         - snipe-data:/var/lib/snipeit
       env_file:
         - .env
   
   volumes:
     snipedb-data:
     snipe-data:
   
   ```

   

5. **Generate the App Key**

   1. **Pull the images:**

      ```bash
      sudo docker compose pull
      ```

   2. **Generate the key:**

      ```bash
      sudo docker compose run --rm snipeit php artisan key:generate --show
      ```

   3. **Update your .env:**

      ```bash
      Copy the string it spits out (starting with base64:) and paste it into your .env file next to APP_KEY=.
      ```

6. **Launch Snipe-IT**

   ```bash
   sudo docker compose up -d
   ```

7. **Final Web Configuration**

   1. Open your browser and go to http://your_server_ip:8000.
   2. The **Pre-flight** page will appear. Since we are using Docker, the permissions and extensions are already handled inside the image.
   3. Click **Next: Create Database Tables**.
   4. Follow the prompts to create your **Admin User** and company settings.

8. 

   