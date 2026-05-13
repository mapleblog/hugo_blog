# Formbricks ( Survey System )

[Formbricks Official Website](https://formbricks.com/docs/self-hosting/overview)

---

### Docker Setup

1. ```bash
   mkdir formbricks-quickstart && cd formbricks-quickstart
   ```

2. ```bash
   curl -o docker-compose.yml https://raw.githubusercontent.com/formbricks/formbricks/stable/docker/docker-compose.yml
   ```

3. ```bash
   # Generate NextAuth Secret
   sed -i "/NEXTAUTH_SECRET:$/s/NEXTAUTH_SECRET:.*/NEXTAUTH_SECRET: $(openssl rand -hex 32)/" docker-compose.yml
   
   # Generate Encryption Key
   sed -i '' "s/NEXTAUTH_SECRET:.*/NEXTAUTH_SECRET: $(openssl rand -hex 32)/" docker-compose.yml
   
   # Generate Cron Secret
   sed -i "/ENCRYPTION_KEY:$/s/ENCRYPTION_KEY:.*/ENCRYPTION_KEY: $(openssl rand -hex 32)/" docker-compose.yml
   ```

4. **Configure docker compose.yaml**

   ```bash
   # Generate a New Key
   openssl rand -hex 32
   
   NEXTAUTH_SECRET: REQUIRED_OPENSSL_KEY
   ENCRYPTION_KEY: REQUIRED_OPENSSL_KEY
   CRON_SECRET: REQUIRED_OPENSSL_KEY
   
   ---
   
   WEBAPP_URL: http://SERVER_IP:3000
   NEXTAUTH_URL: http://SERVER_IP:3000
   
   ```

5. **Start the Docker Setup**

   ```bash
   docker compose up -d
   ```

   