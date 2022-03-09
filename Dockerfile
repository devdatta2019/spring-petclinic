FROM parrotstream/ubuntu-java
RUN apt-get update -y
RUN ./mvnw package

