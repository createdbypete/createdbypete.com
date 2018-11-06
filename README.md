# createdbypete.com

This is my personal website. It is built using the static site generator
[Middleman](1).

[1]: http://middlemanapp.com

## Getting Started

Clone the project on the `develop` branch and run setup.

```
git clone https://github.com/createdbypete/createdbypete.github.io.git --branch develop
cd createdbypete.github.io
./bin/setup
```

Run the Middleman server for development.

```
./bin/server
```

## Build

You can build the project with Docker as your only dependency.

```
docker build -t createdbypete.github.io:latest .
docker -v $(pwd)/build:/src/build createdbypete.github.io:latest bundle exec middleman build
```

## Deploy

Ensure [Firebase is setup locally](https://firebase.google.com/docs/hosting/deploying) to deploy the static files.

```
./bin/deploy
```
