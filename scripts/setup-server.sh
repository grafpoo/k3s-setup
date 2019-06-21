export DIR=/srv/scripts

if [ -e k3s ]; then
  echo "k3s already installed"
else
  bash $DIR/wget-no-log.sh && \
  sudo cp k3s /usr/local/bin/ && \
  sudo chmod a+x /usr/local/bin/k3s
fi
echo "STARTING K3S SERVER"
sudo bash $DIR/startup-server.sh
