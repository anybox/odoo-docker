FROM registry.anybox.cloud/anybox/odoo-docker/odoo:13.0

LABEL maintainer="Anybox"
ARG GITHUB_TOKEN
ENV VERSION 13.0

USER root
RUN apt-get update \
    && apt-get install -y --no-install-recommends build-essential \
    && pip3 install firebase_admin \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false \
        build-essential \
    && apt-get clean && rm -rf /var/lib/apt/lists/*


USER odoo
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
