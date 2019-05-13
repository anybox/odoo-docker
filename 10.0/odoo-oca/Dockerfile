FROM anybox/odoo:10.0
MAINTAINER Anybox

USER root

# Install some deps, lessc and less-plugin-clean-css, and wkhtmltopdf
RUN set -x; \
        apt-get update \
        && apt-get install -y --no-install-recommends mercurial git \
        && mkdir -p /mnt/repositories /mnt/custom-addons
	
WORKDIR /mnt/repositories

### DOWNLOAD MODULES
RUN git clone --depth 1 -b 10.0 https://github.com/OCA/web \
    && ln -srf web/* ../extra-addons/

RUN git clone --depth 1 -b 10.0 https://github.com/OCA/server-tools \
    && ln -srf server-tools/* ../extra-addons/

RUN git clone --depth 1 -b 10.0 https://github.com/Openworx/backend_theme \
    && ln -srf backend_theme/backend_theme_v10 ../extra-addons/

RUN git clone --depth 1 -b 10.0 https://github.com/OCA/contract \
    && ln -srf contract/* ../extra-addons/

RUN git clone --depth 1 -b 10.0 https://github.com/OCA/l10n-france \
    && ln -srf l10n-france/* ../extra-addons/

RUN git clone --depth 1 -b 10.0 https://github.com/OCA/partner-contact \
    && ln -srf partner-contact/* ../extra-addons/

RUN git clone --depth 1 -b 10.0 https://github.com/OCA/geospatial \
    && ln -srf geospatial/* ../extra-addons/ \
    && apt-get install -y libgeos-dev \
    && pip install geojson==2.4.0 shapely==1.6.4.post2


VOLUME /etc/odoo /var/lib/odoo
COPY odoo.conf /etc/odoo/
USER odoo
