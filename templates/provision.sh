#!/bin/bash
set -ex
#master and workers

apt update && apt upgrade -y
apt install -y docker.io
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v{{ .version }}/deb/ /" | tee /etc/apt/sources.list.d/kubernetes.list
curl -fsSL https://pkgs.k8s.io/core:/stable:/v{{ .version }}/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
apt update
apt install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl



swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
kubeadm config images pull
