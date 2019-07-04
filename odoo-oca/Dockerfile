FROM anybox/odoo-docker/odoo:12.0
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
        ; do curl -SL https://github.com/$repo/12.0.zip \
            && unzip 12.0.zip \
            && mv -f ${repo#*/}-12.0/* . \
            && rmdir ${repo#*/}-12.0 \
        ; done \
        && rm -rf setup .gitignore README.md .travis.yml *zip
            
            
VOLUME /var/lib/odoo
COPY odoo.conf /etc/odoo/
