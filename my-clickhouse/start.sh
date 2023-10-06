#!/bin/bash

set -x

docker-compose --project-directory . -f docker-compose.yml up -d
