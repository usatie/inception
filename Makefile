include srcs/.env
SRCS_DIR			=	srcs
DOCKER_COMPOSE_YML	=	$(SRCS_DIR)/docker-compose.yml
REQUIREMENTS_DIR	=	$(SRCS_DIR)/requirements
NGINX_DIR			=	$(REQUIREMENTS_DIR)/nginx
ENVFILE				=	$(SRCS_DIR)/.env

RED=\033[0;31m
RESET=\033[0m

.PHONY: all
all: build up

.PHONY: up
up: $(ENVFILE)
	cd $(SRCS_DIR) && docker compose up

.PHONY: build
build: $(ENVFILE)
	mkdir -p $(WP_VOLUME_DIR) $(DB_VOLUME_DIR)
	cd $(SRCS_DIR) && docker compose build

.PHONY: down
down: $(ENVFILE)
	cd $(SRCS_DIR) && docker compose down

.PHONY: clean
clean: $(ENVFILE)
	cd $(SRCS_DIR) && docker compose down -v --rmi all --remove-orphans

.PHONY: fclean
fclean: clean
	rm -rf $(WP_VOLUME_DIR) $(DB_VOLUME_DIR)

.PHONY: re
re: fclean build up

$(ENVFILE):
	@echo "${RED}YOU NEED TO CREATE: srcs/.env${RESET}"
	@echo "${RED}RUN 'cp srcs/.env.sample srcs/.env' AND EDIT VALUES IF NECESSARY.${RESET}"
