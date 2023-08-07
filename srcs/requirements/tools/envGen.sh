#!/bin/bash

# Color
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
GREY='\033[1;37m'
NC='\033[0m'

# Variables
BASEDIR=./srcs/
ENV_PATH=$BASEDIR.env
DOMAIN=btchiman.ch

# Catch if ctrl+c is pressed
trap ctrl_c INT
function ctrl_c() {
  echo -e "\n${RED}Exiting${NC}"
  exit 1
}

# Check if .env file exists in project
if [ -f $ENV_PATH ]; then
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
echo -e "\n${GREY}Enter your database root password:${NC}"
read -r MYSQL_ROOT_PASSWORD
echo -e "\n${GREY}Enter your database password:${NC}"
read -r MYSQL_PASSWORD
echo -e "\n${GREY}Enter your database name:${NC}"
read -r MYSQL_DATABASE
echo -e "\n${GREY}Enter your database user:${NC}"
read -r MYSQL_USER
echo -e "\n${GREY}Enter your wp admin user:${NC}"
read -r WP_ADMIN_USER
echo -e "\nPlease enter the value for DOMAIN (e.g., mydomain.com):"
read -r DOMAIN

# if .env not filled exit
if [ -z "$MYSQL_ROOT_PASSWORD" ] || [ -z "$MYSQL_PASSWORD" ] || [ -z "$MYSQL_DATABASE" ] || [ -z "$MYSQL_USER" ] || [ -z "$WP_ADMIN_USER" ] || [ -z "$DOMAIN" ] ; then
  echo -e "\n${RED}Error: .env file not filled${NC}"
  exit 1
else
  # if .env filled, create .env file
  echo -e "MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD" >> $ENV_PATH
  echo -e "MYSQL_PASSWORD=$MYSQL_PASSWORD" >> $ENV_PATH
  echo -e "MYSQL_DATABASE=$MYSQL_DATABASE" >> $ENV_PATH
  echo -e "MYSQL_USER=$MYSQL_USER" >> $ENV_PATH
  echo -e "WP_ADMIN_USER=$WP_ADMIN_USER" >> $ENV_PATH
  echo -e "DOMAIN=$DOMAIN" >> "$ENV_PATH"


  # Success message
  echo -e "\n${GREEN}Success!${NC} .env file created"
fi
