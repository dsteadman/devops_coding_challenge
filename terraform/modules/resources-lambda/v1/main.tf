data "aws_region" "current" {}
data "aws_caller_identity" "this" {}
data "aws_ecr_authorization_token" "token" {}

module "list_resources_lambda" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "7.2.6"

  function_name = var.project_name
  description   = var.lambda_description

  # NOTE: "package" here referring to "lambda package". This is the 
  # other half of the following package_type parameter
  create_package = false
  package_type   = "Image" # NOTE: "Zip" if this wasn't a dockerized lambda
  architectures  = var.architectures

  image_uri                  = "${module.ecr.repository_url}:${var.image_tag}"
  ignore_source_code_hash    = var.ignore_source_code_hash
  create_lambda_function_url = true

  tags = var.tags
}
