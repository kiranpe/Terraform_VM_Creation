#Local Tags and Values Configuration

locals {
  sec_grp_id = aws_security_group.mysec.id

  common_tags = {
    CreatedBy   = "Kiran Peddineni"
    Env         = "Non-Prod"
    Maintainers = "DevOps Team"
  }

  security_group_tags = {
    Name        = "ApplicationSecGroup"
    CreatedBy   = "Kiran Peddineni"
    Env         = "Non-Prod"
    Maintainers = "DevOps Team"
  }

}
