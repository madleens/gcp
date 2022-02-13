variable "project_id" {
  type = string
}

variable "attribute_condition" {
  type = string
}

variable "github_repo" {
  type = string
}

variable "allowed_audiences" {
  type = list(string)
}

variable "github_owner" {
  type = string
}
