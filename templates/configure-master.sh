#!/bin/bash
set -e

#kubeadm config images pull

POD_CIDR={{ .pod.cidr }}
kubeadm init --pod-network-cidr=$POD_CIDR
mkdir -p /home/ubuntu/.kube
cp /etc/kubernetes/admin.conf /home/ubuntu/.kube/config
chown -R ubuntu:ubuntu /home/ubuntu/.kube
pushd /tmp
wget https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml
sed -i "s|10.244.0.0/16|$POD_CIDR|g" kube-flannel.yml
su -c "kubectl apply -f /tmp/kube-flannel.yml" ubuntu
popd


#sous ubuntu:
#kubectl get nodes
#kubectl get pods --all-namespaces