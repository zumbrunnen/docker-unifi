FROM ubuntu:bionic
LABEL maintainer="David Zumbrunnen <zumbrunnen@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive
ENV UNIFI_VERSION 5.12.35

RUN apt-get update && apt-get -y install binutils libcap2 curl openjdk-8-jre-headless jsvc gnupg ca-certificates

RUN echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" > /etc/apt/sources.list.d/mongodb.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 0C49F3730359A14518585931BC711F9BA15703C6
RUN apt-get update && \
    apt-get -y install mongodb-org-server && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN curl -o unifi_sysvinit_all.deb http://dl.ubnt.com/unifi/${UNIFI_VERSION}/unifi_sysvinit_all.deb && \
    dpkg -i unifi_sysvinit_all.deb && \
    rm unifi_sysvinit_all.deb

VOLUME ["/var/lib/unifi"]

EXPOSE 8080 8081 8443 8843 8880 3478

WORKDIR /var/lib/unifi

ENTRYPOINT ["/usr/bin/java", "-Xmx1024M", "-jar", "/usr/lib/unifi/lib/ace.jar"]

CMD ["start"]
