FROM postgres:9.6
COPY init.sh /docker-entrypoint-initdb.d/

RUN set -x; \
        sed -i 's/main/main contrib non-free/g' /etc/apt/sources.list \
        && apt-get update \
        && apt-get install -y --no-install-recommends \
           postgis \
           postgresql-9.6-postgis-2.4 \
           postgresql-9.6-postgis-2.4-scripts
