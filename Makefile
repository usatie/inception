SRCS_DIR			=	srcs
DOCKER_COMPOSE_YML	=	$(SRCS_DIR)/docker-compose.yml
REQUIREMENTS_DIR	=	$(SRCS_DIR)/requirements
NGINX_DIR			=	$(REQUIREMENTS_DIR)/nginx
ENVFILE				=	$(SRCS_DIR)/.env

.PHONY: re
re: clean build up

.PHONY: clean
clean:
	cd $(SRCS_DIR) && docker compose down -v --rmi all --remove-orphans

.PHONY: up
up: $(ENVFILE)
	cd $(SRCS_DIR) && docker compose up

.PHONY: build
build: $(ENVFILE)
	cd $(SRCS_DIR) && docker compose build

.PHONY: down
down:
	cd $(SRCS_DIR) && docker compose down

$(ENVFILE):
	cp $(ENVFILE).sample $(ENVFILE)
