#!/bin/bash
set -e

ENVIRONMENT=${1:-prod}
TERRAFORM_DIR="infrastructure"

echo "🚀 Deploying infrastructure for environment: $ENVIRONMENT"

cd $TERRAFORM_DIR

# Initialize Terraform
echo "📦 Initializing Terraform folder"
terraform init -reconfigure

#checking systanx error and validate 
echo "📦 checking syntax error"
terraform fmt

#checking systanx error and validate 
echo "📦 checking for validate configuration file"
terraform validate

# Plan changes
echo "📋 Planning infrastructure changes..."
terraform plan -var-file="../environments/$ENVIRONMENT.tfvars" -out=tfplan

# Apply changes
echo "🛠️ Applying infrastructure changes..."
terraform apply tfplan

# Output important information
echo "✅ Infrastructure deployment complete!"
echo "🌐 ALB DNS Name: $(terraform output -raw alb_dns_name)"
echo "📱 CodeDeploy App: $(terraform output -raw codedeploy_app_name)"
echo "🔧 Deployment Group: $(terraform output -raw codedeploy_deployment_group_name)"