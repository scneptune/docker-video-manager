install_frontend:
	docker-compose run --rm --no-deps --user="$(id -u):$(id -g)" sidekiq bash -ci 'yarn install'
install_backend:
	docker-compose build --build-arg user="$(id -u):$(id -g)"
