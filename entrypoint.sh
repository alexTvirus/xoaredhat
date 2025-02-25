#!/bin/sh
# Xvfb :99 -screen 0 1024x768x16 &

which google-chrome


#ls -l /

google-chrome-stable --headless --no-sandbox --disable-dev-shm-usage --dump-dom https://www.google.com --disable-gpu --remote-debugging-port=9222 &

# Start the Java application 
exec java -Dfile.encoding=UTF-8 -jar /target/dependency/webapp-runner.jar --port 7860 /target/*.war