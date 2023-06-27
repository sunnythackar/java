FROM ubuntu
MAINTAINER prathap
RUN apt-get update && apt install openjdk-11-jre-headless -y
WORKDIR /opt/tomcat
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.76/bin/apache-tomcat-9.0.76.tar.gz .
RUN tar -zxvf apache-tomcat-9.0.76.tar.gz && mv apache-tomcat-9.0.76/* /opt/tomcat
RUN rm -rf opt/tomcat/webapps/ROOT
COPY --from=maven-build /
