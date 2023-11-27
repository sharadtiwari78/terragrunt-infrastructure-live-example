include "root" {
  path = find_in_parent_folders()
}


include "env" {
  path = "${get_terragrunt_dir()}/../../_env/codebuild.hcl"
}

terraform {
  source = "../../../infra/modules/codebuild"
}

inputs = {
  environment                 = "prod"
}