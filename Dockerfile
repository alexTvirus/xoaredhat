#
# Build stage
#
FROM maven:3.8.2-jdk-11 AS build
COPY . .
RUN mvn clean install -DskipTests

#
# Package stage
# chrome 90

FROM selenium/standalone-chrome:3.141.59-20210422


USER root

# Cài đặt các công cụ cần thiết và Java
RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    net-tools \
    && rm -rf /var/lib/apt/lists/*


# Cài đặt các thư viện phụ thuộc cho Chrome
RUN apt-get install -y \
	procps

COPY --from=build /chromedriver chromedriver
COPY --from=build /target target
COPY entrypoint.sh /entrypoint.sh

# Đặt biến môi trường cho Java (nếu cần)
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:${PATH}"



# Đặt biến môi trường để chạy Chrome ở chế độ headless

RUN chmod -R 777 /target
RUN chmod 777 /chromedriver

# ENV PORT=8080 
EXPOSE 7860
#ENTRYPOINT ["java","-Dfile.encoding=UTF-8","-jar","target/dependency/webapp-runner.jar" ,"--port","7860","target/*.war"]

RUN chmod +x /entrypoint.sh
# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]