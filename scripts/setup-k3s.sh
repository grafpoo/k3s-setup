export DIR=/srv/scripts
export K3S_VERSION=k3s-v0.8.0

if [ -e k3s ]; then
  echo "k3s already installed"
else
#  bash $DIR/wget-no-log.sh && \
  cp $DIR/$K3S_VERSION ./k3s && \
  sudo cp k3s /usr/local/bin/ && \
  sudo chmod a+x /usr/local/bin/k3s
fi
