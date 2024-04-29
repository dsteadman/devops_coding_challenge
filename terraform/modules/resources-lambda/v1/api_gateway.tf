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
  default_stage_access_log_destination_arn = module.api_gateway_log_group.cloudwatch_log_group_arn
  default_stage_access_log_format          = "$context.identity.sourceIp - - [$context.requestTime] \"$context.httpMethod $context.routeKey $context.protocol\" $context.status $context.responseLength $context.requestId $context.integrationErrorMessage"

  # Routes and integrations
  integrations = {
    "GET /api/resources" = {
      lambda_arn             = module.list_resources_lambda.lambda_function_arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 12000
    }
  }

  tags = var.tags
}

module "api_gateway_log_group" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/log-group"
  version = "~> 3.0"

  name              = "${var.project_name}-logs"
  retention_in_days = 7
}

module "error_alarm" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/metric-alarm"
  version = "~> 3.0"

  alarm_name          = "${var.project_name}-error-alarm"
  alarm_description   = "Errors in ${var.project_name} recorded in ${module.api_gateway_log_group.cloudwatch_log_group_name}"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  threshold           = 5 # don't want to be too trigger happy but also a simple GET endpoint like this shouldn't be erroring
  period              = 60
  unit                = "Count"

  namespace   = var.project_name
  metric_name = "ErrorCount"
  statistic   = "Maximum"
}

resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "allow-api-gateway-invocation"
  action        = "lambda:InvokeFunction"
  function_name = var.project_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${module.api_gateway.apigatewayv2_api_execution_arn}/*"
}
