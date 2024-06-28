#!/bin/bash  
set -e  
  
# 修改 postgresql.conf  
echo "shared_preload_libraries = 'timescaledb'" >> /var/lib/postgresql/data/postgresql.conf  

# psql -U ${POSTGRES_USER} -W ${POSTGRES_PASSWORD} -c "CREATE EXTENSION IF NOT EXISTS timescaledb CASCADE";
# psql -U ${POSTGRES_USER} -W ${POSTGRES_PASSWORD} -c "CREATE EXTENSION IF NOT EXISTS postgis CASCADE";
