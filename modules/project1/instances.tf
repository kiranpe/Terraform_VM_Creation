#Instances Configuration

resource "aws_instance" "vm" {
  count           = 2
  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.ec2_type
  key_name        = aws_key_pair.key_file.key_name
  security_groups = [aws_security_group.mysec.name]

  depends_on = [aws_key_pair.key_file, aws_security_group.mysec]

  tags = merge(local.common_tags,
    {
      Name = var.vm_tags[count.index]
    },
  )
}

resource "null_resource" "install" {

  provisioner "remote-exec" {
    connection {
      user        = var.user_name
      private_key = tls_private_key.private_key.private_key_pem
      host        = element(aws_instance.vm.*.public_ip, 0)
    }

    inline = ["sudo apt-get update && sudo apt install openjdk-8-jdk -y && sudo apt-get update"]
  }

  provisioner "local-exec" {
    connection {
      user        = var.user_name
      private_key = tls_private_key.private_key.private_key_pem
      host        = element(aws_instance.vm.*.public_ip, 0)
    }

    command = <<EOT
       sleep 10;
        > inventory;
          echo [jenkins] | tee -a inventory;
          echo "${element(aws_instance.vm.*.public_ip, 0)} ansible_ssh_common_args='-o StrictHostKeyChecking=no'" | tee -a inventory;
          ansible-playbook -u ${var.user_name} --private-key ${aws_key_pair.key_file.key_name}.pem -i inventory ymlfiles/install-jenkins.yml
     EOT
  }

  provisioner "remote-exec" {
    connection {
      user        = var.user_name
      private_key = tls_private_key.private_key.private_key_pem
      host        = element(aws_instance.vm.*.public_ip, 1)
    }

    inline = ["sudo apt-get update && sudo apt install openjdk-8-jdk -y && sudo apt-get install maven ansible git docker.io -y && sudo apt-get update"]
  }
}
