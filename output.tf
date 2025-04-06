output "atlantis_url" {
  description = "Atlantis URL"
  value       = join("", ["https://", var.route53_record_name])
}

