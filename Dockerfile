from jenkins/jenkins:lts-alpine
USER root

# Pipeline
RUN /usr/local/bin/install-plugins.sh sonarqube-generic-coverage && \
    /usr/local/bin/install-plugins.sh sonargraph-integration && \
    /usr/local/bin/install-plugins.sh github && \
    /usr/local/bin/install-plugins.sh ws-cleanup && \
    /usr/local/bin/install-plugins.sh nexus-artifact-uploader && \
    /usr/local/bin/install-plugins.sh kubernetes && \
    /usr/local/bin/install-plugins.sh docker-workflow && \
    /usr/local/bin/install-plugins.sh kubernetes-cli && \
    /usr/local/bin/install-plugins.sh github-branch-source

# install Maven, Java, Docker, AWS
RUN apk add --no-cache maven \
    openjdk8 \
    docker

# Kubectl
RUN  wget https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl

# THIS IS FOR POC ONLY - it is not production standard (we're running as root!)
RUN chown -R root "$JENKINS_HOME" /usr/share/jenkins/ref
