#Imagem base
FROM ruby:2.6.3

#Assinatura
MAINTAINER Rodrigo Martins

#Determina uma variável com o nome da pasta que será criada a estrutura do projeto
ENV project_folder /usr/local/work

#Cria a pasta de trabalho na imagem
RUN mkdir -p ${project_folder}
WORKDIR ${project_folder}

#Localização (Corrige erro de codificação)
ENV LANG C.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL C.UTF-8 

#Instala o ceedling versão 0.28.3 (última até então)
RUN gem install ceedling -v 0.28.3

#Instala o gcovr (Necessário para rodar o comando gcov)
RUN apt-get update && apt-get install -y python python-pip && python -m pip install gcovr

#Copia os arquivos para a imagem
COPY src* ${project_folder}/src
COPY test* ${project_folder}/test

#Cria o diretório de projeto
RUN cd ${project_folder}
RUN ceedling new .

#Copia o project.yml para a a pasta destino
COPY project.yml ${project_folder}/

#Executa o teste unitário
ENTRYPOINT ["ceedling"]
CMD ["clobber", "gcov:all", "utils:gcov"]

