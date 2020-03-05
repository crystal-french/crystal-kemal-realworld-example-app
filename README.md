# ![RealWorld Kemal App](logo.png)

[![Build Status](https://travis-ci.com/reiswindy/kemal-realworld.svg?branch=master)](https://travis-ci.com/reiswindy/kemal-realworld)

Example Crystal/Kemal codebase that implements the [RealWorld](https://github.com/gothinkster/realworld) spec and API.

# Getting started

## Requirements
* [Crystal](https://crystal-lang.org/docs/installation/)
* [Cake](https://github.com/axvm/cake)
* Git
* MySQL

## Usage

Clone this repository and install its dependencies:
```sh
$ git clone git@github.com:reiswindy/kemal-realworld.git
$ cd kemal-realworld
$ shards install
``` 

Create a file named `.env.development` and set up your database credentials. You may use the example file `.env.dist` as a base for this:
```sh
$ cp .env.dist .env.development
```

Run Cake task `dbmigrate` to set up the database schema. Internally, this task uses [micrate](https://github.com/amberframework/micrate) to run the migrations in the `db` folder:
```sh
$ cake dbmigrate
```

Build and run the server:
```sh
$ shards build realworld
$ bin/realworld
```

## Environment variables

This repository uses [cr-dotenv](https://github.com/gdotdesign/cr-dotenv) to set up the environment variables in non-production builds. You may specify which `.env` to load by providing the `APP_ENV` environment variable when running the server. By default this value is `development`, and the file loaded is `.env.development` as a result.

```sh
$ APP_ENV=integration bin/realworld # Will load .env.integration instead
```

## Production

When **built** in production mode, `.env` files will no longer be loaded. All values will be taken from the system's environment variables.

To build and run the server in production mode:
```sh
$ APP_ENV=production shards build realworld --production --release --no-debug --progress --stats
$ bin/realworld
```

# Testing

## Specs

This repository uses [spec-kemal](https://github.com/kemalcr/spec-kemal) for testing responses returned by Kemal. This requires setting the environment variable `KEMAL_ENV` to `test` when running Crystal's built in testing framework:
```sh
$ KEMAL_ENV=test crystal spec
```

## Integration

This repository uses the integration test suite provided by https://github.com/gothinkster/realworld/tree/master/api in its Travis CI script. If the badge is currently green, all tests have passed.

## Contributors

* [@humboldtux](https://github.com/humboldtux) Benoit Benedetti - creator
* [@reiswindy](https://github.com/reiswindy) - creator, maintainer