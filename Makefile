SHELL := /bin/bash
.PHONY: docker_install permissions unpack_jenkinshome

all: docker_install permissions unpack_jenkinshome

USERNAME_BUILD   = admin
TOKEN_API_JK     = 1118bbf9f941612d92418b42217f6f5d30
IP_PORT_JK		 = 192.168.4.37:53400

docker_install:
			#garantindo a instalação do docker, seguindo a recomendação da página oficial.
			apt-get remove docker docker-engine docker.io containerd runc
			apt-get update
			apt-get install -y \
				ca-certificates \
				curl \
				gnupg \
				lsb-release
			mkdir -p /etc/apt/keyrings
			curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
			echo \
				"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
				$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
			apt-get update
			apt-get install -y \
					docker-ce \
					docker-ce-cli \
					containerd.io \
					docker-compose-plugin \
					docker-compose
					
permissions:
			# 777 sabemos que não é recomendado, mas para não despender tempo, resolvi deixar com as permissões máximas
			#Para que o docker do jenkins utilizei do mesmo ambiente do docker do host, é preciso mapear o docker.sock, como também, ajustar permissão de execução.
			#Mais detalhes do mapeamento, no dockercomposefile
			chmod 777 /var/run/docker.sock
			chmod 400 cloud_sv_container/ssh_key_client/cloud_access

unpack_jenkinshome:
			# A descição de utilização do volume compactado foi pelo fato do commit ou save da imagem não armazenarem o conteudo do volume (mesmo montado sem volume externo),
			# dificultando a criação do ambiente com jenkins, no qual teria que reconfigurar a cada subida das imagens. Desta forma o mesmo ja vem pre-configurado com os detalhes
			# de acesso e configurações relacionadas aos serviços GO, ansible e também com as chaves SSH armazenadas.

			#Importante: no commit, é preciso fazer o caminho inverso, compactar o volume e remover o diretório, mantendo somente o volume compactado.
			# O volume descompactado fica o dobro do tamanho, dificultando o uso do github por questões de espaço máximo, e também pelo tempo de clone, quando executado pela pipeline.
			bash ./download_jk_volume.sh
			mv jenkins_home.tar.zst jenkins_files/
			tar --zstd -xf  jenkins_files/jenkins_home.tar.zst -C jenkins_files/
			rm -f jenkins_files/jenkins_home.tar.zst

trigger_build:
			#Para ciração do do trigger pela API do jenkins, é preciso criar uma API token para o usuário, e depois obter o Jenkins-Crumb com o comando abaixo
			# wget -q --auth-no-challenge --user {user} --password {password} --output-document - 'http://{ip}:{port}/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)'
			curl -I -X POST "http://$(USERNAME_BUILD):$(TOKEN_API_JK)@$(IP_PORT_JK)/job/players_app_pipeline/build" -H "Jenkins-Crumb:583f894a2ae86d07687729dbebd11f892571ab16e11a21197c928b87fa7d9984"
