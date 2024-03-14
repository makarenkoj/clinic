# README

[![CI](https://github.com/makarenkoj/clinic/actions/workflows/ci.yml/badge.svg)](https://github.com/makarenkoj/clinic/actions/workflows/ci.yml)

# Clinic

 - Ruby version: `3.1.2`
 - Rails version: `7.0.4`
 - DB: `Postgres`
 - Run container: `docker-compose up -d`

 mailcatcher: http://127.0.0.1:1080/

 Start the tests:

 - `bundle exec rspec`

 Start code style checing:

 - `bundle exec rubocop`

For start GraphQL develop testing:
----

 - `bundle exec rails s`

 - open your browser and go: http://localhost:3000/graphiql
