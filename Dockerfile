FROM java:8 

# Install maven
RUN apt-get update
RUN apt-get install -y maven

WORKDIR /code

# Prepare by downloading dependencies
 ADD pom.xml /code/pom.xml
 
# Adding source, compile and package into a fat jar
ADD src /code/src
RUN ["mvn", "dependency:resolve"]
RUN ["mvn", "verify"]
RUN ["mvn", "clean"]
RUN ["mvn", "install"]

ADD /root/.m2/repository/docker-jenkins-ecs/simplewebapp/1.0-SNAPSHOT/simplewebapp-1.0-SNAPSHOT.war /code/simplewebapp.war


RUN curl -O http://archive.apache.org/dist/tomcat/tomcat-8/v8.5.9/bin/apache-tomcat-8.5.9.tar.gz
RUN tar xzf apache-tomcat-8.5.9.tar.gz
ADD /code/simplewebapp.war apache-tomcat-8.5.9/webapps/
 

CMD apache-tomcat-8.5.9/bin/startup.sh && tail -f apache-tomcat-8.5.9/logs/catalina.out