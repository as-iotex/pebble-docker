# Docker container for Pebble Firmware

This project provides a Ubuntu based Docker container that can be used as a development or build environment for the Pebble Firmware.  

## Configuration

Use the provided `.env` file for configuring the pebble version that is built.  

## Docker compose

To build the firmware using Docker compose run:  
`docker-compose up`  

## VS Code

Install the `Remote: Containers` VS Code extension and open the directory containing this repository in VS Code.   
Press F1 -> Reopen in container.  
Use the provided VS Code tasks for building the firmware. Press F1 -> Run task... to see a list of tasks.  

## Build output files

The build output is placed in the `build` directory.  




