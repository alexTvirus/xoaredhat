#
# Build stage
#
FROM maven:3.8.2-jdk-11 AS build
COPY . .
RUN mvn clean install -DskipTests

#
# Package stage
#
FROM openjdk:11-jdk-slim

# Cài đặt các công cụ cần thiết và Java
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    unzip \
    xvfb \
    libxi6 \
    libgconf-2-4 \
    && rm -rf /var/lib/apt/lists/*

# Cài đặt Google Chrome
RUN apt-get update && \
    apt-get install -y wget gnupg ca-certificates apt-transport-https && \
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update && \
    apt-get install -y google-chrome-stable

# Cài đặt các thư viện phụ thuộc cho Chrome
RUN apt-get install -y \
    libappindicator3-1 \
    libdbus-glib-1-2 \
    libxss1 \
    xdg-utils

COPY --from=build /chromedriver chromedriver
COPY --from=build /target target
COPY entrypoint.sh /entrypoint.sh





# Đặt biến môi trường để chạy Chrome ở chế độ headless
ENV DISPLAY=:99

RUN chmod -R 777 /target
RUN chmod 777 /chromedriver

# ENV PORT=8080 
EXPOSE 7860
#ENTRYPOINT ["java","-Dfile.encoding=UTF-8","-jar","target/dependency/webapp-runner.jar" ,"--port","7860","target/*.war"]

RUN chmod +x /entrypoint.sh
# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]