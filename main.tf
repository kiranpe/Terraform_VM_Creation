module "project1" {
  source = "./modules/project1"

  vm_tags = ["jenkins-server", "App-server"]
}
