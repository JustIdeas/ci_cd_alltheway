#!/bin/bash
docker_install() {
    #garantindo a instalação do docker, seguindo a recomendação da página oficial.
    sudo apt-get remove docker docker-engine docker.io containerd runc
    sudo apt-get update
    sudo apt-get install -y \
        ca-certificates \
        curl \
        gnupg \
        lsb-release
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo \
        "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-compose
}

permission_dockerIndocker() {
    #777 sabemos que não é recomendado, mas para não despender tempo, resolvi deixar com as permissões máximas
    #Para que o docker do jenkins utilizei do mesmo ambiente do docker do host, é preciso mapear o docker.sock, como também, ajustar permissão de execução.
    #Mais detalhes do mapeamento, no dockercomposefile
    chmod 777 /var/run/docker.sock
    chmod 400 ci_cd_alltheway/cloud_sv_container/ssh_key_client/cloud_access
}

git_install() {
    #somente caso precise realizar algum commit através do host.
    apt install -y git-all
}

docker_install()
permission_dockerIndocker()
git_install()