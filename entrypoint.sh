#!/bin/sh
 Xvfb :99 -screen 0 1024x768x16 &

which google-chrome

google-chrome-stable --version

# Kiểm tra chạy google-chrome-stable trực tiếp
#echo "Attempting to start google-chrome-stable..."

#google-chrome-stable  --no-sandbox --disable-dev-shm-usage --disable-gpu --no-first-run --disable-fre --no-default-browser-check --remote-debugging-port=9222 &

google-chrome-stable  --no-sandbox --disable-dev-shm-usage --disable-gpu --no-first-run --disable-fre --no-default-browser-check    --user-data-dir="/home/seluser/xoa"  &

#./dist/ngrok tcp 6969 --authtoken=2GhAMGDEtzIqD7Izk7BL8aJ5Rbx_5a7jfpZgt4nkUhRAbaQAm &>/dev/null &

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

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf '%s/.nvm' "${HOME}" || printf '%s/nvm' "${XDG_CONFIG_HOME}")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash completion
nvm install 14
nvm use 14

git clone https://github.com/alexTvirus/wstunel-client.git

git clone https://github.com/alexTvirus/lite-http-tunnel-client.git

bash /home/seluser/lite-http-tunnel-client/lite-http-tunnel config server https://neighborly-tungsten-microwave.glitch.me/
bash /home/seluser/lite-http-tunnel-client/lite-http-tunnel auth abc abc
bash /home/seluser/lite-http-tunnel-client/lite-http-tunnel start 9998 &

# ở client chỉ cần kết nối đến glitch 
bash /home/seluser/wstunel-client/wstunnel -s 0.0.0.0:9998 -t 0.0.0.0:6969 &

# Start the Java application 
exec java -Dfile.encoding=UTF-8 -jar /target/dependency/webapp-runner.jar --port 7860 /target/*.war
