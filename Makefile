# COLORS
GREEN		= \033[1;32m
RED 		= \033[1;31m
ORANGE		= \033[1;33m
CYAN		= \033[1;36m

# VARIABLES
ENVSCRIPT = ./srcs/requirements/tools/envGen.sh
VOLSCRIPT = ./srcs/requirements/tools/volGen.sh
ADDHOSTSCRIPT = ./srcs/requirements/tools/addHost.sh
DOCKERCOMPOSE = ./srcs/docker-compose.yml

all:
	@echo "${GREEN} make env - Create/Overwrite .env file"
	@echo "${GREEN} make vol - Create volumes"
	@echo "${GREEN} make host - Add domain to /etc/hosts"
	@echo "${GREEN} make up - build and Start containers"
	@echo "${GREEN} make down - Stop containers"
	@echo "${GREEN} make re - Restart containers"
	@echo "${GREEN} make clean - Remove images and volumes"

up:
	@echo "${GREEN}Starting containers.."
	@docker compose -f $(DOCKERCOMPOSE) up -d --build

env: ## Create/Overwrite .env file
	@chmod +x $(ENVSCRIPT)
	@bash $(ENVSCRIPT)

vol: ## Create/Overwrite .env file
	@chmod +x $(VOLSCRIPT)
	@bash $(VOLSCRIPT)

host: ## Add domain to /etc/hosts
	@chmod +x $(ADDHOSTSCRIPT)
	@bash $(ADDHOSTSCRIPT)

down:
	@echo "${RED}Stoping containers.." 
	@docker compose -f $(DOCKERCOMPOSE) down #--remove-orphans --rmi all

re: down up
	@echo "${CYAN}Restarted.."

clean: down
	@echo "${ORANGE}Removing images.."
	@docker rmi -f $$(docker images -q)
	@echo "${ORANGE}Removing volumes.."
	@docker volume rm $$(docker volume ls -q)


	.PHONY: all up re down clean env vol host
