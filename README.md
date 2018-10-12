# AsterixDB Docker 
The goal of this project is to quickly deploy AsterixDB on a local machine for learning purposes. This should *probably* not be used in production.

Image for AsterixDB 0.9.4 has been [pushed to Docker Hub](https://hub.docker.com/r/ds42/asterixdb/)


## How to run
All you need is the `docker-compose.yml` file, which grabs the image from Docker Hub and sets up the ports locally.

On a terminal, run `docker-compose up` and you'll have the AsterixDB ui running on port `19001`. There are other ports exposed, which should correspond to other AsterixDB services, take a look at the compose file for more info.

## How to build
This image uses CentOS as the base, updates yum, installs OpenJDK 8, and unzips the AsterixDB into `/asterixdb`. 


### Pre-requisites
- Docker installed/running
- Maven installed

Run `mvn install` in the root project diretory and watch Maven download the Asterix zip then push the file into a Docker image.