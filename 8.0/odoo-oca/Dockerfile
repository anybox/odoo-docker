FROM anybox/odoo:8.0
MAINTAINER Anybox

USER root

# Install some deps, lessc and less-plugin-clean-css, and wkhtmltopdf
RUN set -x; \
        apt-get update \
        && apt-get install -y --no-install-recommends mercurial git \
        && mkdir -p /mnt/repositories /mnt/custom-addons \
        && cd /mnt/repositories \

        ### DOWNLOAD MODULES
        && git clone -b master https://github.com/anybox/old_addons.git \
        && ln -srf old_addons/document_page ../extra-addons/ \
        ###
        && hg clone --config ui.tls=false -b 8.0 https://bitbucket.org/anybox/advanced_attachment \
        && ln -srf advanced_attachment/attachment_large_object ../extra-addons/ \
        && ln -srf advanced_attachment/document_desable_attachment ../extra-addons/ \
        ###
        && git clone -b 8.0 https://github.com/oca/server-tools.git \
        && ln -srf server-tools/* ../extra-addons/ \
        ###
        && git clone -b 8.0 https://github.com/OCA/reporting-engine.git \
        && ln -srf reporting-engine/* ../extra-addons/ \
        ###
        && git clone -b 8.0 https://github.com/OCA/bank-payment.git \
        && ln -srf bank-payment/* ../extra-addons/ \

        ## AUTO-INSTALL MODULES
	&& sed -i "s/'auto_install'.*False/'auto_install': True/" ../extra-addons/attachment_large_object/__openerp__.py \
	&& sed -i "s/'auto_install'.*False/'auto_install': True/" ../extra-addons/disable_openerp_online/__openerp__.py

VOLUME /etc/odoo /var/lib/odoo
COPY odoo.conf /etc/odoo/
USER odoo
