FROM tomcat:9-jdk17

COPY target/*.war /usr/local/tomcat/webapps/

EXPOSE 8080

CMD ["/usr/local/tomcat/bin/catalina.sh","run"] 

