#SSH Key Configuration

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "aws_key_pair" "key_file" {
  key_name   = "jenkins"
  public_key = tls_private_key.private_key.public_key_openssh


  depends_on = [
    tls_private_key.private_key
  ]
}

resource "local_file" "key" {
  content         = tls_private_key.private_key.private_key_pem
  filename        = "jenkins.pem"
  file_permission = "0600"

  depends_on = [
    tls_private_key.private_key,
    aws_key_pair.key_file
  ]
}
