FROM ubuntu:14.04
MAINTAINER Daniel Gauch <daniel@gauch.biz>

# Install wget and unzip 
RUN sudo apt-get update
RUN sudo apt-get install -y wget
RUN sudo apt-get install -y unzip 

# Download and extract Axon.ivy Engine
RUN sudo wget http://xpertivy.ch/releases/Xpert.ivy/5.0.12/downloads/XpertIvyServer5.0.12.46079_Linux_x64.zip
RUN sudo unzip XpertIvyServer5.0.12.46079_Linux_x64.zip -d /opt/XpertIvyServer5.0
RUN sudo rm -f XpertIvyServer5.0.12.46079_Linux_x64.zip

COPY start-xpertivy-server.sh /usr/local/bin/start-xpertivy-server.sh
RUN chmod +x /usr/local/bin/*.sh


ENV XPERTIVY_SERVER_DB_URL jdbc:postgresql://${DB_PORT_5432_TCP_ADDR}:${DB_PORT_5432_TCP_PORT}/XpertIvySystemDatabase
ENV XPERTIVY_SERVER_DB_USER postgres
# ENV XPERTIVY_SERVER_DB_PASS


VOLUME /data

EXPOSE 8081

CMD start-xpertivy-server.sh
