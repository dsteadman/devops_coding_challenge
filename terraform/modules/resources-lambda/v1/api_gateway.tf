module "api_gateway" {
  source = "terraform-aws-modules/apigateway-v2/aws"

  name          = "resources-http"
  description   = "API to allow listing of supported resources"
  protocol_type = "HTTP"

  cors_configuration = {
    allow_headers = ["content-type"]
    allow_methods = ["GET"]
    allow_origins = ["*"]
  }

  # Custom domain
  domain_name                 = aws_route53_zone.primary.name
  domain_name_certificate_arn = module.primary_acm_certificates.acm_certificate_arn

  # Access logs
  # default_stage_access_log_destination_arn = "arn:aws:logs:eu-west-1:835367859851:log-group:debug-apigateway"
  # default_stage_access_log_format          = "$context.identity.sourceIp - - [$context.requestTime] \"$context.httpMethod $context.routeKey $context.protocol\" $context.status $context.responseLength $context.requestId $context.integrationErrorMessage"

  # Routes and integrations
  integrations = {
    "GET /api/resources" = {
      lambda_arn             = module.list_resources_lambda.lambda_function_arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 12000
    }

    "$default" = {
      lambda_arn             = module.list_resources_lambda.lambda_function_arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 12000
    }
  }

  tags = var.tags
}
