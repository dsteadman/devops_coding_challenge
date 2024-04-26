module "primary_acm_certificates" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"

  domain_name = aws_route53_zone.primary.name
  zone_id     = aws_route53_zone.primary.zone_id

  validation_method = "DNS"

  subject_alternative_names = [
    "*.${aws_route53_zone.primary.name}",
    aws_route53_zone.primary.name

  ]

  wait_for_validation = true

  tags = var.tags
}
