FROM java:8 

RUN curl -O http://archive.apache.org/dist/tomcat/tomcat-8/v8.5.9/bin/apache-tomcat-8.5.9.tar.gz
RUN tar xzf apache-tomcat-8.5.9.tar.gz
ADD /target/simplewebapp.war apache-tomcat-8.5.9/webapps/


CMD apache-tomcat-8.5.9/bin/startup.sh && tail -f apache-tomcat-8.5.9/logs/catalina.out
EXPOSE 8080

