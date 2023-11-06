FROM openjdk:11 AS BUILD_IMAGE
RUN apt-get update && apt install maven -y
RUN git clone https://github.com/aasim-s/vprofile-project.git
WORKDIR /vprofile-project 
RUN git checkout docker && mvn install

FROM tomcat:9-jre11

LABEL "Project"="Vprofile"
LABEL "Author"="Aasim"
RUN rm -rf /user/local/tomcat/webapps/*
COPY --from=BUILD_IMAGE vprofile-project/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
WORKDIR /usr/local/tomcat/
VOLUME /usr/local/tomcat/webapps