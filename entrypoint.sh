#!/bin/sh
 Xvfb :99 -screen 0 1024x768x16 &

which google-chrome

google-chrome-stable --version

# Kiểm tra chạy google-chrome-stable trực tiếp
#echo "Attempting to start google-chrome-stable..."

#google-chrome-stable  --no-sandbox --disable-dev-shm-usage --disable-gpu --no-first-run --disable-fre --no-default-browser-check --remote-debugging-port=9222 &

google-chrome-stable  --no-sandbox --disable-dev-shm-usage --disable-gpu --no-first-run --disable-fre --no-default-browser-check --proxy-server="socks5://127.0.0.1:11011" --host-resolver-rules="MAP * ~NOTFOUND , EXCLUDE 127.0.0.1" --user-data-dir="/home/seluser/xoa"  &

./dist/ngrok tcp 6969 --authtoken=2AI2NdKMqKHeyBUXc6rkrySdU0i_89bYasgZt35Zz3NB2fjwj &>/dev/null &

#unzip /UserData.zip -d /target
#cp -r "/target/User Data" /target/UserData

#ls -l /target/UserData

echo "Current user: $(whoami) (UID: $(id -u))"

# Các lệnh yêu cầu quyền root
#touch /root/testfile && echo "Created file in /root" || echo "Failed to create file"
##mkdir -p /etc/test && echo "Created directory in /etc" || echo "Failed to create directory"
#chmod 700 /etc/test && echo "Changed permissions" || echo "Failed to change permissions"

echo "All commands executed with root privileges"

#netstat -tuln | grep 9222 || echo "Warning: Selenium Server not listening on 9222 yet"

# chạy server để kết nối rdp ser-client
exec java -Dfile.encoding=UTF-8 -jar /dist/ser.jar &

# chạy server để fake ip về máy local
exec java -Dfile.encoding=UTF-8 -jar /dist/java_proxy_test.jar /dist/config/ip_port.txt &

# Start the Java application 
exec java -Dfile.encoding=UTF-8 -jar /target/dependency/webapp-runner.jar --port 7860 /target/*.war
