FROM maven:3-jdk-8-alpine as maven-build
 RUN pwd
 WORKDIR /usr/src/app
 RUN pwd
 RUN ls
 COPY ./waconsumersurvey/src /usr/src/app/src
 #COPY bin /usr/src/app/
 COPY ./waconsumersurvey/pom.xml /usr/src/app/pom.xml
 RUN mvn clean package
 FROM tomcat:9.0.58-jdk11-openjdk-slim
 RUN mv /usr/local/tomcat/webapps /usr/local/tomcat/webapps2
 RUN mv /usr/local/tomcat/webapps.dist /usr/local/tomcat/webapps
 RUN rm -rf /usr/local/tomcat/webapps/ROOT
 COPY --from=maven-build /usr/src/app/target/consumersurvey-0.0.1-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war
# COPY tomcat/conf/* /usr/local/tomcat/conf/
 EXPOSE 8098
 CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]
