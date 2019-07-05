FROM registry.anybox.cloud/anybox/odoo-docker/odoo:12.0

LABEL maintainer="Anybox"
ARG GITHUB_TOKEN
ENV VERSION 12.0

USER root

RUN set -x; \
    cd /srv/extra-addons \
#
    ### DOWNLOAD MODULES
    && curl -o addons.zip -sSL -u ${GITHUB_TOKEN}:x-oauth-basic \
      https://github.com/odoo/enterprise/archive/$VERSION.zip \
    && unzip -q addons.zip \
    && mv -f enterprise-$VERSION/* . \
    && rm -rf enterprise-$VERSION \
    && rm -f addons.zip

COPY odoo.conf /etc/odoo/
