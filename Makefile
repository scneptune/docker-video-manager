export $UID = $(id -u)
export $GID = $(id -g)

install_frontend:
	docker-compose run --rm --no-deps sidekiq bash -ci 'yarn install'
install_backend:
	docker compose build sidekiq
