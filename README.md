
[![Challenge Accepted!](https://st2.depositphotos.com/2801893/8670/v/380/depositphotos_86708922-stock-illustration-challenge.jpg?forcejpeg=true)](https://st2.depositphotos.com) 

[![GitHub contributors](https://img.shields.io/github/contributors/JustIdeas/ci_cd_alltheway)](https://github.com/JustIdeas/ci_cd_alltheway/graphs/contributors) [![GitHub issues](https://img.shields.io/github/issues/JustIdeas/ci_cd_alltheway)](https://github.com/coderjojo/JustIdeas/ci_cd_alltheway/issues) [![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](https://github.com/JustIdeas/ci_cd_alltheway/pulls) [![HitCount](https://views.whatilearened.today/views/github/JustIdeas/ci_cd_alltheway.svg)](https://github.com/JustIdeas/ci_cd_alltheway/) 

# Resumo sobre o projeto
A idéia deste projeto é a criação de um ambiente DebOps, utilizando do jenkins para a criação de uma pipeline na qual possui test, build, publish e deploy, sendo o deploy realizado pelo ansible, com um playbook especifico.

# Ambiente e suas particularidades
Todo o ambiente roda em containers, sendo um o jenkins e o outro uma máquina simulando um servidor na núvem (onde o ansible irá dar o deploy da infra). o volume mapeado para o jenkins é um volume fixo, no qual é realizado um download do volume compactado do drive e depois descompactado na pasta onde o volume do container jenkins está esperando.

## Responsabilidade dos scripts
### preparando_infra.sh
Primeiro script a ser executado após clone do repositório. Irá instalar o docker, dar permissionamento nos arquivos nescessários para rodar "docker in docker" e irá realizar o download do volume fixo do jenkins. 
Detalhe que em um ambiente de produção, geralmente se mapeia no próprio host o volume ou em algum servidor de arquivos, só utilizei desta forma para que o tudo rodasse em um único local não considerando espaço em núvem e nem que o usuário deste projeto fosse realizar toda a configuração manualmente.

### Docker_compose.yml
Para subir o ambiente como um todo, deve ser executado o docker-compose passando este arquivo, com o parâmetro build. Desta forma, todas as imagens nescessárias do jenkins e da aplicação cloud (local) irá ser realizado de forma automática (cada projeto possui um Dockerfile).
Importante salientar que para que o "docker in docker" funcione corretamente, é nescessário mapear o docker.sock do host com o do container, e dar as permissões corretas (confia :) )




