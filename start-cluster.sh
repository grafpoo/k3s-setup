#!/bin/bash
export SERVER_IP=192.168.70.42 # from the server Vagrantfile
rm -f scripts/startup-client.sh  # get rid of old stuff

mkdir -p ~/.kube
rm -f ~/.kube/k3s.yaml

# like it says, start up the server
echo "STARTING SERVER"
cd server
vagrant up

### NOTE: vagrant docs say onfig.vm.provision shells will run as root, but my
###       experience here has not borne that out. so i am sudo'ing everything
# dig the node token info off the server - the client needs it at startup
vagrant ssh -c 'sudo k3s kubectl get node'  # this seems to initialize the info file
echo "#!/bin/bash" > ../scripts/startup-client.sh  # start building the client setup script
echo "set -x" >> ../scripts/startup-client.sh  # start building the client setup script
#echo -n "export NODE_TOKEN=" >> ../scripts/startup-client.sh  # start building the client setup script
vagrant ssh -c 'sudo cat /var/lib/rancher/k3s/server/node-token' | tr -dC '[:print:]\t\n' | \
   awk '{print "export NODE_TOKEN=\"" $1 "\""}' >> ../scripts/startup-client.sh
echo "export K3S_SERVER=$SERVER_IP" >> ../scripts/startup-client.sh # this from the server Vagrantfile
echo "nohup sudo k3s agent --server https://\${K3S_SERVER}:6443 --token \${NODE_TOKEN} 1>/tmp/k3s.log 2>&1 &" >> ../scripts/startup-client.sh
# and the config for kubectl
vagrant ssh -c 'sudo cat /etc/rancher/k3s/k3s.yaml' | sed -e "s/localhost/$SERVER_IP/" > ~/.kube/k3s.yaml

echo "STARTING CLIENT"
cd ../client
vagrant up

cd ..
