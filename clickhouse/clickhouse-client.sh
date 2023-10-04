#!/bin/bash

set -x

CONTAINER_NAME=$( docker inspect clickhouse | jq -r 'map(.Containers | map(.Name)) | .[0].[0]' )
docker exec -it $CONTAINER_NAME clickhouse-client
