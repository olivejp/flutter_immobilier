#!/usr/bin/env bash

# Generate environment_config.dart with Development variables.
# Author : OLIVE Jean-Paul

flutter pub run environment_config:generate \
--serverUrl=localhost:8080 \
--useHttps=false

echo Development settings applied.