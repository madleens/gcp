
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

resource "google_project_service" "secretmanager" {
  project = var.project_id
  service = "secretmanager.googleapis.com"
}

resource "google_secret_manager_secret" "config_tfvars" {
  project   = var.project_id
  secret_id = "config_tfvars"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "config" {
  secret      = google_secret_manager_secret.config_tfvars.id
  secret_data = "bucket = ${google_storage_bucket.backend.name} \nprefix  =\"terraform/state\""
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

resource "google_secret_manager_secret_version" "terraform" {
  secret      = google_secret_manager_secret.terraform_tfvars.id
  secret_data = "project_id=\"${var.project_id}\""
  lifecycle {
    ignore_changes = [
      secret_data,
    ]
  }
}

resource "google_secret_manager_secret_iam_binding" "config" {
  project   = google_secret_manager_secret.config_tfvars.project
  secret_id = google_secret_manager_secret.config_tfvars.secret_id
  role      = "roles/secretmanager.secretAccessor"
  members = [
    "serviceAccount:${google_service_account.github_actions.email}",
  ]
}

resource "google_secret_manager_secret_iam_binding" "terraform" {
  project   = google_secret_manager_secret.terraform_tfvars.project
  secret_id = google_secret_manager_secret.terraform_tfvars.secret_id
  role      = "roles/secretmanager.secretAccessor"
  members = [
    "serviceAccount:${google_service_account.github_actions.email}",
  ]
}
