# Welcome to inception 🐋

## This project aims to broaden your knowledge of system administration by using Docker. You will virtualize several Docker images,
## creating them in your new personal virtual machine.

# Table of Contents
1. [Mandatory Part](#docker-containers)
2. [Commands](#commands)
3. [Project Structure](#project-structure)
4. [Resources](#resources)



## Docker containers

- NGINX
- MariaDB
- WordPress

# Commands 💻

## how to create env variables create permanent data add host build run stop containers restart stop and remove images

```sh
$ make
```

## how to create env variables

```sh
$ make env
```

## how to create permanent data

```sh
$ make vol
```

## how to add host to /etc/hosts

```sh
$ make host
```

## how to build and run

```sh
$ make up
```

## how to stop containers

```sh
$ make stop
```

## how to restart

```sh
$ make re
```

## how to stop and remove containers images volumes and networks

```sh
$ make clean
```
# Project structure 📂

```bash
srcs
├── docker-compose.yml # Main docker-compose file
├── .env # generated by make env
├── .gitignore
├── Makefile
├── README.md
└── requirements
    ├── mariadb # MariaDB image
    │	├── conf
    │	│	├── wordpress.sql # SQL script to create the database
    │	│	└── mysqld.conf # MariaDB configuration file
    │	├── Dockerfile
    │	└── .dockerignore
    ├── nginx # Nginx image
    │	├── conf
    │	│	└── nginx.conf # Nginx configuration file
    │	└── Dockerfile
    ├── tools # Tools scritps
    │	├── addHost.sh # Add hosts to /etc/hosts
    │	├── envGen.sh # Generate .env file
    │   └── volGen.sh # Generate permanent data
    └── wordpress # Wordpress image
        ├── conf
      	│     └── www.conf # PHP configuration file
        ├── tools
        │     └── create_wordpress.sh # Script to create the wordpress database
        └── Dockerfile
```

# Ressources 📚

- [Docker](https://docs.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
- [Nginx](https://nginx.org/en/docs/)
- [MariaDB](https://mariadb.org/documentation/)
- [WordPress](https://wordpress.org/support/)
- [phpMyAdmin](https://docs.phpmyadmin.net/en/latest/)
- [Dockerfile](https://docs.docker.com/engine/reference/builder/)
- [Docker Compose file](https://docs.docker.com/compose/compose-file/)
- [Docker volumes](https://docs.docker.com/storage/volumes/)
- [Docker networks](https://docs.docker.com/network/)
- [Docker environment variables](https://docs.docker.com/compose/environment-variables/)