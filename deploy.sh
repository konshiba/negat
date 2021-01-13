#!/bin/bash
kill $(cat tmp/pids/puma.pid)
git pull
bundle install --path vendor/bundle --without test development
bundle exec rails assets:precompile RAILS_ENV=production
bundle exec rails db:migrate RAILS_ENV=production
sudo service nginx restart
rails s -e production

