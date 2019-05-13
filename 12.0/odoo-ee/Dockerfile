FROM anybox/odoo:12.0
MAINTAINER Anybox

USER root

RUN set -x; \
        apt-get update \
        && apt-get install -y --no-install-recommends git \
        && mkdir -p /mnt/repositories /mnt/custom-addons \
        && cd /mnt/repositories \
#
        ### DOWNLOAD MODULES
        && git clone -b 12.0 https://${GITHUB_ACCOUNT}:${GITHUB_TOKEN}@github.com/odoo/enterprise \
        && ln -srf enterprise/* ../extra-addons/

VOLUME /etc/odoo /var/lib/odoo
COPY odoo.conf /etc/odoo/
USER odoo
