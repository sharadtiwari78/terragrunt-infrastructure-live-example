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

terraform {
  source = "../../../../infra/modules/codepipeline"
}

inputs = {
  pipeline_name         = "demo_pipeline"
  repository_name       = dependency.codecommit.outputs.repository_name
  application_name      = dependency.codedeploy.outputs.application_name
  deployment_group_name = dependency.codedeploy.outputs.deployment_group
  build_project_name    = dependency.codebuild.outputs.build_project_name
}