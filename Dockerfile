FROM java:8 AS BUILD
ENV APP_HOME=/root/code/
RUN rm -rf $APP_HOME
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

# Prepare by downloading dependencies
 ADD pom.xml $APP_HOME/pom.xml
 
# Adding source, compile and package into a fat jar
ADD src $APP_HOME/src

# Install maven
RUN apt-get update
RUN apt-get install -y maven

RUN ["mvn", "dependency:resolve"]
RUN ["mvn", "verify"]
RUN ["mvn", "clean"]
RUN ["mvn", "package"]

FROM tomcat:8.0.20-jre8
# WORKDIR /root/
EXPOSE 8080 

COPY --from=BUILD /root/code/target/*.war /usr/local/tomcat/webapps/simplewebapp.war

CMD /usr/local/tomcat/bin/startup.sh && tail -f /usr/local/tomcat/logs/catalina.out