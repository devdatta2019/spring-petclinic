FROM ubuntu:latest
RUN apt-get update -y
RUN  apt install openjdk-11-jre-headless
RUN ./mvnw package
RUN java -jar target/*.jar
