#Imagem base
FROM ruby:2.6.3

#Assinatura
MAINTAINER Rodrigo Martins

#Instala o ceedling versão 0.28.3 (última até então)
RUN gem install ceedling -v 0.28.3

#Determina uma variável com o nome da pasta que será criada a estrutura do projeto
ENV project_folder Test

#Cria o diretório de projeto
RUN ceedling new ${project_folder}

#Copia o project.yml para a a pasta destino
COPY project.yml ${project_folder}/

#Muda para a pasta do projeto
RUN cd ${project_folder}

#lista o conteúdo da pasta
RUN ls

#Executa o teste unitário
RUN ceedling test:all

