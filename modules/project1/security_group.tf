#Security Group Configuration

resource "aws_security_group" "mysec" {
  dynamic "ingress" {
    for_each = var.ports

    content {
      description = "jenkins sec grp"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = var.protocol_type
      cidr_blocks = var.cidr
    }
  }

  egress {
    description = "Allow All"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.cidr
  }

  tags = local.security_group_tags
}
