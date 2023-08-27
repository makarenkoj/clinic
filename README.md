# README

[![CI](https://github.com/makarenkoj/clinic/actions/workflows/ci.yml/badge.svg)](https://github.com/makarenkoj/clinic/actions/workflows/ci.yml)

# Clinic

 - Ruby version: `3.1.2`
 - Rails version: `7.0.4`
 - DB: `Postgres`

---
 start mailcatcher: `mailcatcher`

 mailcatcher: http://127.0.0.1:1080/

---

 start sidekiq: `bundle exec sidekiq -q default`


 Redis

 `ps aux | grep redis`

`sudo kill -9 redis_port`