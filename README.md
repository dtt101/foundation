# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Notes

Create .env file with:

```
AUTH_TOKEN=your_auth_token
```

Uses Ruby 2.3.1 with rbenv or rvm

Install postgres (for parity with dev and prod) - on a mac use http://postgresapp.com/

```
gem install bundler
g clone repo_url
cd
bundle
/bin/rails db:setup
bundle exec rspec
```
