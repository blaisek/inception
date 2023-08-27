#!/bin/bash

# Color
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
GREY='\033[1;37m'
NC='\033[0m'

# Variables
BASEDIR=./srcs/
ENV_PATH=$BASEDIR.env
DOMAIN=btchiman.42.fr
MARIADB_HOST=mariadb
WP_TITLE=42_wordpress

# Catch if ctrl+c is pressed
trap ctrl_c INT
function ctrl_c() {
  echo -e "\n${RED}Exiting${NC}"
  exit 1
}

# Check if .env file exists in project
if [ -f "$ENV_PATH" ]; then
  echo -e "${YELLOW}.env file already exists${NC}"
  # ask if user wants to overwrite¨
  read -p "Do you want to overwrite it? [y/n] " -n 1 -r
  # if yes, overwrite
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "\n\nOverwriting .env file"
    rm $ENV_PATH
  # if no, exit
  else
    echo -e "\n${RED}Exiting${NC}"
    exit 1
  fi
fi

# Fill .env variables with prompt input
echo -e "\n${GREY}Enter your database name:${NC}"
read -r MARIADB_NAME
echo -e "\n${GREY}Enter your database user name:${NC}"
read -r MARIADB_USER
echo -e "\n${GREY}Enter your database user password:${NC}"
read -r MARIADB_PASSWORD
echo -e "\n${GREY}Enter your database root password:${NC}"
read -r MARIADB_ROOT_PASSWORD
echo -e "\n${GREY}Enter your wp user name:${NC}"
read -r WP_USER
echo -e "\n${GREY}Enter your wp user password:${NC}"
read -r WP_PASSWORD
echo -e "\n${GREY}Enter your wp user email:${NC}"
read -r WP_EMAIL
echo -e "\n${GREY}Enter your wp admin user:${NC}"
read -r WP_ADMIN_USER
echo -e "\n${GREY}Enter your wp admin password:${NC}"
read -r WP_ADMIN_PASSWORD
echo -e "\n${GREY}Enter your wp admin email:${NC}"
read -r WP_ADMIN_EMAIL


# if .env not filled exit
if [ -z "$MARIADB_ROOT_PASSWORD" ] || [ -z "$MARIADB_PASSWORD" ] || [ -z "$MARIADB_NAME" ] || [ -z "$MARIADB_USER" ] ||
 [ -z "$WP_ADMIN_USER" ] || [ -z "$WP_ADMIN_PASSWORD" ] || [ -z "$DOMAIN" ] || [ -z "$WP_USER" ] ||
  [ -z "$WP_PASSWORD" ] || [ -z "$WP_EMAIL" ] || [ -z "$WP_ADMIN_EMAIL" ] ; then

  echo -e "\n${RED}Error: .env file not filled${NC}"
  exit 1
else
  # if .env filled, create .env file
  echo -e "MARIADB_ROOT_PASSWORD=$MARIADB_ROOT_PASSWORD" >> $ENV_PATH
  echo -e "MARIADB_PASSWORD=$MARIADB_PASSWORD" >> $ENV_PATH
  echo -e "MARIADB_NAME=$MARIADB_NAME" >> $ENV_PATH
  echo -e "MARIADB_HOST=$MARIADB_HOST" >> $ENV_PATH
  echo -e "MARIADB_USER=$MARIADB_USER" >> $ENV_PATH
  echo -e "WP_ADMIN_USER=$WP_ADMIN_USER" >> $ENV_PATH
  echo -e "WP_ADMIN_PASSWORD=$WP_ADMIN_PASSWORD" >> $ENV_PATH
  echo -e "DOMAIN=$DOMAIN" >> "$ENV_PATH"
  echo -e "WP_USER=$WP_USER" >> "$ENV_PATH"
  echo -e "WP_PASSWORD=$WP_PASSWORD" >> "$ENV_PATH"
  echo -e "WP_EMAIL=$WP_EMAIL" >> "$ENV_PATH"
  echo -e "WP_ADMIN_EMAIL=$WP_ADMIN_EMAIL" >> "$ENV_PATH"
  echo -e "WP_TITLE=$WP_TITLE" >> "$ENV_PATH"

  # Success message
  echo -e "\n${GREEN}Success!${NC} .env file created"
fi
