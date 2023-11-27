terraform {
  source = "../../../../infra/modules/codedeploy"
}

inputs = {
  application_name                  = "demo-application"
  deployment_group_name             = "deployment_group"
  auto_rollback_configuration_event = ["DEPLOYMENT_FAILURE"]
  ec2_tag_filter_key                = "Name"
  ec2_tag_filter_type               = "KEY_AND_VALUE"
  deployment_config_name            = "CodeDeploy_All-at-Once"
  ec2_tag_filter_value              = "demo-server-name"
  minimum_healthy_hosts_type        = "HOST_COUNT"
  minimum_healthy_hosts_value       = "1"
}