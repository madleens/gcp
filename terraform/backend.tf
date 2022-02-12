terraform {
  backend "gcs" {}
  bucket  = var.tf_backend
  prefix  = "terraform/state"
}
