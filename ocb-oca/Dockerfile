FROM registry.anybox.cloud/anybox/odoo-docker/ocb:9.0

LABEL maintainer="Anybox"
ENV VERSION 9.0

RUN set -x; \
    cd /srv/extra-addons \
#
    ### DOWNLOAD MODULES
    && for repo in \
        OCA/contract \
        OCA/crm \
        OCA/knowledge \
        OCA/l10n-france \
        OCA/partner-contact \
        OCA/project \
        OCA/server-brand \
        OCA/server-tools \
        OCA/web \
        OCA/website \
    ; do curl -o addons.zip -sSL https://github.com/$repo/archive/$VERSION.zip \
        && unzip -q addons.zip \
        && rm -rf ${repo#*/}-$VERSION/setup \
        && mv -f ${repo#*/}-$VERSION/* . \
        && rm -rf ${repo#*/}-$VERSION \
    ; done \
    && rm -rf .gitignore README.md .travis.yml *zip
            
            
VOLUME /var/lib/odoo
COPY odoo.conf /etc/odoo/
