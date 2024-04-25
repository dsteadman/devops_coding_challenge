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

  image_uri = "${module.ecr.repository_url}:${var.image_tag}"

  tags = var.tags
}

# module "docker_build_from_ecr" {
#   source   = "terraform-aws-modules/lambda/aws//modules/docker-build"
#   ecr_repo = module.ecr.repository_name
# 
#   # NOTE: can also allow it to refer to the lambda SHA, but I like human-readable versions.
#   use_image_tag = true
#   # NOTE : the second half of using use_image_tag is specifying said image
#   image_tag = var.image_tag
# 
#   source_path = local.source_path
#   platform    = "linux/amd64"
# 
#   # build_args = {
#   #   FOO = "bar"
#   # }
# 
#   # NOTE: trigger refers to "when terraform sees a change in x, trigger a rebuild"
#   triggers = {
#     dir_sha = local.dir_sha
#   }
# }
