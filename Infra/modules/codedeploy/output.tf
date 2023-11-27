output "deployment_config_name" {
  value = aws_codedeploy_deployment_config.codedeploy_deployment_config.id
}
output "application_name" {
  value = aws_codedeploy_app.codedeploy_app.name
}
output "deployment_group" {
  value = aws_codedeploy_deployment_group.codedeploy_deployment_group.deployment_group_name
}