if [ -e k3s ]; then
  echo "k3s already installed"
else
  wget --no-check-certificate https://github.com/rancher/k3s/releases/download/v0.3.0/k3s && \
  sudo cp k3s /usr/local/bin/ && \
  sudo chmod a+x /usr/local/bin/k3s
fi
