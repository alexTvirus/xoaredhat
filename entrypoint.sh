#!/bin/sh
# Xvfb :99 -screen 0 1024x768x16 &

which google-chrome


#ls -l /

#google-chrome-stable --headless --no-sandbox --disable-dev-shm-usage --dump-dom https://www.google.com --disable-gpu --remote-debugging-port=9222 &

# Chờ Selenium Server khởi động
sleep 10
echo "Checking Selenium Server port..."
netstat -tuln | grep 4444 || echo "Warning: Selenium Server not listening on 6570 yet"

# Kiểm tra chạy google-chrome-stable trực tiếp
echo "Attempting to start google-chrome-stable..."
google-chrome-stable --headless --no-sandbox --disable-dev-shm-usage --disable-gpu --remote-debugging-port=9222 --dump-dom https://www.google.com > /tmp/chrome_output 2>&1
CHROME_EXIT_CODE=$?
if [ $CHROME_EXIT_CODE -eq 0 ]; then
    echo "google-chrome-stable started successfully!"
    cat /tmp/chrome_output
else
    echo "google-chrome-stable failed to start! Exit code: $CHROME_EXIT_CODE"
    cat /tmp/chrome_output
fi

echo "sleep chrome..."
sleep 10

netstat -tuln | grep 9222 || echo "Warning: Selenium Server not listening on 9222 yet"

# Start the Java application 
exec java -Dfile.encoding=UTF-8 -jar /target/dependency/webapp-runner.jar --port 7860 /target/*.war