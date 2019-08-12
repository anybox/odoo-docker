FROM debian:jessie
LABEL maintainer="Anybox"
ENV DEBIAN_FRONTEND noninteractive

ENV GHUSER OCA
ENV GHREPO OCB

ENV VERSION 10.0
# change this to trigger a debian update:
ENV LASTBUILD 2019081101

# Generate locale C.UTF-8 for postgres and general locale data
ENV LANG C.UTF-8

RUN set -x; \
    apt-get update \
    && apt-get install -y --no-install-recommends dirmngr gnupg \
        && export GNUPGHOME="$(mktemp -d)" \
        && repokey='B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8' \
        && gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "${repokey}" \
        && gpg --armor --export "${repokey}" | apt-key add - \
    && repokey='9FD3B784BC1C6FC31A8A0A1C1655A0AB68576280' \
    && gpg --batch --keyserver keyserver.ubuntu.com --recv-keys "${repokey}" \
    && gpg --armor --export "${repokey}" | apt-key add - \
    && rm -rf "$GNUPGHOME" \
    && sed -i 's/main/main contrib non-free/' /etc/apt/sources.list \
    && echo "deb http://deb.nodesource.com/node_8.x jessie main" > /etc/apt/sources.list.d/nodesource.list \
    && echo "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main" > etc/apt/sources.list.d/pgdg.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        adduser \
        ca-certificates \
        cron \
        curl \
        # for geoip OCA modules:
        geoip-bin \
        # unavailable:
        #geoip-database-contrib \
        build-essential \
        libffi-dev \
        libjpeg-dev \
        libjpeg62-turbo-dev \
        libldap2-dev \
        libpq-dev \
        libsasl2-dev \
        libssl-dev \
        libxml2-dev \
        libxslt1-dev \
        lsb-base \
        node-clean-css \
        node-less \
        nodejs \
        postgresql-client \
        python-dev \
        python-pip \
        python-qrcode \
        python-renderpm \
        python-setuptools \
        python-vobject \
        python-watchdog \
        unzip \
        xz-utils \
        zlib1g-dev \
    && curl -o wkhtmltox.deb -sSL https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.jessie_amd64.deb \
    && echo '4d104ff338dc2d2083457b3b1e9baab8ddf14202 wkhtmltox.deb' | sha1sum -c - \
    && dpkg --force-depends -i wkhtmltox.deb \
    && apt-get -y install -f --no-install-recommends \
    && rm wkhtmltox.deb \
    && npm install --no-save -g rtlcss \
    && pip install --upgrade pip \
    && pip install simplejson num2words unicodecsv phonenumbers \
    && pip install -r https://github.com/$GHUSER/$GHREPO/raw/$VERSION/requirements.txt \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false \
        build-essential \
        libffi-dev \
        libjpeg-dev \
        libjpeg62-turbo-dev \
        libldap2-dev \
        libpq-dev \
        libsasl2-dev \
        libxml2-dev \
        libxslt1-dev \
        python-dev \
        sudo \
        zlib1g-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && adduser --system --quiet odoo

RUN cd /srv \
    && curl -o odoo.zip -sSL https://github.com/$GHUSER/$GHREPO/archive/$VERSION.zip \
    && unzip -q odoo.zip \
    && rm odoo.zip \
    && mv $GHREPO-$VERSION odoo \
    && pip install --no-cache-dir -e odoo/ \
    && pip install --no-cache-dir -r odoo/requirements.txt


COPY ./entrypoint.sh /

RUN mkdir -p /srv/extra-addons /srv/custom-addons /var/lib/odoo \
        && chown -R odoo: /srv/extra-addons /srv/custom-addons /var/lib/odoo
COPY ./odoo.conf /etc/odoo/
RUN chown odoo /etc/odoo/odoo.conf
VOLUME ["/var/lib/odoo"]

EXPOSE 8069 8072

ENV ODOO_RC /etc/odoo/odoo.conf

USER odoo

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/srv/odoo/odoo-bin"]

