web: source ./.env.local; echo "PORT is ${PORT}, VCAP_APP_PORT is ${VCAP_APP_PORT}"; bin/rake db:create; bin/rake db:migrate && bundle exec puma -e ${RAILS_ENV} -p ${VCAP_APP_PORT} -S ~/puma -C config/puma.rb
clock: bin/clockwork lib/clockwork_handler.rb
