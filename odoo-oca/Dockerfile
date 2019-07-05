FROM registry.anybox.cloud/anybox/odoo-docker/odoo:12.0
MAINTAINER Anybox

RUN set -x; \
        cd /srv/extra-addons \
#
        ### DOWNLOAD MODULES
        && for repo in \
            OCA/web \
            OCA/server-brand \
            OCA/server-tools \
            Openworx/backend_theme \
            OCA/website \
            OCA/contract \
            OCA/project \
            OCA/l10n-france \
            OCA/partner-contact \
        ; do curl -o 12.0.zip -sSL https://github.com/$repo/archive/12.0.zip \
            && unzip 12.0.zip \
            && rm -rf ${repo#*/}-12.0/setup \
            && mv -f ${repo#*/}-12.0/* . \
            && rm -rf ${repo#*/}-12.0 \
        ; done \
        && rm -rf .gitignore README.md .travis.yml *zip
            
            
VOLUME /var/lib/odoo
COPY odoo.conf /etc/odoo/
