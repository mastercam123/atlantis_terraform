################################################################################
# Atlantis Server configuration and secrets
################################################################################
resource "aws_ssm_parameter" "atlantis_web_password" {
  name  = "/atlantis/web_password"
  type  = "SecureString"
  value = var.web_password
}
resource "aws_secretsmanager_secret" "github_app_private_key" {
  name        = "github_app_private_key"
  description = "GitHub App private key"
}
resource "aws_secretsmanager_secret_version" "github_app_private_key" {
  secret_id     = aws_secretsmanager_secret.github_app_private_key.id
  secret_string = var.github_app_private_key
}
resource "aws_secretsmanager_secret" "github_webhook_secret" {
  name        = "github_webhook_secret"
  description = "GitHub Webhook Secret"
}
resource "aws_secretsmanager_secret_version" "github_webhook_secret" {
  secret_id     = aws_secretsmanager_secret.github_webhook_secret.id
  secret_string = var.github_webhook_secret
}