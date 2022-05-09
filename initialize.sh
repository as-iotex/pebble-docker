#!/bin/bash

# Colors
blue=`tput setaf 21`
reset=`tput sgr0`

source .env

echo "Cloning sdk $SDK_NRF_REVISION to ./sdk"
git clone -b "${SDK_NRF_REVISION}" https://github.com/iotexproject/pebble-firmware-legacy.git sdk

cd sdk
echo  "Cloning sdk $ZEPHYR_REVISION to ./sdk/zephyr"
git clone -b "${ZEPHYR_REVISION}" https://github.com/nrfconnect/sdk-zephyr  sdk/zephyr

# echo  "Running west update"
# west update --narrow -o=--depth=1 || : 

# echo  "Installing dependencies"
# python3 -m pip install -r zephyr/scripts/requirements.txt
# python3 -m pip install -r nrf/scripts/requirements.txt
# python3 -m pip install -r bootloader/mcuboot/scripts/requirements.txt

cd ..
echo  "Cloning pebble firmware $PEBBLE_REVISION to ./app"
if [ ! -d "app" ] ; then
    # Clone the repo if not already existent
    git clone -b "$PEBBLE_REVISION" https://github.com/iotexproject/pebble-firmware.git app
else
    # If the repo exists checkout the version and pull the latest changes
    cd "app"
    git checkout "$PEBBLE_REVISION"
    git pull
    cd ..
fi

# source .env
# source sdk/zephyr/zephyr-env.sh
# rm -rf build/

# west zephyr-export 
# west build -b iotex_pebble_hw30ns app/nrf/applications/$PEBBLE_REVISION


