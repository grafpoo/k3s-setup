rm -f scripts/node.info
echo "STARTING SERVER"
cd server
vagrant up
echo -n "export NODE_TOKEN=" > ../scripts/node.info
vagrant ssh -c 'sudo k3s kubectl get node'
vagrant ssh -c 'sudo cat /var/lib/rancher/k3s/server/node-token' >> ../scripts/node.info
cd ..
echo "STARTING CLIENT"
cd client
vagrant up
