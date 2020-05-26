FROM tomcat:8.5

ENV WEBPROTEGE_VERSION="2.5.0"
ENV JAVA_OPTS="$JAVA_OPTS -Dfile.encoding=UTF-8"

WORKDIR /usr/local/tomcat/webapps

RUN rm -rf * 

COPY webprotege-2.5.0.war /usr/local/tomcat/webapps

RUN mkdir -p /data/webprotege
RUN unzip -q webprotege-2.5.0.war -d ROOT
RUN rm webprotege-2.5.0.war

COPY config/webprotege.properties ROOT/webprotege.properties
COPY config/mail.properties ROOT/mail.properties

RUN sed -i "s/\(application.version *= *\).*/\1$WEBPROTEGE_VERSION/" ROOT/webprotege.properties

EXPOSE 8080
VOLUME /data/webprotege

CMD ["catalina.sh", "run"]
