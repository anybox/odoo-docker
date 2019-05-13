FROM anybox/odoo:11.0
MAINTAINER Anybox

USER root

RUN set -x; \
        apt-get update \
        && apt-get install -y --no-install-recommends git \
        && mkdir -p /mnt/repositories /mnt/custom-addons \
        && cd /mnt/repositories \
#
        ### DOWNLOAD MODULES
        && git clone -b 11.0 https://github.com/OCA/web \
        && ln -srf web/* ../extra-addons/ \
#
        && git clone -b 11.0 https://github.com/OCA/server-brand \
        && ln -srf server-brand/* ../extra-addons/ \
#
        && git clone -b 11.0 https://github.com/OCA/server-tools \
        && ln -srf server-tools/* ../extra-addons/ \
#
        && git clone -b 11.0 https://github.com/Openworx/backend_theme \
        && ln -srf backend_theme/backend_theme_v11 ../extra-addons/ \
#
        && git clone -b 11.0 https://github.com/OCA/website \
        && ln -srf website/* ../extra-addons/ \
#
        && git clone -b 11.0 https://github.com/OCA/contract \
        && ln -srf contract/* ../extra-addons/ \
#
        && git clone -b 11.0 https://github.com/OCA/project \
        && ln -srf project/* ../extra-addons/ \
#
        && git clone -b 11.0 https://github.com/OCA/l10n-france \
        && ln -srf l10n-france/* ../extra-addons/ \
#
        && git clone -b 11.0 https://github.com/OCA/partner-contact \
        && ln -srf partner-contact/* ../extra-addons/

VOLUME /etc/odoo /var/lib/odoo
COPY odoo.conf /etc/odoo/
USER odoo
