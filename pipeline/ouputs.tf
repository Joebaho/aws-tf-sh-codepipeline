#outputs to be display 

output "pipeline_url" {
  description = "URL to access CodePipeline"
  value       = "https://${var.aws_region}.console.aws.amazon.com/codesuite/codepipeline/pipelines/${aws_codepipeline.app_pipeline.name}/view"
}

output "webhook_url" {
  description = "URL to configure in GitHub webhooks"
  value       = aws_codepipeline_webhook.webhook.url
  sensitive   = true
}

output "webhook_secret" {
  description = "Secret token for GitHub webhook"
  value       = random_id.webhook_secret.hex
  sensitive   = true
}

output "artifact_bucket_name" {
  description = "Pipeline artifact bucket name"
  value       = aws_s3_bucket.pipeline_artifacts.bucket
}

output "codedeploy_app_name" {
  description = "CodeDeploy Application Name"
  value       = aws_codedeploy_app.web_app.name
}

output "codedeploy_deployment_group_name" {
  description = "CodeDeploy Deployment Group Name"
  value       = aws_codedeploy_deployment_group.web_dg.deployment_group_name
}