FROM registry.anybox.cloud/anybox/odoo-docker/odoo:12.0

LABEL maintainer="Anybox"
ENV VERSION 12.0

USER root

RUN set -x; \
    cd /srv/extra-addons \
#
    ### DOWNLOAD MODULES
    curl -OJL -u ${GITHUB_TOKEN}:x-oauth-basic \
      https://github.com/odoo/enterprise/archive/$VERSION.zip \
    && unzip -q enterprise-$VERSION.zip \
    && mv -f enterprise-$VERSION/* . \
    && rm -rf enterprise-$VERSION \
    && rm -f enterprise-$VERSION.zip

COPY odoo.conf /etc/odoo/
