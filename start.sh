#!/bin/sh

# Navigate to ./backend directory
cd ./backend || { echo "Failed to change directory to ./backend"; exit 1; }

# Execute mvn install
echo "Executing mvn install in ./backend..."
mvn install
if [ $? -ne 0 ]; then
  echo "mvn install failed."
  exit 1
fi

# Execute mvn package
echo "Executing mvn package in ./backend..."
mvn package
if [ $? -ne 0 ]; then
  echo "mvn package failed."
  exit 1
fi

# Navigate back to the original directory
cd - || { echo "Failed to change back to the original directory"; exit 1; }

# Execute docker-compose up -d
echo "Executing sudo docker-compose up -d..."
sudo docker-compose up -d
if [ $? -ne 0 ]; then
  echo "docker-compose up failed."
  exit 1
fi

echo "Script executed successfully."
