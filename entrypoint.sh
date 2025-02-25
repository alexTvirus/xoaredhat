#!/bin/sh
# Xvfb :99 -screen 0 1024x768x16 &

which google-chrome


#ls -l /

# Start the Java application 
exec java -Dfile.encoding=UTF-8 -jar /target/dependency/webapp-runner.jar --port 7860 /target/*.war