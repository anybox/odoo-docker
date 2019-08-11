FROM registry.anybox.cloud/anybox/odoo-docker/debian:stretch

LABEL maintainer="Anybox"
ENV VERSION 12.0
ENV GHUSER OCA
ENV GHREPO OpenUpgrade

RUN cd /srv \
    && curl -o odoo.zip -sSL https://github.com/$GHUSER/$GHREPO/archive/$VERSION.zip \
    && unzip -q odoo.zip \
    && rm odoo.zip \
    && mv $GHREPO-$VERSION odoo \
    && pip3 install --no-cache-dir -e $GHREPO/ \
    && pip3 install --no-cache-dir -r $GHREPO/requirements.txt


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
