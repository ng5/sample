#!/bin/bash
DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$DIR" || exit 1
export OUTPUT=build
cmake -B "$DIR"/$OUTPUT -S . && cmake --build "$DIR"/$OUTPUT -- -j 8 && cmake --install $OUTPUT
