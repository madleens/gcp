variable "project_id" {
    type = string
}

variable "tf_backend" {
  type = string
  description = "name of gcs bucket where terraform state should be stored"
}
