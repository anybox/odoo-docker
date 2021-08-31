#!/bin/bash
createuser -U postgres -d odoo
createdb -U postgres -O odoo odoo

# unaccent functions
psql -c "CREATE SCHEMA unaccent_schema;" odoo odoo
psql -c "CREATE EXTENSION unaccent WITH SCHEMA unaccent_schema;" odoo odoo
psql -c "COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';" odoo odoo
psql -c "CREATE FUNCTION public.unaccent(text) RETURNS text
    LANGUAGE sql IMMUTABLE
    AS \$_\$
        SELECT unaccent_schema.unaccent('unaccent_schema.unaccent', \$1)
        \$_\$;" odoo odoo

