#!/bin/bash
set -x
export NODE_TOKEN="K1007ac9e5557a8211c09af59ef6ffb9de9fc82d9ba83a009ca4a97748d6f294382::node:07d82330961abaa6064b3e26ace9827e"
export K3S_SERVER=192.168.70.42
nohup sudo k3s agent --server https://${K3S_SERVER}:6443 --token ${NODE_TOKEN} 1>/tmp/k3s.log 2>&1 &
