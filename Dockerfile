#
# Build stage
#
#FROM maven:3.8.2-jdk-11 AS build
#COPY . .
#RUN mvn clean install -DskipTests

#
# Package stage
# chrome 90


FROM selenium/standalone-chrome:90.0.4430.85


USER root

# Cài đặt các công cụ cần thiết và Java
RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    net-tools \
    git	\
    curl \
    wget \
    sudo \
    unzip \
    && rm -rf /var/lib/apt/lists/*

#RUN wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
#RUN apt-get install ./cloudflared-linux-amd64.deb
#RUN chmod +x /usr/local/bin/cloudflared

RUN echo "seluser:password" | chpasswd && \
    adduser seluser sudo && \
    echo "xfce4-session" > /home/seluser/.xsession && \
    chown seluser:seluser /home/seluser/.xsession

RUN echo "#!/bin/bash\n\
    dbus-launch --exit-with-session startxfce4 &" > /home/seluser/xstartup && \
   chmod +x /home/seluser/xstartup

RUN usermod -aG sudo seluser
    RUN echo "seluser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers



# Cài đặt các thư viện phụ thuộc cho Chrome
RUN apt-get install -y \
	procps

COPY --from=build /chromedriver chromedriver
COPY --from=build /target target
COPY --from=build /dist dist
COPY entrypoint.sh /entrypoint.sh
COPY --from=build /dist/webapp /home/seluser/webapp
#COPY --from=build /UserData.zip UserData.zip






# Đặt biến môi trường cho Java (nếu cần)
#ENV JAVA_HOME=/usr/lib/java-11-openjdk
#ENV PATH="$JAVA_HOME/bin:${PATH}"



# Đặt biến môi trường để chạy Chrome ở chế độ headless

RUN chmod -R 777 /dist
RUN chmod -R 777 /target
RUN chmod 777 /chromedriver
RUN chmod -R 777 /home/seluser/webapp

# ENV PORT=8080 
EXPOSE 7860
#ENTRYPOINT ["java","-Dfile.encoding=UTF-8","-jar","target/dependency/webapp-runner.jar" ,"--port","7860","target/*.war"]

RUN chmod 777 /entrypoint.sh
# Set the entrypoint
USER seluser
WORKDIR /home/seluser


CMD ["/entrypoint.sh"]
#ENTRYPOINT ["/entrypoint.sh"]
