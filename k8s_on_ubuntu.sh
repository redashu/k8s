modprobe overlay
 modprobe br_netfilter
 cat <<EOF >/etc/sysctl.d/k8s.conf 
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF 
sysctl --system
  apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/docker.gpg
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    apt update
     apt install -y containerd.io
     containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1
     systemctl restart containerd
     systemctl enable containerd
     curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/kubernetes-xenial.gpg
      apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
      apt update
      apt install -y kubelet kubeadm kubectl
      systemctl enable kubelet
