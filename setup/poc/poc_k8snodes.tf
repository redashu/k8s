resource "aws_instance" "k8s-minion" {
  ami = var.y
  instance_type = var.x
  count = var.number_of_instances
  key_name = "hellokey"
  security_groups = ["launch-wizard-1"]
  tags = {
    "Name" = "minion-node${count.index}"
  }
  connection {
    type = "ssh"
    user = "ec2-user"
    timeout = "3m"
    host = self.public_ip
    private_key = file("/Users/fire/Downloads/hellokey.pem")
  }
  provisioner "file" {
    source = "./scripts/k8s_allnode.sh"
    destination = "/home/ec2-user/k8s_allnode.sh"
  }
  
  provisioner "remote-exec" {
    inline = [
      "sudo bash /home/ec2-user/k8s_allnode.sh"
    ] 
  }
  
  
}