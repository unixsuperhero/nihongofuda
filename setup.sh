
cat <<MSG

  ##########################################
  # This is the setup script for nihongofuda
  ##########################################

MSG

echo 'Installing bundler...'
gem install bundler

echo 'Installing gems...'
bundle install

echo -n 'Setup config/database.yml?...'
if [[ ! -a config/database.yml ]]
then
  echo 'no'
  cat <<"DB" >config/database.yml
development:
  adapter: postgresql
  username: dev
  database: nihongofuda_development
  pool: 5
  timeout: 5000

# Warning: The database defined as "test" will be erased and
# re-generated from your development database when you run "rake".
# Do not set this db to the same as development or production.
test:
  adapter: postgresql
  username: dev
  database: nihongofuda_test
  pool: 5
  timeout: 5000
DB
  rake db:create:all
  rake db:migrate
else
  echo 'yes'
fi

echo -n 'Ran rails g bootstrap:install?...'
if [[ ! -a app/assets/stylesheets/bootstrap_and_overrides.css ]]
then
  echo 'no'
  rails g bootstrap:install static
else
  echo 'yes'
fi

