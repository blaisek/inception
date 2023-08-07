# COLORS
GREEN		= \033[1;32m
RED 		= \033[1;31m
ORANGE		= \033[1;33m
CYAN		= \033[1;36m

# VARIABLES
ENVSCRIPT = ./srcs/requirements/tools/envGen.sh
DOCKERCOMPOSE = ./srcs/docker-compose.yml

all: env
	@echo "${GREEN}Starting containers.."
	@docker compose -f $(DOCKERCOMPOSE) up -d --build

env: ## Create/Overwrite .env file
	chmod + x $(ENVSCRIPT)
	@bash $(ENVSCRIPT)

host: ## Add domain to /etc/hosts
	@bash ./srcs/requirements/tools/add-host.sh

down:
	@echo "${RED}Stoping containers.." 
	@docker compose -f $(DOCKERCOMPOSE) down

re:
	@echo "${CYAN}Reset.."
	@docker compose -f $(DOCKERCOMPOSE) up -d --build

clean:
	@echo "${ORANGE}Stoping and Removing containers.."
	@docker stop $$(docker ps -qa);\ 
	docker rm $$(docker ps -qa);\
	docker rmi -f $$(docker images -qa);\
	docker volume rm $$(docker volume ls -q);\
	docker network rm $$(docker network ls -q);\

	.PHONY: all re down clean env host
