include "root" {
  path = find_in_parent_folders()
}

dependency "codebuild" {
  config_path = "../codebuild"
}

dependency "codedeploy" {
  config_path = "../codedeploy"
}

dependency "codecommit" {
  config_path = "../codecommit"
}

dependencies {
  paths = ["../codecommit", "../codebuild", "../codedeploy"]
}

include "env" {
  path = "${get_terragrunt_dir()}/../../../_env/codepipeline.hcl"
}

terraform {
  source = "../../../../infra/modules/codepipeline"
}

inputs = {
  environment           = "qa"
  branch_name           = "qa"
}