# README

Foundation is an api for users

## Development setup

Requires:

 * Ruby 2.3.1
 * Postgres (Easy install on Mac using http://postgresapp.com/)

Steps (note `AUTH_TOKEN` can be set to any value)

```
gem install bundler
git clone https://github.com/dtt101/foundation.git
cd foundation
bundle
echo $'AUTH_TOKEN=secret_token\nPORT=3000' > .env
bin/rails db:setup
```

The application is setup with seed data

## Development

```
bin/rails s
```

Confirm working by visiting `http://localhost:3000/users` to see list of users

## Test

```
bundle exec rspec
```

## Production

The application is deployed to `https://dtt-foundation.herokuapp.com`

## Routes

See `spec/requests/users_spec.rb` for routes and usage.
