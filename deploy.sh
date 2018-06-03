#!/usr/bin/env bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

nvm use && cd server && make clean && make install && make build-production && cd ../client && make build && cd .. && rsync -ravz ./* yes-or-no:~/yes-or-no/
