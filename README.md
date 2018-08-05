# README

## Dependencies
To run this project you must have [docker](https://docs.docker.com/install/) installed.

## app.sh
Everithing can be done through app.sh script, on root path of this application source code. to get help on how to use, only run script without parameters:
```
./app.sh
```

## Before all
Before all, you must build application image, that can be done with:
```
./app.sh build
```
This command will create a docker image with all dependencies wired for application

## Prepare database
After success build of application image, you must setup database with:
```
./app.sh prepare
```

## Running tests
To run tests, execute:
```
./app.sh tests
```

## Executing application
To up application server, run:
```
./app.sh run
```
You can access application through [http://localhost:3000/](http://localhost:3000/)

## Getting access to application terminal
This will give access to application image terminal, once you get access, will be available rails commands and rails console.
```
./app.sh terminal
```