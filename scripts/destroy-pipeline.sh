#!/bin/bash

set -e

ENVIRONMENT=${1:-prod}
TERRAFORM_DIR="pipeline"

echo "🚀 Destroy codepipeline for environment: $ENVIRONMENT"

cd $TERRAFORM_DIR

echo "🗑️ Destroying project pipeline..."

read -p "❓ Are you sure? (type 'yes' to confirm): " confirm
if [ "$confirm" != "yes" ]; then
    echo "❌ Cancelled"
    exit 1
fi

terraform destroy -auto-approve -var="../environments/$ENVIRONMENT.tfvars"

echo "✅ aws codePipeline destroyed"