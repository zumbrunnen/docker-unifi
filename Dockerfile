FROM ubuntu:latest
LABEL maintainer="David Zumbrunnen <zumbrunnen@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y install gnupg ca-certificates

RUN echo "deb http://www.ubnt.com/downloads/unifi/debian stable ubiquiti" > /etc/apt/sources.list.d/unifi.list
RUN echo "deb https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" > /etc/apt/sources.list.d/mongodb.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv C0A52C50
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5

RUN apt-get update && \
    apt-get -y install unifi && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME ["/var/lib/unifi"]

EXPOSE 8080 8081 8443 8843 8880 3478

WORKDIR /var/lib/unifi

ENTRYPOINT ["/usr/bin/java", "-Xmx1024M", "-jar", "/usr/lib/unifi/lib/ace.jar"]

CMD ["start"]
