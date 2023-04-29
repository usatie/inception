SRCS_DIR			=	srcs
DOCKER_COMPOSE_YML	=	$(SRCS_DIR)/docker-compose.yml
REQUIREMENTS_DIR	=	$(SRCS_DIR)/requirements
NGINX_DIR			=	$(REQUIREMENTS_DIR)/nginx

.PHONY: up
up:
	cd $(SRCS_DIR) && docker compose build --no-cache
	cd $(SRCS_DIR) && docker compose up

.PHONY: down
down:
	cd $(SRCS_DIR) && docker compose down

.PHONY: sh
sh:
	docker exec -it srcs-inception-server-1 sh
