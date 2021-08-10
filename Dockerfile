FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y wget && \
    wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    apt-get update && \
    apt-get install -y apt-transport-https && \
    apt-get update && \
    apt-get install -y dotnet-sdk-5.0 zlib1g-dev mono-complete make

ENV UO_HOME /UO
RUN mkdir $UO_HOME
WORKDIR $UO_HOME

EXPOSE 2593
