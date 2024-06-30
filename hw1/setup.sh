#!/bin/bash

DATASET_DUMP=${1-lahman.pgdump}
set -e

PGUSER=postgres

rm -f "$DATASET_DUMP"
gunzip -k "${DATASET_DUMP}.gz"
dropdb -U postgres --if-exists baseball 
createdb  -U postgres baseball
psql -U postgres -e -d baseball < "$DATASET_DUMP"
rm -f "$DATASET_DUMP"

echo -e '\nHW1 setup complete'

