#!/bin/bash

cd /opt/XpertIvyServer5.0

# Copy the license optionally provided by the data volume at /opt/lic. If there is no license, we just run in demo mode
if [ $(find /opt/lic -maxdepth 1 -type f -name '*.lic' | wc -l) -eq 1 ]; then
	cp -f /opt/lic/*.lic configuration/

	jre/bin/java -cp lib/ivy/*:lib/shared/* \
		ch.ivyteam.ivy.server.configuration.ServerConfigurationTool -configDb org.postgresql.Driver jdbc:postgresql://${DB_PORT_5432_TCP_ADDR}:${DB_PORT_5432_TCP_PORT}/XpertIvySystemDatabase postgres;

	jre/bin/java -cp lib/ivy/*:lib/shared/* \
        	ch.ivyteam.ivy.server.configuration.ServerConfigurationTool -createDb;

        jre/bin/java -cp lib/ivy/*:lib/shared/* \
                ch.ivyteam.ivy.server.configuration.ServerConfigurationTool --serverProperty WebServer.HTTP.Port=8081;

	jre/bin/java -cp lib/ivy/*:lib/shared/* \
		ch.ivyteam.ivy.server.configuration.ServerConfigurationTool -createAdmin admin admin;
fi

bin/XpertIvyServer.sh
