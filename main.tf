data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

################################################################################
# Atlantis Module to run Atlantis on AWS Fargate
################################################################################

### ECS Atlantis CloudWatch Group
resource "aws_cloudwatch_log_group" "atlantis" {
  name              = "/ecs/atlantis"
  retention_in_days = 7
}

### Atlantis Server
module "atlantis" {
  depends_on = [aws_cloudwatch_log_group.atlantis]
  source     = "terraform-aws-modules/atlantis/aws"
  version    = "4.4.0"

  vpc_id          = var.vpc_id
  service_subnets = var.private_subnets_id
  name            = "atlantis"


  ## Atlantis ECS Container Definition
  atlantis = {
    environment = [
      {
        name  = "ATLANTIS_REPO_ALLOWLIST"
        value = join(",", var.atlantis_repo_allowlist)
      },
      {
        name  = "ATLANTIS_GH_APP_ID"
        value = var.github_app_id
      },
      {
        name  = "ATLANTIS_WEB_BASIC_AUTH"
        value = var.web_basic_auth
      },
      {
        name  = "ATLANTIS_WEB_USERNAME"
        value = var.web_username
      },
      {
        name  = "ATLANTIS_WEB_PASSWORD"
        value = var.web_password
      },
      {
        name  = "ATLANTIS_LOG_LEVEL"
        value = "debug"
      },
      {
        name  = "ATLANTIS_WRITE_GIT_CREDS"
        value = true
      },
      {
        name  = "ATLANTIS_ATLANTIS_URL"
        value = join("", ["https://", var.route53_record_name])
      },
      {
        name  = "ATLANTIS_GH_APP_INSTALLATION_ID"
        value = var.github_app_installation_id
      }
    ]
    secrets = [
      {
        name      = "ATLANTIS_GH_WEBHOOK_SECRET"
        valueFrom = aws_secretsmanager_secret_version.github_webhook_secret.arn
      },
      {
        name      = "ATLANTIS_GH_APP_KEY"
        valueFrom = aws_secretsmanager_secret_version.github_app_private_key.arn
      }
    ]
    log_configuration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = aws_cloudwatch_log_group.atlantis.name
        awslogs-region        = data.aws_region.current.name
        awslogs-stream-prefix = "atlantis"
      }
    }
  }

  ## ECS Service
  service = {
    enable_execute_command  = true
    task_exec_iam_role_name = "atlantis-task-execution-role"
    task_exec_secret_arns   = [aws_secretsmanager_secret_version.github_app_private_key.arn, aws_secretsmanager_secret_version.github_webhook_secret.arn]
    # Provide Atlantis permission necessary to create/destroy resources
    tasks_iam_role_name     = "atlantis-tasks-role"
    tasks_iam_role_policies = var.tasks_iam_role_policies

  }
  ## ALB
  alb_subnets             = var.public_subnets_id
  certificate_domain_name = var.certificate_domain_name
  route53_record_name     = var.route53_record_name
  route53_zone_id         = var.route53_zone_id
  create_alb              = var.create_alb
}

