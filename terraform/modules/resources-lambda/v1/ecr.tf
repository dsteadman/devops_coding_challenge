module "ecr" {
  source = "terraform-aws-modules/ecr/aws"

  repository_name         = var.project_name
  repository_force_delete = tobool(var.environment == "staging")
  # NOTE: a good idea to do this if we anticipate frequent rebuilds. 
  # storage on this is cheap though and not worth worrying about at this point
  create_lifecycle_policy = false

  repository_lambda_read_access_arns = [
    module.list_resources_lambda.lambda_function_arn
  ]
}
