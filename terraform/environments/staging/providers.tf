provider "aws" {
  region              = "us-west-2"
  allowed_account_ids = ["381422376610"]

  default_tags {
    tags = {
      environment  = "staging"
      managed-by   = "terraform"
      managed-from = "devops_coding_challenge/terraform/environments/staging"
    }
  }
}
