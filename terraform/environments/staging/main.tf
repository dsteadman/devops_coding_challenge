module "staging_resources_lambda" {
  source = "../../modules/resources-lambda/v1"

  image_tag          = "0.0.14"
  lambda_description = "Return a list of resources via HTTP endpoint"
  environment        = "staging"
  project_name       = "ebb-staging-resources-lambda"
  source_path        = "dist"
}
