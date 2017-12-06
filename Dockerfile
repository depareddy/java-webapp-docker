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

RUN curl -O http://archive.apache.org/dist/tomcat/tomcat-8/v8.5.9/bin/apache-tomcat-8.5.9.tar.gz
RUN tar xzf apache-tomcat-8.5.9.tar.gz
ADD /code/target/simplewebapp.war apache-tomcat-8.5.9/webapps/
 

CMD apache-tomcat-8.5.9/bin/startup.sh && tail -f apache-tomcat-8.5.9/logs/catalina.out