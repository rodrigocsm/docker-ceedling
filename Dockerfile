#Imagem base
FROM ruby:2.6.3

#Assinatura
MAINTAINER Rodrigo Martins

#Instala o ceedling versão 0.28.3 (última até então)
RUN gem install ceedling -v 0.28.3

#Instala o gcovr
RUN apt-get install python3-pip
RUN pip install gcovr

#Determina uma variável com o nome da pasta que será criada a estrutura do projeto
ENV project_folder Test

RUN mkdir -p /usr/work/${project_folder}/

WORKDIR /usr/work/${project_folder}/

#Cria o diretório de projeto
RUN cd /usr/work/${project_folder}/ && ls
RUN ceedling new .

#Copia o project.yml para a a pasta destino
COPY project.yml /usr/work/${project_folder}/

#Executa o teste unitário
RUN ceedling clobber gcov:all utils:gcov

