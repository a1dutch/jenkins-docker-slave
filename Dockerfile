FROM jenkins/jnlp-slave:3.19-1

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1
ENV DEBIAN_FRONTEND noninteractive
ENV container=docker

USER root

ARG DOCKER_VERSION=18.03.1

RUN apt-get update

RUN apt-get update -qq && apt-get install -qqy \
   apt-transport-https \
   ca-certificates \
   curl \
   gnupg2 \
   software-properties-common && \
   rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

RUN apt-get update && apt-get install docker-ce=${DOCKER_VERSION}~ce-0~debian -qqy && \
     rm -rf /var/lib/apt/lists/*

RUN usermod -a -G docker jenkins

ADD wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/wrapdocker
VOLUME /var/lib/docker

ADD jenkins-slave-startup.sh /
RUN chmod +x /jenkins-slave-startup.sh

ENTRYPOINT ["/jenkins-slave-startup.sh"]
