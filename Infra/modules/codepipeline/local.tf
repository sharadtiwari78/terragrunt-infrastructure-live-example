locals {
  artifact_store = {
    location = "${var.environment}-codepipeline-${data.aws_region.current.name}-${data.aws_caller_identity.current.account_id}"
    type     = "S3"
  }
}
