
FIG=docker compose

# Dans la ligne de commande de notre machine, on vérifie si docker-compose est disponible
HAS_DOCKER:=$(shell command -v $(FIG) 2> /dev/null)
# Si c'est le cas, EXEC et EXEC_DB vont permettre d'exécuter des commandes dans les conteneurs
ifdef HAS_DOCKER
	EXEC=$(FIG) exec app
	EXEC_DB=$(FIG) exec db
# Sinon, on exécute les commandes sur la machine locale
else
	EXEC=
	EXEC_DB=
endif

# Ligne de commande du projet Symfony
CONSOLE=php bin/console

check:
	vendor/bin/phpstan

csfix:
	vendor/bin/php-cs-fixer fix

start:
	$(FIG) --env-file .env --env-file .env.local up -d

stop:
	$(FIG) --env-file .env --env-file .env.local down

restart: stop start

update:
	composer install