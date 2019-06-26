# Custom Odoo Docker Setup

Set of docker images and some sample docker-compose files for Odoo.

Directories layout:

    ├── odoo :       docker image for **Odoo** (Community)
    ├── odoo-ee :    docker image for **Odoo EE**
    ├── odoo-oca :   docker image for **Odoo + OCA modules**
    ├── postgresql : docker image for **PostgreSQL with an init script**


## Build the docker images

First checkout this repository:

    git clone https://github.com/anybox/odoo-docker
    cd odoo-docker

Choose the version you want:

    git checkout 12.0

Build the PostgreSQL image:

    docker build -t postgresql:odoo12 postgresql

Build the base Odoo image:

    docker build -t anybox/odoo:12.0 odoo

Either build the image with additional OCA modules:

    docker build -t anybox/odoo-oca:12.0 odoo-oca

Or build the image with only Enterprise Edition:

    docker build -t anybox/odoo-ee:12.0 odoo-ee


## Run and manage Odoo with docker-compose

You can use the provided docker-compose.yml files as a starting point, but it should be adapted to your Docker infrastructure.

### Start Odoo and PostgreSQL

    docker-compose -p myproject up -d

Then open on a browser on your local machine:

    firefox `docker-compose -p myproject port odoo 8069`

### Stop Odoo

    docker-compose -p myproject stop odoo

### Create DB

The database should already be created on first start, thanks to the init
script of the PostgreSQL docker image. Otherwise you can do:

    docker-compose -p myproject exec --user postgres postgresql createdb -O odoo odoo

### Drop db

    docker-compose -p myproject exec --user postgres postgresql dropdb odoo

### Restore db

    docker cp backup.dump myproject_postgresql_1:/tmp/
    docker-compose -p myproject exec --user postgres postgresql pg_restore --role odoo -O -Fc -d odoo /tmp/<dumpfile>
    docker-compose -p myproject exec postgresql rm /tmp/<dumpfile>

### Update all

    docker-compose -p myproject run --rm odoo -u all --stop-after-init

### Reset password

    docker-compose -p myproject exec --user postgres postgresql psql odoo -c "update res_users set password='admin' where login='admin';"

