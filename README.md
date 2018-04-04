# BigData Docker Scripts
This repo has common scripts for setting up and installing docker containers for different types of apps.

## Postgres-XL on Docker
Postgres-XL does not give any official ways of running it on containers. To help things move along, this Docker compose setup and images let you get a Postgres-XL cluster up and running without having to setup and download things. Especially helpful if you want to do local development.

## Base Centos Images (6.6 & 7):
These images and scripts have most common things installed on them already. Things like curl, wget, mlocate, vim, etc. It also has JDK 1.8 installed -- I use this as a base image to install OSS and tinker with new applications. The script used to create this container is also included so you can use that or pull the image directly if you want.

- Base Docker Cetos 6.6 (base_docker_centos_66)
- Base Docker Cetos 7 (base_docker_centos_7)







