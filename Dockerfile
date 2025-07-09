FROM docker.osgeo.org/geoserver:2.27.1
LABEL MAINTAINER="Denis Alekseev <fiz.alekseev@yandex.ru>"

ARG PASSWORD

COPY resources/*.zip /opt/additional_libs/

RUN chmod 1777 /tmp

RUN set -eux; \
    apt update; \
    apt install -y --no-install-recommends ubuntu-keyring; \
    apt update; \
    apt install -y mc; \
    apt autoremove -y; \
    apt autoclean -y;

ENV SKIP_DEMO_DATA=true \
    GEOSERVER_ADMIN_USER=admin \
    GEOSERVER_ADMIN_PASSWORD=$PASSWORD \
    GEOSERVER_DATA_DIR=/opt/geoserver_data \
    STABLE_EXTENSIONS=importer,jp2k \
    COMMUNITY_EXTENSIONS=ogr-datastore,jdbcconfig,jdbcstore,sec-oauth2-crg

EXPOSE 8080

ENTRYPOINT ["bash", "/opt/startup.sh"]
