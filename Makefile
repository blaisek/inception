# COLORS
GREEN		= \033[1;32m
RED 		= \033[1;31m
ORANGE		= \033[1;33m
CYAN		= \033[1;36m

# VARIABLES
ENVSCRIPT = ./srcs/requirements/tools/envGen.sh
DOCKERCOMPOSE = ./srcs/docker-compose.yml

all: env up

up:
	@echo "${GREEN}Starting containers.."
	@docker compose -f $(DOCKERCOMPOSE) up -d --build


env: ## Create/Overwrite .env file
	@chmod +x $(ENVSCRIPT)
	-bash $(ENVSCRIPT)

down:
	@echo "${RED}Stoping containers.." 
	@docker compose -f $(DOCKERCOMPOSE) down #--remove-orphans --rmi all

re: 
	@docker compose -f $(DOCKERCOMPOSE) restart
	@echo "${CYAN}Restarted.."

clean: down
	@echo "${ORANGE}Removing containers.."
	@docker rmi -f $$(docker images -q)
	@echo "${ORANGE}Removing volumes.."
	@docker volume rm $$(docker volume ls -q)


	.PHONY: all up re down clean env