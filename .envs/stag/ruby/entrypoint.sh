#!/bin/bash

bundle check || bundle install --binstubs="$BUNDLE_BIN"

exec "$@"
