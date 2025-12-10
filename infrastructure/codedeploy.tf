# IAM Role for CodeDeploy
resource "aws_iam_role" "codedeploy_role" {
  name = "${var.environment}-codedeploy-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "codedeploy.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Environment = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "codedeploy_role" {
  role       = aws_iam_role.codedeploy_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}

# CodeDeploy Application
resource "aws_codedeploy_app" "web_app" {
  name = "${var.environment}-web-app"

  tags = {
    Environment = var.environment
  }
}

# CodeDeploy Deployment Group
resource "aws_codedeploy_deployment_group" "web_dg" {
  app_name              = aws_codedeploy_app.web_app.name
  deployment_group_name = "${var.environment}-web-dg"
  service_role_arn      = aws_iam_role.codedeploy_role.arn

  ec2_tag_filter {
    key   = "Environment"
    type  = "KEY_AND_VALUE"
    value = var.environment
  }

  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "IN_PLACE"
  }
  load_balancer_info {
    target_group_info {
      name = aws_lb_target_group.web_tg.name
    }
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  deployment_config_name = "CodeDeployDefault.OneAtATime"

  tags = {
    Environment = var.environment
  }
}