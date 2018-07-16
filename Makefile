install_frontend:
	docker-compose run --rm --no-deps --user="$(id -u):$(id -g)" sidekiq bash -ci 'yarn install'
install_backend:
	docker-compose build --build-arg user="$(id -u):$(id -g)"
pull_latest_db_staging:
	make fetch_staging_dump
	make load_staging_dump
pull_latest_db_prod:
	make fetch_prod_dump
	make load_prod_dump
fetch_staging_dump:
	heroku pg:backups capture -a atv-video-manager-staging
	curl -o ./postgres/dumps/latest.dump `heroku pg:backups public-url -a atv-video-manager-staging`
fetch_prod_dump:
	heroku pg:backups capture -a atv-video-manager-staging
	curl -o ./postgres/dumps/latest.dump `heroku pg:backups public-url -a atv-video-manager`
load_staging_dump:
	docker-compose up -d postgres_db
	docker exec -ti --user="$(id -u):$(id -g)" rails-docker_postgres_db_1 sh -c "chmod +w /usr/local/scripts && /usr/local/scripts/load-dump.sh video_manager-development"
load_prod_dump:
	docker-compose up -d postgres_db
	docker exec -ti --user="$(id -u):$(id -g)" rails-docker_postgres_db_1 sh -c "chmod +w /usr/local/scripts && /usr/local/scripts/load-dump.sh video_manager-production"
populate_media_cache:
	docker exec -ti --user="$(id -u):$(id -g)" rails-docker_rails_app_1 sh -c "echo 'y' | bundle exec rake cache:populate | cat"
