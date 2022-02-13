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

resource "google_secret_manager_secret" "backend_config" {
  project   = var.project_id
  secret_id = "config_tfvars"
  replication {
    automatic = true
  }
}

resource "google_project_service" "secretmanager" {
  project = var.project_id
  service = "secretmanager.googleapis.com"
}

resource "google_secret_manager_secret_version" "this" {
  secret      = google_secret_manager_secret.backend_config.id
  secret_data = "bucket = ${google_storage_bucket.backend.name} \n prefix  =\"terraform/state\""
  lifecycle {
    ignore_changes = [
      secret_data,
    ]
  }
}

resource "google_secret_manager_secret" "terraform_tfvars" {
  project   = var.project_id
  secret_id = "terraform_tfvars"
  replication {
    automatic = true
  }
}
