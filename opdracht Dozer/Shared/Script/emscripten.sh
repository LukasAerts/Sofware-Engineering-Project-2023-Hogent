#! /bin/bash

# Enable "Bash strict mode"
set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't mask errors in piped commands


# install the required dependencies:

sudo dnf install -y python3 cmake nodejs java-1.8.0-openjdk-devel

# clone the Emscripten repo

git clone https://github.com/emscripten-core/emsdk.git
cd emsdk

# Run the Emscripten installation script

./emsdk install latest

# activate the installed emscripten version

./emsdk activate latest

# set the environment variables for the current shell

source ./emsdk_env.sh

# emscripten installed

echo "emscripten script has been executed successfully"