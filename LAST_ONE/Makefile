name = inception


# Default target when no target is specified
all:
	@printf "Launch configuration ${name}...\n"
	@bash srcs/requirements/wordpress/tools/make_dir.sh
# Run a script to create necessary directories
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d
# Start Docker containers in detached mode


# Build target: Builds and starts containers if necessary
build:
	@printf "Building configuration ${name}...\n"
	@bash srcs/requirements/wordpress/tools/make_dir.sh
# Run the script to create necessary directories
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build
# Build and start the containers


# Down target: Stops the containers
down:
	@printf "Stopping configuration ${name}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env down
# Stop and remove the containers


# Rebuild target: Combines down and build for a full rebuild of containers
re: down
	@printf "Rebuild configuration ${name}...\n"
	@docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build
# Rebuild and start the containers


# Clean target: Stops the containers and removes unused Docker resources
clean: down
	@printf "Cleaning configuration ${name}...\n"
	@docker system prune -a
# Clean up unused Docker images, containers, and networks
	@sudo rm -rf ~/data/wordpress/*
# Delete WordPress data (remove all files inside this directory)
	@sudo rm -rf ~/data/mariadb/*
# Delete MariaDB data (remove all files inside this directory)


# Full clean target: Completely stops everything and removes all Docker resources and volumes
fclean:
	@printf "Total clean of all configurations docker\n"
	@docker stop $$(docker ps -qa)
# Stop all running containers
	@docker system prune --all --force --volumes
# Remove unused containers, images, and volumes
	@docker network prune --force
# Remove unused Docker networks
	@docker volume prune --force
# Remove unused Docker volumes
	@sudo rm -rf ~/data/wordpress/*
# Delete WordPress data (remove all files inside this directory)
	@sudo rm -rf ~/data/mariadb/*
# Delete MariaDB data (remove all files inside this directory)


# Specify targets that do not create actual files (efficient processing)
.PHONY : all build down re clean fclean

