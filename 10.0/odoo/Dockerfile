FROM debian:jessie
MAINTAINER Anybox
ENV DEBIAN_FRONTEND noninteractive
COPY sources.list /etc/apt/

ENV COMMIT 10.0
ENV SUDO_FORCE_REMOVE yes
RUN set -x; \
        apt-get update \
        && apt-get install -y --no-install-recommends \
            adduser \
            ca-certificates \
            curl \
            gdebi \
            geoip-bin \
# unavailable #            geoip-database-contrib \
            node-clean-css \
            node-less \
#            postgresql-client \
            python \
            python-babel \
            python-dateutil \
            python-decorator \
            python-docutils \
            python-feedparser \
            python-gevent \
            python-imaging \
            python-jinja2 \
            python-ldap \
            python-libxslt1 \
            python-lxml \
            python-mako \
            python-mock \
            python-openid \
            python-passlib \
            python-pip \
            python-psutil \
            python-psycopg2 \
            python-pychart \
            python-pydot \
            python-pyinotify \
            python-pyparsing \
            python-pypdf \
            python-renderpm \
            python-reportlab \
            python-requests \
            python-suds \
            python-support \
            python-tz \
            python-vatnumber \
            python-vobject \
            python-werkzeug \
            python-xlrd \
            python-xlsxwriter \
            python-xlwt \
            python-yaml \
            unzip \
            vim \
        && curl -o wkhtmltox.deb -SL http://nightly.odoo.com/extra/wkhtmltox-0.12.1.2_linux-jessie-amd64.deb \
        && echo '40e8b906de658a2221b15e4e8cd82565a47d7ee8 wkhtmltox.deb' | sha1sum -c - \
        && gdebi -n wkhtmltox.deb \
        && rm wkhtmltox.deb \
        && cd /srv && curl -o odoo.zip -SL https://github.com/odoo/odoo/archive/${COMMIT}.zip \
        && unzip odoo.zip && rm odoo.zip && mv odoo-${COMMIT} odoo \
        && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false \
            sudo \
        && apt-get clean && rm -rf /var/lib/apt/lists/* \
        && pip install \
            psycogreen==1.0 \
            simplejson==3.5.3 \
            unicodecsv==0.14.1 \
            unittest2==0.5.1


# Copy entrypoint script and Odoo configuration file
COPY ./entrypoint.sh /
RUN adduser --system --quiet odoo

# Mount /var/lib/odoo to allow restoring filestore and /mnt/extra-addons for users addons
RUN mkdir -p /mnt/extra-addons /var/lib/odoo \
        && chown -R odoo: /var/lib/odoo
VOLUME ["/var/lib/odoo", "/etc/odoo"]
COPY ./odoo.conf /etc/odoo/

# Set the default config file
ENV ODOO_RC /etc/odoo/odoo.conf

# Set default user when running the container
USER odoo

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/srv/odoo/odoo-bin"]
