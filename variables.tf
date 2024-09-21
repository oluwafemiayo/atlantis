# variables for sensitive information
variable "github_token" {
  type      = string
  sensitive = true
}

variable "github_secret" {
  type      = string
  sensitive = true
}

variable "github_user" {
  type = string
}

variable "atlantis_repo_url" {
  type = string
}