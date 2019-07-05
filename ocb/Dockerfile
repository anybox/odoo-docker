FROM registry.anybox.cloud/anybox/odoo-docker/debian:stretch

LABEL maintainer="Anybox"
ENV VERSION 12.0

RUN cd /srv \
    && curl -o OCB.zip -SL https://github.com/OCA/OCB/archive/$VERSION.zip \
    && unzip -q OCB.zip \
    && rm OCB.zip \
    && mv OCB-$VERSION OCB \
    && pip3 install --no-cache-dir -e OCB/ \
    && pip3 install --no-cache-dir -r OCB/requirements.txt


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
