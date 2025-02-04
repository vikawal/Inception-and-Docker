# 🏗️ Inception - System Administration with Docker  

**Inception** is a system administration project that introduces Docker containerization. The goal is to set up a multi-container environment using Docker Compose, ensuring each service runs in its own container. The project involves deploying NGINX, WordPress, MariaDB, and additional features like Redis caching and FTP.  

Project structure:  
📁 inception/  
│── 📄 README.md  
│── 📄 Makefile  
│── 📁 srcs/  
│   │── 📄 docker-compose.yml  
│   │── 📄 .env  
│   ├── 📁 requirements/  
│   │   ├── 📁 nginx/  
│   │   │   ├── 📄 Dockerfile  
│   │   │   ├── 📁 conf/  
│   │   ├── 📁 wordpress/  
│   │   │   ├── 📄 Dockerfile  
│   │   │   ├── 📁 conf/  
│   │   ├── 📁 mariadb/  
│   │   │   ├── 📄 Dockerfile  
│   │   │   ├── 📁 conf/  
│   │   ├── 📁 bonus/ (optional)  
│── 📁 data/ (Persistent Volumes)  
│── 📁 secrets/ (Hidden credentials)  

Technologies used: Docker & Docker Compose, NGINX (with TLS 1.2/1.3), MariaDB, WordPress + PHP-FPM, Redis (Bonus), FTP Server (Bonus).  

To set up the project, first clone the repository using `git clone https://github.com/your-username/inception.git` and navigate into the directory with `cd inception`. Next, set up the environment variables by editing the `.env` file with values like `DOMAIN_NAME=yourlogin.42.fr`, `DB_NAME=wordpress`, `DB_USER=wpuser`, `DB_PASS=wppass`, `DB_ROOT=rootpass`.  

To build and run the containers, execute `make` or manually run `docker-compose up --build -d`. To verify running containers, use `docker-compose ps`. You can access WordPress via `https://yourlogin.42.fr`, connect to MariaDB with `docker exec -it mariadb mariadb -u root -p`, and check Redis (if enabled) using `docker exec -it redis redis-cli`. To stop and remove containers, run `make fclean` or `docker-compose down -v`.  

Mandatory project requirements include ensuring each service runs in its own container, no ready-made images are used, volumes store WordPress and database data persistently, NGINX is the only entry point via HTTPS (port 443), WordPress communicates with MariaDB using environment variables, and secure database setup with two users.  

Bonus features include Redis caching for WordPress, an FTP server for managing WordPress files, Adminer for database management, and a static HTML website. Security considerations include avoiding passwords in Dockerfiles, using `.env` files for environment variables, and ensuring no infinite loops or unnecessary processes.  

Useful commands for managing the project:  
Check logs: `docker logs nginx`, `docker logs wordpress`, `docker logs mariadb`.  
Enter a running container: `docker exec -it wordpress sh`, `docker exec -it mariadb mariadb -u root -p`.  
List running containers: `docker ps`.

GREAT GUIDE with examples and EXPLANATIONS:
`https://github.com/codesshaman/inception/blob/main/00_INSTALL_SYSTEM.md`
