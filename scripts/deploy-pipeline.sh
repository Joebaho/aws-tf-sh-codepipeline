#!/bin/bash
set -e

ENVIRONMENT=${1:-prod}
TERRAFORM_DIR="pipeline"

echo "🚀 Deploying pipeline for environment: $ENVIRONMENT"

cd $TERRAFORM_DIR

# Initialize Terraform
echo "📦 Initializing Terraform..."
terraform init -reconfigure

#checking systanx error and validate 
echo "📦 checking syntax error"
terraform fmt

#checking systanx error and validate 
echo "📦 checking for validate configuration file"
terraform validate

# Plan changes
echo "📋 Planning pipeline changes..."
terraform plan -var-file="../environments/$ENVIRONMENT.tfvars" -out=tfplan

# Apply changes
echo "🛠️ Applying pipeline changes..."
terraform apply tfplan

echo "✅ Pipeline deployment complete!"
echo "🔗 Pipeline URL: $(terraform output -raw pipeline_url)"
echo "🎣 Webhook URL: $(terraform output -raw webhook_url)"