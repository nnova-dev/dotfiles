#!/bin/bash

set -eEo pipefail

# exports
export KODA_DIR="$HOME/.local/share/koda"
export KODA_CONFIGS="$KODA_DIR/configs"
export KODA_INSTALL="$KODA_DIR/install"
export PATH="$KODA_DIR/bin:$PATH"

# loading modules
source "$KODA_INSTALL/dir/all.sh"
