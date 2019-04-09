# k3s-setup

this is a script to set up a k3s cluster with a couple of vagrant instances (see https://github.com/rancher/k3s).
the first instance is the server (which also runs as a node), the second a client node.

the script start-cluster.sh starts both instances. it downloads k3s if not already present (it won't be if this is the first time you've run the script), then starts the instances, server first. the server has a "node token" needed by the client, so once the server is started, it is queried for the token, and a start-client.sh script is generated that is fed the token and the server IP, both needed to start a k3s node.

the script also creates a k3s.yaml file in your $HOME/.kube directory. if you rename this to $HOME/.kube/config you can kubectl to the server. i have my minikube config in the same directory, so i symlink to whichever kube config file i want. (TODO: pretty sure they can be combined into a single config with multiple contexts)
