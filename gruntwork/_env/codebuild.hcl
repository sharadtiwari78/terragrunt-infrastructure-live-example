terraform {
  source = "../../../../infra/modules/codebuild"
}

inputs = {
  codebuild_project_name      = "demo-build-project"
  codebuild_timeout           = "60"
  artifacts_type              = "CODEPIPELINE"
  compute_type                = "BUILD_GENERAL1_MEDIUM"
  image                       = "aws/codebuild/windows-base:2019-2.0"
  type                        = "WINDOWS_SERVER_2019_CONTAINER"
  image_pull_credentials_type = "CODEBUILD"
  source_type                 = "CODEPIPELINE"
  buildspec                   = "buildspec.yml"
  cloudwatch_group_name       = "codepipeline_logs"
  cloudwatch_stream_name      = "codepipeline_logs_stream"
}