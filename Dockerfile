FROM ubuntu:latest
RUN apt-get update -y
RUN apt install default-jre
RUN ./mvnw package

