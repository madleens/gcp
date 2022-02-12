resource "google_storage_bucket" "backend" {
  name                        = random_string.backend_bucket.result
  project                     = var.project_id
  location                    = "EU"
  uniform_bucket_level_access = true
}

resource "random_string" "backend_bucket" {
  length  = 36
  special = false
  number  = false
  upper   = false
}