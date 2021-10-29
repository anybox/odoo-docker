FROM debian:buster
LABEL maintainer="Anybox"
ENV DEBIAN_FRONTEND noninteractive

ARG GHUSER
ARG GHREPO

ENV VERSION 14.0
# change this to trigger a debian update:
# This should be probably be removed in the future if the images are force-rebuilt regularly
ENV LASTBUILD 2021102901

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
    && gpgconf --kill all \
    && rm -rf "$GNUPGHOME" \
    && sed -i 's/main/main contrib non-free/' /etc/apt/sources.list \
    && echo "deb http://deb.nodesource.com/node_8.x buster main" > /etc/apt/sources.list.d/nodesource.list \
    && echo "deb http://apt.postgresql.org/pub/repos/apt/ buster-pgdg main" > etc/apt/sources.list.d/pgdg.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        adduser \
        build-essential \
        ca-certificates \
        cargo \
        cron \
        curl \
        file \
        fonts-noto-cjk \
        # for geoip OCA modules:
        geoip-bin \
        # unavailable:
        #geoip-database-contrib \
	libffi-dev \
        libldap2-dev \ 
        libpq-dev \
        libsasl2-dev \
        libssl-dev \
        lsb-base \
        node-clean-css \
        node-less \
        nodejs \
        npm \
        poppler-utils \
        postgresql-client \
        python3-dev \
        python3-pip \
        python3-pyldap \
        python3-qrcode \
        python3-renderpm \
        python3-setuptools \
        python3-vobject \
        python3-watchdog \
        rustc \
        unzip \
        xz-utils \
    && curl -o wkhtmltox.deb -sSL https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.5/wkhtmltox_0.12.5-1.stretch_amd64.deb \
    && echo '7e35a63f9db14f93ec7feeb0fce76b30c08f2057 wkhtmltox.deb' | sha1sum -c - \
    && dpkg --force-depends -i wkhtmltox.deb \
    && apt-get -y install -f --no-install-recommends \
    && rm wkhtmltox.deb \
    && npm install --no-save -g rtlcss \
    && pip3 install --no-cache-dir -r https://github.com/$GHUSER/$GHREPO/raw/$VERSION/requirements.txt \
    && pip3 install pdfminer.six cffi cryptography \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false -o APT::AutoRemove::SuggestsImportant=false \
	libffi-dev \
        build-essential \
        libldap2-dev \ 
        libpq-dev \
        libsasl2-dev \
        python3-dev \
        rustc \
        sudo \
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
    && adduser --system --quiet --home /var/lib/odoo odoo

RUN cd /srv \
    && curl -o odoo.zip -sSL https://github.com/$GHUSER/$GHREPO/archive/$VERSION.zip \
    && unzip -q odoo.zip \
    && rm odoo.zip \
    && mv $GHREPO-$VERSION odoo \
    && pip3 install --no-cache-dir -e odoo/ \
    && pip3 install --no-cache-dir -r odoo/requirements.txt


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

