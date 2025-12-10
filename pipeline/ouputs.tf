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