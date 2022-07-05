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
    sudo apt-get install -y \
            docker-ce \
            docker-ce-cli \
            containerd.io \
            docker-compose-plugin \
            docker-compose
}

permission_dockerIndocker() {
    #777 sabemos que não é recomendado, mas para não despender tempo, resolvi deixar com as permissões máximas
    #Para que o docker do jenkins utilizei do mesmo ambiente do docker do host, é preciso mapear o docker.sock, como também, ajustar permissão de execução.
    #Mais detalhes do mapeamento, no dockercomposefile
    chmod 777 /var/run/docker.sock
    chmod 400 cloud_sv_container/ssh_key_client/cloud_access
}

unpack_jenkinshome(){
    # A descição de utilização do volume compactado foi pelo fato do commit ou save da imagem não armazenarem o conteudo do volume (mesmo montado sem volume externo),
    # dificultando a criação do ambiente com jenkins, no qual teria que reconfigurar a cada subida das imagens. Desta forma o mesmo ja vem pre-configurado com os detalhes
    # de acesso e configurações relacionadas aos serviços GO, ansible e também com as chaves SSH armazenadas.

    #Importante: no commit, é preciso fazer o caminho inverso, compactar o volume e remover o diretório, mantendo somente o volume compactado.
    # O volume descompactado fica o dobro do tamanho, dificultando o uso do github por questões de espaço máximo, e também pelo tempo de clone, quando executado pela pipeline.
    fileid="10flmGCvlayPi6HfHCWrS-l2wUHhrz_VC"
    filename="jenkins_volume.tar.zst"
    html=`curl -c ./cookie -s -L "https://drive.google.com/uc?export=download&id=${fileid}"`
    curl -Lb ./cookie "https://drive.google.com/uc?export=download&`echo ${html}|grep -Po '(confirm=[a-zA-Z0-9\-_]+)'`&id=${fileid}" -o ${filename}
    mkdir jenkins_files/jenkins_volume
    tar --zstd -xf  jenkins_volume.tar.zst -C jenkins_files/jenkins_volume
    rm -f jenkins_volume.tar.zst
}

docker_install
permission_dockerIndocker
unpack_jenkinshome