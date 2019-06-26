FROM debian:stretch
MAINTAINER Anybox
ENV DEBIAN_FRONTEND noninteractive
COPY sources.list /etc/apt/

ENV LANG C.UTF-8
ENV COMMIT 12.0
ENV SUDO_FORCE_REMOVE yes
RUN set -x; \
    apt-get update \
    && apt-get install -y --no-install-recommends \
        adduser \
        ca-certificates \
        curl \
        geoip-bin \
# unavailable #       geoip-database-contrib \
        libssl1.0-dev \
        lsb-base \
        node-clean-css \
        node-less \
        postgresql-client \
        python3-babel \
        python3-dateutil \
        python3-decorator \
        python3-docutils \
        python3-feedparser \
        python3-gevent \
        python3-html2text \
        python3-jinja2 \
        python3-libsass \
        python3-lxml \
        python3-mako \
        python3-mock \
        python3-passlib \
        python3-pil \
        python3-pip \
        python3-psutil \
        python3-psycopg2 \
        python3-pydot \
        python3-pyldap \
        python3-pyparsing \
        python3-pypdf2 \
        python3-qrcode \
        python3-renderpm \
        python3-reportlab \
        python3-requests \
        python3-setuptools \
        python3-suds \
        python3-tz \
        python3-vatnumber \
        python3-vobject \
        python3-werkzeug \
        python3-xlsxwriter \
        python3-yaml \
        xz-utils \
        unzip \
    && curl -o wkhtmltox.tar.xz -SL https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz \
    && tar xvf wkhtmltox.tar.xz \
    && cp wkhtmltox/lib/* /usr/local/lib/ \
    && cp wkhtmltox/bin/* /usr/local/bin/ \
    && cp -r wkhtmltox/share/man/man1 /usr/local/share/man/ \
    && rm -rf wkhtmltox

RUN cd /srv && curl -o odoo.zip -SL https://github.com/odoo/odoo/archive/${COMMIT}.zip \
    && unzip odoo.zip && rm odoo.zip && mv odoo-${COMMIT} odoo \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false \
        sudo \
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && pip3 install \
        simplejson==3.13.2 \
        unicodecsv==0.14.1


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
