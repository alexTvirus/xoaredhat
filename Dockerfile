#
# Build stage
#
FROM maven:3.8.2-jdk-11 AS build
COPY . .
RUN mvn clean install -DskipTests

#
# Package stage
# chrome 90

FROM selenium/standalone-chrome:3.14.0


USER root

# Cài đặt các công cụ cần thiết và Java
RUN apt-get update && apt-get install -y \
    openjdk-8-jdk \
    net-tools \
    unzip \
    && rm -rf /var/lib/apt/lists/*



# Cài đặt các thư viện phụ thuộc cho Chrome
RUN apt-get install -y \
	procps

COPY --from=build /chromedriver chromedriver
COPY --from=build /target target
COPY entrypoint.sh /entrypoint.sh
#COPY --from=build /UserData.zip UserData.zip






# Đặt biến môi trường cho Java (nếu cần)
ENV JAVA_HOME=/usr/lib/java-8-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:${PATH}"



# Đặt biến môi trường để chạy Chrome ở chế độ headless

RUN chmod -R 777 /target
RUN chmod 777 /chromedriver

# ENV PORT=8080 
EXPOSE 7860
#ENTRYPOINT ["java","-Dfile.encoding=UTF-8","-jar","target/dependency/webapp-runner.jar" ,"--port","7860","target/*.war"]

RUN chmod 777 /entrypoint.sh
# Set the entrypoint
USER root

RUN deluser seluser
RUN adduser -u 0 -D -H -G root -s /bin/bash seluser

CMD ["/entrypoint.sh"]
#ENTRYPOINT ["/entrypoint.sh"]