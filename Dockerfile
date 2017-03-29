FROM daocloud.io/maven:3.3.3

#ADD pom.xml /tmp/build/
#RUN cd /tmp/build
#RUN cd /tmp/build && mvn -q dependency:resolve


#############################################################################
ADD src /tmp/build/src
        #构建应用
RUN cd /tmp/build && mvn -q -DskipTests=true package \
        #拷贝编译结果到指定目录
        && mv target/*.jar /app.jar \
        #清理编译痕迹
        && cd / && rm -rf /tmp/build
		
RUN cd /target
#############################################################################

VOLUME /tmp
ADD spring-boot-docker-0.0.1-SNAPSHOT.jar app.jar
RUN sh -c 'touch /app.jar'
EXPOSE 8080
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
