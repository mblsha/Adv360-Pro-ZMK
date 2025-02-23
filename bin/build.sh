#!/usr/bin/env bash

set -eu

PWD=$(pwd)
TIMESTAMP="${TIMESTAMP:-$(date -u +"%Y%m%d%H%M%S")}"

# West Build (left)
west build -s zmk/app -d build/left -b adv360_left -- -DZMK_CONFIG="${PWD}/config"
# Adv360 Left Kconfig file
cat build/left/zephyr/.config | grep -v "^#" | grep -v "^$" > ./firmware/left.kconfig

# West Build (right)
west build -s zmk/app -d build/right -b adv360_right -- -DZMK_CONFIG="${PWD}/config"
# Adv360 Right Kconfig file
cat build/right/zephyr/.config | grep -v "^#" | grep -v "^$" > ./firmware/right.kconfig

# Rename zmk.uf2
cp build/left/zephyr/zmk.uf2  ./firmware/${TIMESTAMP}-left.uf2
cp build/left/zephyr/zmk.uf2  ./firmware/left.uf2
cp build/right/zephyr/zmk.uf2 ./firmware/${TIMESTAMP}-right.uf2
cp build/right/zephyr/zmk.uf2 ./firmware/right.uf2

# can also copy .dts.pre
cp build/left/zephyr/zephyr.dts      ./firmware/${TIMESTAMP}-left.dts
cp build/left/zephyr/zephyr.dts      ./firmware/left.dts
cp build/left/zephyr/zephyr.dts.pre  ./firmware/${TIMESTAMP}-left.dts.pre
cp build/left/zephyr/zephyr.dts.pre  ./firmware/left.dts.pre
cp build/right/zephyr/zephyr.dts     ./firmware/${TIMESTAMP}-right.dts
cp build/right/zephyr/zephyr.dts     ./firmware/right.dts
cp build/right/zephyr/zephyr.dts.pre ./firmware/${TIMESTAMP}-right.dts.pre
cp build/right/zephyr/zephyr.dts.pre ./firmware/right.dts.pre

# exec /bin/bash
