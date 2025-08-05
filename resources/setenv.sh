#!/usr/bin/env bash

export CATALINA_OPTS="$CATALINA_OPTS -javaagent:/opt/apm-agent.jar"
export CATALINA_OPTS="$CATALINA_OPTS -Delastic.apm.service_name=geoserver"
export CATALINA_OPTS="$CATALINA_OPTS -Delastic.apm.application_packages=org.geoserver"
export CATALINA_OPTS="$CATALINA_OPTS -Delastic.apm.enable_log_correlation=true"
export CATALINA_OPTS="$CATALINA_OPTS -Delastic.apm.server_urls=${APM_URL}"
