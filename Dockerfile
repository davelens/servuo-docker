FROM ubuntu:20.04

RUN apt-get update && apt-get install -y wget && \
    wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    apt-get update && \
    apt-get install -y apt-transport-https && \
    apt-get install -y dotnet-sdk-5.0 zlib1g-dev mono-complete make

ENV CONTAINER_SERVUO_DIR /servuo
ENV CONTAINER_GAME_FILES_DIR /game_files
RUN mkdir $CONTAINER_SERVUO_DIR $CONTAINER_GAME_FILES_DIR
WORKDIR $CONTAINER_SERVUO_DIR

EXPOSE 2593
