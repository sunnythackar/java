FROM maven:3-jdk-8-alpine as maven-build
 RUN pwd
 WORKDIR /usr/src/app
 RUN pwd
 RUN ls
 COPY ./waconsumersurvey/src /usr/src/app/src
 #COPY bin /usr/src/app/
 COPY ./waconsumersurvey/pom.xml /usr/src/app/pom.xml
 RUN mvn clean package
FROM ubuntu
MAINTAINER prathap
RUN apt-get update && apt install openjdk-11-jre-headless -y
WORKDIR /opt/tomcat
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.76/bin/apache-tomcat-9.0.76.tar.gz .
RUN tar -zxvf apache-tomcat-9.0.76.tar.gz && mv apache-tomcat-9.0.76/* /opt/tomcat
RUN rm -rf opt/tomcat/webapps/ROOT
COPY --from=maven-build /usr/src/app/target/consumersurvey-0.0.1-SNAPSHOT.war /opt/tomcat/webapps/ROOT.war
RUN mv /opt/tomcat/webapps/ROOT /opt/tomcat/webapps/consumersurvey/
EXPOSE 8080
CMD ["/opt/tomcat/bin/catalina.sh","run"]
