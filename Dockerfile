FROM kartoza/geoserver:2.27.1
LABEL MAINTAINER="Denis Alekseev <fiz.alekseev@yandex.ru>"

ARG PASSWORD

COPY resources/*.zip /tmp/resources/plugins/community_plugins/

COPY resources/jjwt-0.9.1.jar /usr/local/tomcat/webapps/geoserver/WEB-INF/lib/
COPY resources/gs-sec-oauth2-google-2.27-SNAPSHOT.jar /usr/local/tomcat/webapps/geoserver/WEB-INF/lib/

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
    STABLE_EXTENSIONS=importer-plugin,jp2k-plugin \
    COMMUNITY_EXTENSIONS=ogr-datastore-plugin,sec-oauth2-google-plugin

EXPOSE 8080

RUN echo 'figlet -t CRG Docker GeoServer '2.27.1 >> ~/.bashrc

ENTRYPOINT ["/bin/bash", "/scripts/entrypoint.sh"]
