FROM ubuntu:bionic
USER root
RUN apt-get update && apt-get install -y lsb-release curl gpg
RUN  mkdir -p /etc/apt/keyrings && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
RUN echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update && apt-get install -y make build-essential docker-ce docker-ce-cli containerd.io docker-compose openssh-server
RUN systemctl enable ssh
RUN mkdir /ssh_keys
COPY ssh_key_pub/cloud_access.pub /ssh_keys
COPY docker-entrypoint.sh .
RUN chmod +x docker-entrypoint.sh
RUN mkdir ~/.ssh && cat /ssh_keys/cloud_access.pub >> ~/.ssh/authorized_keys
RUN chmod 600 ~/.ssh/authorized_keys

ENTRYPOINT ["/bin/bash", "docker-entrypoint.sh"]