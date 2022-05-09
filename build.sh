#!/bin/bash

if [ "$1" == "--rebuild" ]; then
    rm -rf build/
fi

source sdk/zephyr/zephyr-env.sh
echo "Running west zephyr-export"
west zephyr-export 
echo "Running west build -b iotex_pebble_hw30ns app/nrf/applications/$PEBBLE_REVISION"
west build -b iotex_pebble_hw30ns app/nrf/applications/$PEBBLE_REVISION
