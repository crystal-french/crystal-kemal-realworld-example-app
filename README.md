# ![RealWorld Kemal App](logo.png)

Example Crystal/Kemal codebase that implements the [RealWorld](https://github.com/gothinkster/realworld-example-apps) spec and API.

# How it works

> Magic. Kemal is magic.

# Getting started

## Requirements
* [Crystal](https://crystal-lang.org/docs/installation/)
* [Cake](https://github.com/axvm/cake)
* Git
* MySQL

## Installation

* Run the following commands:
```
$ git clone git@github.com:reiswindy/kemal-realworld.git
$ cd kemal-realworld
$ shards install
``` 
* Copy the .env.dist and change the variables to your liking.
```
$ cp .env.dist .env.development
```
* Using Cake, run the following to setup your tables (remember to create your database first!):
```
$ cake dbmigrate
```
* To run the server:
```
$ crystal run src/realworld.cr
```

# To Do / In Progress

* General code cleanup
* Finish writing this README