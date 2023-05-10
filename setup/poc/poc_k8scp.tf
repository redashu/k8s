

resource "aws_instance" "k8s_master" {
  ami = var.y
  instance_type = var.x
  associate_public_ip_address = var.z
  key_name = "hellokey"
  tags = {
    "Name" = "k8s-controlplane"
  }
  provisioner "local-exec" {
    command = "echo kubeadm  init --pod-network-cidr=192.168.0.0/16 --apiserver-advertise-address=0.0.0.0 --apiserver-cert-extra-sans=${self.public_ip} >scripts/k8s_cp.sh"
  }
  provisioner "file" {
    source = "./scripts/k8s_allnode.sh"
    destination = "/home/ec2-user/k8s_allnode.sh"
  }
  provisioner "file" {
    source = "./scripts/k8s_cp.sh"
    destination = "/home/ec2-user/k8s_cp.sh"
    
  }

  provisioner "remote-exec" {
    inline = [
      "sudo bash /home/ec2-user/k8s_allnode.sh",
      "sudo bash /home/ec2-user/k8s_cp.sh"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mkdir /root/.kube",
      "sudo cp -v /etc/kubernetes/admin.conf /root/.kube/config",
      "sudo kubectl get nodes",
      "sudo wget  https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/calico.yaml ",
      "sudo kubectl apply -f /home/ec2-user/calico.yaml"
    ]
  }
  provisioner "remote-exec" {
    inline = [
      "sudo kubeadm token create --print-join-command",
    ]
    
  }
  connection {
    type = "ssh"
    user = "ec2-user"
    timeout = "3m"
    host = self.public_ip
    private_key = file("/Users/fire/Downloads/hellokey.pem")
  }

}

