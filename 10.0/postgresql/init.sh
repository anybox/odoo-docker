#!/bin/bash
createuser -U postgres -d odoo
createdb -U postgres -O odoo odoo
psql odoo -c 'CREATE EXTENSION postgis;'
psql odoo -c 'CREATE EXTENSION postgis_topology;'
