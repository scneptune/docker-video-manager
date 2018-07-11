install_frontend:
	docker-compose run --rm --no-deps --user="$(id -u):$(id -g)" sidekiq bash -ci 'yarn install'
install_backend:
	docker-compose build --build-arg user="$(id -u):$(id -g)"
pulldown_latest_dump:
	heroku pg:backups capture -a atv-video-manager-staging
	curl -o ./postgres/dumps/latest.dump `heroku pg:backups public-url -a atv-video-manager-staging`
restore_latest_dump:
	docker-compose up -d postgres_db
	docker exec -ti --user="$(id -u):$(id -g)" postgresql sh -c "/usr/local/etc/init-db.sh video_development"
