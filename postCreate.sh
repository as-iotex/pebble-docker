#!/bin/bash

# Colors
BLUE=`tput setaf 21`
RESET=`tput sgr0`

source sdk/zephyr/zephyr-env.sh
cd sdk

echo  "{$BLUE}Running west update{$RESET}"
west update --narrow -o=--depth=1

echo  "{$BLUE}Installing python dependencies{$RESET}"
python3 -m pip install -r zephyr/scripts/requirements.txt
python3 -m pip install -r nrf/scripts/requirements.txt
python3 -m pip install -r bootloader/mcuboot/scripts/requirements.txt