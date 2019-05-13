FROM debian:jessie
MAINTAINER Anybox
ENV DEBIAN_FRONTEND noninteractive
COPY sources.list /etc/apt/

ENV COMMIT 8.0
ENV SUDO_FORCE_REMOVE yes
RUN set -x; \
        apt-get update \
        && apt-get install -y --no-install-recommends wget ca-certificates \
        && wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | apt-key add - \
        && sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main" >> /etc/apt/sources.list.d/pgdg.list' \
        && apt-get update \
        && apt-get install -y --no-install-recommends \
            adduser \
            curl \
            cron \
            gdebi \
            geoip-bin \
# unavailable #            geoip-database-contrib \
            node-clean-css \
            node-less \
            postgresql-client-9.6 \
            python \
            python-babel \
            python-dateutil \
            python-decorator \
            build-essential python-dev libssl-dev libxml2-dev libxslt1-dev libjpeg62-turbo-dev libjpeg-dev zlib1g-dev libffi-dev \
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
            python-xlsxwriter \
            python-xlwt \
            python-yaml \
            unzip \
            vim \
        && curl -o wkhtmltox.deb -SL http://nightly.odoo.com/extra/wkhtmltox-0.12.1.2_linux-jessie-amd64.deb \
        && echo '40e8b906de658a2221b15e4e8cd82565a47d7ee8 wkhtmltox.deb' | sha1sum -c - \
        && gdebi -n wkhtmltox.deb \
        && rm wkhtmltox.deb \
        && cd /srv && curl -o odoo.zip -SL https://github.com/anybox/odoo/archive/${COMMIT}.zip \
        && unzip odoo.zip && rm odoo.zip && mv odoo-${COMMIT} odoo \
        && pip install --upgrade setuptools \
        && pip install \
            psycogreen==1.0 \
            simplejson==3.5.3 \
            unittest2==0.5.1 \
            py3o.template \
            py3o.formats \
            pysftp \
        && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false build-essential python-dev libssl-dev libxml2-dev libxslt1-dev libjpeg62-turbo-dev libjpeg-dev zlib1g-dev libffi-dev \
        && apt-get clean && rm -rf /var/lib/apt/lists/*


# Copy entrypoint script and Odoo configuration file
COPY ./entrypoint.sh /
RUN adduser --system --quiet odoo

# Mount /var/lib/odoo to allow restoring filestore and /mnt/extra-addons for users addons
RUN mkdir -p /mnt/extra-addons /var/lib/odoo \
        && chown -R odoo: /var/lib/odoo
VOLUME ["/var/lib/odoo", "/etc/odoo"]
COPY ./odoo.conf /etc/odoo/

# Set the default config file
ENV OPENERP_SERVER /etc/odoo/odoo.conf

# Set default user when running the container
USER odoo

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/srv/odoo/odoo.py"]
