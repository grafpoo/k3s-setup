sudo apt-get install -y jq

export URL=`curl -s https://api.github.com/repos/rancher/k3s/releases/latest | jq -r ".assets[] | select(.name | test(\"k3s\")) | .browser_download_url" | grep "k3s$"`

wget --no-check-certificate $URL > /dev/null
