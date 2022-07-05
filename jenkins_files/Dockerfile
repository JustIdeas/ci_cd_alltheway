FROM jenkins/jenkins:jdk11
USER root
RUN apt-get update && apt-get install -y lsb-release
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
    https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y make build-essential docker-ce docker-ce-cli containerd.io docker-compose ansible
USER jenkins
RUN jenkins-plugin-cli --plugins "docker-commons:1.19 docker-workflow:1.29 docker-build-step:2.8 ansible:1.1 github:1.34.4 docker-plugin:1.2.9"
