variable "environment" {
  type = string
}

variable "image_tag" {
  type = string
}

variable "project_name" {
  type = string
  # FORMAT: "ebb-staging-lambda-list-resources"
}

variable "source_path" {
  type    = string
  default = "context"
}

variable "path_include" {
  type    = list(string)
  default = ["**"]
}

variable "path_exclude" {
  type    = list(string)
  default = ["**/__pycache__/**"]
}

variable "lambda_description" {
  type = string
}

variable "architectures" {
  type    = list(string)
  default = ["arm64"]
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "ignore_source_code_hash" {
  type    = bool
  default = true
}
