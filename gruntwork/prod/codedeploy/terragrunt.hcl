include "root" {
  path = find_in_parent_folders()
}


include "env" {
  path = "${get_terragrunt_dir()}/../../_env/codedeploy.hcl"
}

terraform {
  source = "../../../infra/modules/codedeploy"
}

inputs = {
  environment                       = "prod"
}