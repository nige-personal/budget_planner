echo setup starting.....
docker-compose rm

echo build docker image
command="RAILS_ENV=development bundle exec rake db:drop db:create db:migrate && RAILS_ENV=development bundle exec rails s -p 3000 -b '0.0.0.0'"

#docker build --rm -f Dockerfile  --build-arg APP_DIR=budget --build-arg  COMMAND="$command" -t budget_service .
docker build --rm -f Dockerfile -t budget_service .
echo setup complete