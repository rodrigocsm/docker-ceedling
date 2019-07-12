#Imagem base
FROM i386/ruby

#Assinatura
MAINTAINER Rodrigo Martins

#Instala o ceedling versão 0.28.3 (última até então)
RUN gem install ceedling -v 0.28.3

#Instala o gcovr (Necessário para rodar o comando gcov)
RUN apt-get update && apt-get install -y python python-pip && python -m pip install gcovr

ENTRYPOINT ["\bin\bash"]

