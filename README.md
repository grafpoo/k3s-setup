# k3s-setup

this is a set of scripts that set up a k3s cluster with a couple of vagrant instances (see https://github.com/rancher/k3s). the first instance is the server (which also runs as a node), the second a client node. the scripts run the vagrant hosts in VirtualBox (i'm currently at 5.2.32)

to set up a cluster, run:
```
start-cluster.sh
```

the script start-cluster.sh starts both instances. it currently uses k3s-v0.8.0 (used to download latest k3s if not already present, but that turned out to be remarkably brittle)

it then starts the instances, server first. the server has a "node token" needed by the client, so once the server is started, it is queried for the token, and a start-client.sh script is generated that is fed the token and the server IP, both needed to start a k3s node.

the script also creates a k3s.yaml file in your $HOME/.kube directory. you can point to it by running:
```
export KUBECONFIG=~/.kube/k3s.yaml
```

note, too, that kubectl will not like the certificate used to talk to the cluster. my workaround currently is to use the *--insecure-skip-tls-verify* flag. i have a shell function defined in my **.bash_profile** for this

```
kci() {
   kubectl "$@" --insecure-skip-tls-verify
}
``` 

that the cluster doesn't survive very well when you sleep your machine. the easiest thing to do if it becomes unresponsive is to throw it away and start over. the easiest way to do that is to *vagrant destroy* the two nodes. the script *kill-cluster.sh* does just that

```
kill-cluster.sh
```

