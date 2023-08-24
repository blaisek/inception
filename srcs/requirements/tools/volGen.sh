#!/bin/bash

# Color
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m'

# Variables
VOLUME_DIR=""

# Check the operating system type
if [[ "$OSTYPE" == "linux"* ]]; then
  # Linux
  VOLUME_DIR="/home/btchiman/data"
elif [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS
  VOLUME_DIR="/Users/btchiman/data"
elif [[ "$OSTYPE" == "msys"* ]]; then
  # Windows
  VOLUME_DIR="C:/Users/btchiman/data"
else
  echo -e "${RED}Unsupported operating system${NC}"
  exit 1
fi

# Catch if ctrl+c is pressed
trap ctrl_c INT
function ctrl_c() {
  echo -e "\n${RED}Exiting${NC}"
  exit 1
}

# Check if volume directory exists
if [ ! -d "$VOLUME_DIR" ]; then
  echo -e "${YELLOW}Volume directory does not exist${NC}"
  # ask if user wants to create it
  read -p "Do you want to create it? [y/n] " -n 1 -r
  # if yes, create it
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "\n\nCreating volume directory"
    sudo mkdir -p $VOLUME_DIR/mariadb
    sudo mkdir -p $VOLUME_DIR/wordpress
  # if no, exit
  else
    echo -e "\n${RED}Exiting${NC}"
    exit 1
  fi
fi
