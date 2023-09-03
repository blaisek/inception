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
	@echo "${GREEN} make vol - Create volumes for data persistence " "if OS is not linux you need to change device path in docker-compose.yml"
	@echo "${GREEN} make host - Add domain to /etc/hosts"
	@echo "${GREEN} make up - build and Start containers"
	@echo "${GREEN} make stop - Stop and remove containers"
	@echo "${GREEN} make re - Restart containers"
	@echo "${GREEN} make clean - stop and Remove containers images volumes and networks"

up:
	@echo "${GREEN}Starting containers.."
	@docker compose -f $(DOCKERCOMPOSE) up -d --build

env: ## Create/Overwrite .env file
	@chmod +x $(ENVSCRIPT)
	@bash $(ENVSCRIPT)

vol: ## Create volume
	@chmod +x $(VOLSCRIPT)
	@bash $(VOLSCRIPT)

host: ## Add domain to /etc/hosts
	@chmod +x $(ADDHOSTSCRIPT)
	@bash $(ADDHOSTSCRIPT)

stop:
	@echo "${RED}Stoping and removing containers.."
	@docker compose -f $(DOCKERCOMPOSE) stop
	@docker compose -f $(DOCKERCOMPOSE) rm


re: stop up
	@echo "${CYAN}Restarted.."

clean:
	@echo "${ORANGE} Stoping and Removing containers images volumes networks.."
	@docker compose -f $(DOCKERCOMPOSE) down --rmi all -v --remove-orphans

fclean: clean
	@echo "${ORANGE} Removing unused images.."
	@docker system prune -a --volumes

.PHONY: all up re stop clean env vol host fclean