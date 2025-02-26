#!/bin/sh
# Xvfb :99 -screen 0 1024x768x16 &

which google-chrome

google-chrome-stable --version

#unzip /UserData.zip -d /target
#cp -r "/target/User Data" /target/UserData

#ls -l /target/UserData

echo "Current user: $(whoami) (UID: $(id -u))"

# Kiểm tra chạy google-chrome-stable trực tiếp
#echo "Attempting to start google-chrome-stable..."
#google-chrome-stable --headless --no-sandbox --disable-dev-shm-usage --disable-gpu --remote-debugging-port=9222 &

#echo "sleep chrome..."
#sleep 10

#netstat -tuln | grep 9222 || echo "Warning: Selenium Server not listening on 9222 yet"

# Start the Java application 
exec java -Dfile.encoding=UTF-8 -jar /target/dependency/webapp-runner.jar --port 7860 /target/*.war