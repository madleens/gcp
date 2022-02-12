variable "project_id" {
  type = string
}

variable "attribute_condition" {
  type = string
}

variable "allowed_audiences" {
  type        = list(any)
  description = "audience that can access identity pool e.g. https://github.com/octo-org"
}

variable "github_repo" {
  type = string
}

variable "github_org" {
  type = string
}
