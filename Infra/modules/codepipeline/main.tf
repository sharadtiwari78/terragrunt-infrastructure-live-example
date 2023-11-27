#create codepipeline
resource "aws_codepipeline" "codepipeline" {
  name     = "${var.environment}-${var.pipeline_name}"
  role_arn = aws_iam_role.codepipeline_iam_role.arn

  artifact_store {
    location = local.artifact_store["location"]
    type     = local.artifact_store["type"]
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeCommit"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        RepositoryName = var.repository_name
        BranchName     = var.branch_name 
      }
    }
  }

  stage {
    name = "${var.environment}-Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = var.build_project_name
      }
    }
  }

  stage {
    name = "${var.environment}-Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeploy"
      input_artifacts = ["build_output"]
      version         = "1"

      configuration = {
        ApplicationName     = var.application_name
        DeploymentGroupName = var.deployment_group_name
      }
    }
  }
}

#create s3 bucket for codepipeline artifact
resource "aws_s3_bucket" "pipeline_bucket" {
  bucket = local.artifact_store.location
}

resource "aws_s3_bucket_public_access_block" "pipeline_bucket_public_access_block" {
  bucket                  = aws_s3_bucket.pipeline_bucket.bucket
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


