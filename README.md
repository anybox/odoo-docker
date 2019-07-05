# Custom Odoo Docker Setup

Set of docker images and some sample docker-compose files for Odoo.

Directories layout:

    ├── debian :     Debian base image
    ├── odoo :       docker image for **Odoo** (Community)
    ├── ocb  :       docker image for **OCB** (Community from OCA)
    ├── odoo-oca :   docker image for **Odoo + OCA modules**
    ├── ocb-oca :    docker image for **OCB + OCA modules**
    ├── odoo-ee :    docker image for **Odoo EE**


## Build the docker images

First checkout this repository:

    git clone https://github.com/anybox/odoo-docker
    cd odoo-docker

Choose the version you want:

    git checkout 12.0

Read the help of the available commands

    make help

Build the base Odoo image:

    cd odoo
    make build

Either build the image with additional OCA modules:

    cd odoo-oca
    make build

Or build the image with only Enterprise Edition:

    cd odoo-ee
    make build


### Start Odoo and PostgreSQL

    make init
    make run

Then open on a browser on your local machine:

    firefox http://localhost:8069

### Stop Odoo

    make stop

### Destroy the application and all data

    make destroy

### Restore db

    docker cp backup.dump odoo_db_1:/tmp/
    docker-compose exec --user db postgresql pg_restore --role odoo -O -Fc -d odoo /tmp/<dumpfile>
    docker-compose exec postgresql rm /tmp/<dumpfile>

### Update all

    docker-compose run --rm odoo -u all --stop-after-init

### Reset password

    docker-compose exec --user db postgresql psql odoo -c "update res_users set password='admin' where login='admin';"

