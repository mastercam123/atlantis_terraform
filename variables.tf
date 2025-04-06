variable "aws_region" {
  type        = string
  default     = ""
  description = "AWS region to deploy the resources"
}
variable "atlantis_repo_allowlist" {
  description = "List of GitHub repositories that Atlantis will be allowed to access"
  type        = list(string)
  default     = ["github.com/{YOUR_ORGANIZATION}/{YOUR_REPOSITORY}"]
}
variable "certificate_domain_name" {
  description = "Certificate Domain Name"
  default     = ""
}
variable "create_alb" {
  description = "Create ALB"
  type        = bool
  default     = true
}
variable "github_app_id" {
  description = "GitHub App Installation ID"
  type        = string
}
variable "github_app_installation_id" {
  description = "GitHub App Installation ID"
  type        = string
}
variable "github_app_private_key" {
  description = "GitHub App private key"
  type        = string
  sensitive   = true
}
variable "github_webhook_secret" {
  description = "GitHub Webhook Secret"
  type        = string
  sensitive   = true
}
variable "public_subnets_id" {
  type        = list(string)
  description = "Public Subnets ID's where ALB for Atlantis will be deployed"
}
variable "private_subnets_id" {
  type        = list(string)
  description = "Private Subnets ID's where Atlantis will be deployed"
}
variable "route53_record_name" {
  description = "Route 53 record name for Atlantis"
  type        = string
  default     = ""
}
variable "route53_zone_id" {
  description = "Route 53 Zone ID"
  type        = string
  default     = ""
}
variable "tasks_iam_role_policies" {
  default = {
    PowerUserAccess = "arn:aws:iam::aws:policy/PowerUserAccess"
  }
  type = map(string)
}
variable "vpc_id" {
  type        = string
  description = "VPC ID where Atlantis will be deployed"
  default     = ""
}
variable "web_basic_auth" {
  description = "The basic auth for the web interface"
  type        = bool
  default     = true
}
variable "web_username" {
  description = "The username for the web interface"
  type        = string
  default     = "atlantis"
}
variable "web_password" {
  description = "The password for the web interface"
  type        = string
  sensitive   = true
}

### GitHub variables
variable "github_repositories" {
  description = "List of GitHub repositories to create webhooks for. This is just the name of the repository, excluding the user or organization name."
  type        = list(string)
  default     = [""]
}
variable "github_organization" {
  description = "GitHub organization to create webhooks for."
  type        = string
}