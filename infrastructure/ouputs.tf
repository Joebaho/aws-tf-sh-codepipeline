#outputs
output "codedeploy_app_name" {
  description = "CodeDeploy Application Name"
  value       = aws_codedeploy_app.web_app.name
}

output "codedeploy_deployment_group_name" {
  description = "CodeDeploy Deployment Group Name"
  value       = aws_codedeploy_deployment_group.web_dg.deployment_group_name
}

output "alb_dns_name" {
  description = "ALB DNS Name"
  value       = aws_lb.web_alb.dns_name
}
