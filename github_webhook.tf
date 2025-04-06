################################################################################
# GitHub repository webhook
################################################################################

module "github_repository_webhooks" {
  depends_on = [module.atlantis]
  source     = "./tf-modules/github-repository-webhook"

  repositories = var.github_repositories

  webhook_url    = "${module.atlantis.url}/events"
  webhook_secret = aws_secretsmanager_secret_version.github_webhook_secret.secret_string
}
