FROM kartoza/geoserver:2.27.1
LABEL MAINTAINER="Denis Alekseev <fiz.alekseev@yandex.ru>"

ARG PASSWORD

COPY resources/geoserver-2.27-SNAPSHOT-jdbcstore-plugin/* /usr/local/tomcat/webapps/geoserver/WEB-INF/lib/
COPY resources/geoserver-2.27-SNAPSHOT-sec-oauth2-google-plugin/* /usr/local/tomcat/webapps/geoserver/WEB-INF/lib/

COPY resources/jjwt-0.9.1.jar /usr/local/tomcat/webapps/geoserver/WEB-INF/lib/
COPY resources/gs-sec-oauth2-google-2.27-SNAPSHOT.jar /usr/local/tomcat/webapps/geoserver/WEB-INF/lib/

COPY resources/setenv.sh /usr/local/tomcat/bin

RUN chmod 1777 /tmp

RUN set -eux; \
    apt update; \
    apt install -y --no-install-recommends ubuntu-keyring; \
    apt update; \
    apt install -y mc wget; \
    apt autoremove -y; \
    apt autoclean -y;

RUN wget -O /opt/apm-agent.jar https://search.maven.org/remotecontent?filepath=co/elastic/apm/elastic-apm-agent/1.55.0/elastic-apm-agent-1.55.0.jar

ENV SKIP_DEMO_DATA=true \
    GEOSERVER_ADMIN_USER=admin \
    GEOSERVER_ADMIN_PASSWORD=$PASSWORD \
    STABLE_EXTENSIONS=importer-plugin,jp2k-plugin \
    COMMUNITY_EXTENSIONS=ogr-datastore-plugin,sec-oauth2-google-plugin

EXPOSE 8080

RUN echo 'figlet -t CRG Docker GeoServer '2.27.1 >> ~/.bashrc

ENTRYPOINT ["/bin/bash", "/scripts/entrypoint.sh"]
