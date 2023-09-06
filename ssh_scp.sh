#!/bin/bash

# This is a simple script for SSH and SCP operations.
# It provides a menu-driven interface to help you connect to a remote server or copy files securely.
# I was not able to run the code successfully due to wrong permissions that I was not able to trouble shoot
# I will still be working to figure this out and update the script accordingly 
# current error: ubuntu@00.000.000.000: Permission denied (publickey)

# Function to display the menu and get user choice
display_menu() {
  echo "Menu:"
  echo "1. SSH into a server"
  echo "2. Copy files using SCP"
  echo "3. Exit"
  read -p "Enter your choice (1/2/3): " choice
}

# Function to SSH into a server
ssh_server() {
  # Prompt the user for their username and the server's IP address
  read -p "Enter your username: " username
  read -p "Enter the server's IP address: " ip_address
  
  # Use SSH to connect to the server with the provided username and IP address
  ssh "$username@$ip_address"
}

# Function to copy files securely using SCP
copy_with_scp() {
  # Prompt the user for their username and the server's IP address
  read -p "Enter your username: " username
  read -p "Enter the server's IP address: " ip_address
  
  # Prompt the user to choose the copy direction
  echo "Choose copy direction:"
  echo "1. Remote to local"
  echo "2. Local to remote"
  read -p "Enter your choice (1/2): " copy_direction

  if [ "$copy_direction" -eq 1 ]; then
    direction="remote to local"
  elif [ "$copy_direction" -eq 2 ]; then
    direction="local to remote"
  else
    echo "Invalid choice. Exiting."
    return
  fi

  # Prompt the user for the source file location
  read -p "Enter the source file location: " source_file
  
  # Prompt the user for the destination file location or use the same filename if not provided
  read -p "Enter the destination file location (press Enter to keep the same filename): " destination_file

  if [ -z "$destination_file" ]; then
    destination_file=$(basename "$source_file")
  fi

  # Use SCP to copy files based on the chosen direction and provided file locations
  if [ "$direction" == "remote to local" ]; then
    scp "$username@$ip_address:$source_file" "$destination_file"
  elif [ "$direction" == "local to remote" ]; then
    scp "$source_file" "$username@$ip_address:$destination_file"
  fi

  echo "File copy $direction complete."
}

# Main loop to display the menu and execute user's choice
while true; do
  display_menu
  case "$choice" in
    1)
      ssh_server
      ;;
    2)
      copy_with_scp
      ;;
    3)
      echo "Exiting."
      exit 0
      ;;
    *)
      echo "Invalid choice. Please select a valid option."
      ;;
  esac
done
