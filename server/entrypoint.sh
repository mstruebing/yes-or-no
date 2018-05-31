#!/usr/bin/env sh

cd /app && \
yarn install && \
node_modules/.bin/babel src --out-dir dist --minified --presets=env --ignore test.js && \
node index.js
