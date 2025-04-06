# AWS ECS Fargate Atlantis Deployment

This repository contains Terraform configurations to deploy Atlantis on AWS ECS Fargate. Atlantis is a self-hosted platform that provides automated Terraform pull request automation and workflow management.

## Architecture

The deployment consists of the following AWS components:
- ECS Fargate for running Atlantis containers
- Application Load Balancer (ALB) for routing traffic
- EFS for persistent storage
- ACM for SSL/TLS certificate management
- GitHub webhook integration for automated PR workflows

## Module Structure

```
.
├── .terraform/             # Terraform plugins and modules
├── tf-modules/            # Custom Terraform modules
│   └── github-repository-webhook/  # GitHub webhook configuration
├── main.tf                # Main Terraform configuration
├── provider.tf            # AWS provider configuration
├── variables.tf           # Input variables
├── outputs.tf            # Output values
├── secrets.tf            # Sensitive configuration
└── github_webhook.tf     # GitHub webhook setup
```

## Prerequisites

- AWS Account with appropriate permissions
- Terraform >= 0.12
- GitHub repository access
- Domain name (for SSL certificate)

## Configuration

1. Create a `terraform.tfvars` file with required variables:

2. Initialize Terraform:
```bash
terraform init
```

3. Apply the configuration:
```bash
terraform plan
terraform apply
```

## Modules Used

The deployment utilizes several modules:
- `atlantis` - Core Atlantis configuration
- `atlantis.acm` - SSL/TLS certificate management
- `atlantis.alb` - Application Load Balancer setup
- `atlantis.ecs_cluster` - ECS cluster configuration
- `atlantis.ecs_service` - ECS service and task definitions
- `atlantis.efs` - Elastic File System for persistence (optional)

## Security

- SSL/TLS encryption enabled
- Private key authentication
- Secure secrets management
- Network isolation using VPC

## Outputs

After successful deployment, you'll receive:
- Atlantis URL
- ALB DNS name
- GitHub webhook URL

## Contributing

1. Fork the repository
2. Create a feature branch
3. Submit a Pull Request

## License
This project is licensed under the MIT License.