FROM java:8

RUN curl -O http://archive.apache.org/dist/tomcat/tomcat-8/v8.0.20/bin/apache-tomcat-8.0.20.tar.gz
RUN tar xzf apache-tomcat-8.0.20.tar.gz
EXPOSE 8080

COPY target/*.war /usr/local/tomcat/webapps/simplewebapp.war

CMD /usr/local/tomcat/bin/startup.sh && tail -f /usr/local/tomcat/logs/catalina.out