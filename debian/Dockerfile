FROM debian:jessie
LABEL maintainer="Anybox"
ENV DEBIAN_FRONTEND noninteractive
ENV VERSION 9.0
# change this to trigger a debian update:
# This should be probably be removed in the future if the images are force-rebuilt regularly
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
        curl \
        # for geoip OCA modules:
        geoip-bin \
        # unavailable:
        #geoip-database-contrib \
        build-essential \
        cron \
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
        python-ldap \
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
    && echo '7e35a63f9db14f93ec7feeb0fce76b30c08f2057 wkhtmltox.deb' | sha1sum -c - \
    && dpkg --force-depends -i wkhtmltox.deb \
    && apt-get -y install -f --no-install-recommends \
    && rm wkhtmltox.deb \
    && npm install --no-save -g rtlcss \
    && python -m pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir simplejson num2words unicodecsv phonenumbers \
    && pip install --no-cache-dir -r https://github.com/odoo/odoo/raw/$VERSION/requirements.txt \
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
