#!/bin/bash

cd /opt/XpertIvyServer5.0

cp -f /opt/lic/*.lic configuration/

jre/bin/java -cp lib/ivy/*:lib/shared/* \
	ch.ivyteam.ivy.server.configuration.ServerConfigurationTool -configDb org.postgresql.Driver jdbc:postgresql://${DB_PORT_5432_TCP_ADDR}:${DB_PORT_5432_TCP_PORT}/XpertIvySystemDatabase postgres

jre/bin/java -cp lib/ivy/*:lib/shared/* \
        ch.ivyteam.ivy.server.configuration.ServerConfigurationTool -createDb

jre/bin/java -cp lib/ivy/*:lib/shared/* \
	ch.ivyteam.ivy.server.configuration.ServerConfigurationTool -createAdmin admin admin

bin/XpertIvyServer.sh
