# README

This service provide API to upload and list images

## System dependencies

### For development

- ruby 2.6.3
- postgresql (recommended version 10)

### For production

- docker (recommended 19.03.1)
- docker-compose (recommended version 1.24.1)

## How to run this project

### Development

For development, the postgres configuration user name is postgres and password blank. If your system is different, change the `config/database.yml` at `development` and `test` environment.

#### To prepare environment, follow the commands below

```bash
bundle install
```

```bash
bundle exec rake db:create db:schema:load
```

#### To run

```bash
bundle exec rails s
```

### Production

Production run under docker and is divided on 2 components: database (postgres) and application.

#### Enviroment variables

It's need to setup some environment variables

`DATABASE_PASSWORD` define postgres password
`DEFAULT_HOST` is used to define base URL to download images.

#### Build docker

```bash
docker-compose build
```

#### Run

```bash
docker-compose up -d
```

#### Stop

```bash
docker-compose stop
```
