locals {
  service_list = toset([
    "firebase.googleapis.com",
  ])
}

resource "google_project_service" "this" {
  for_each = local.service_list

  project            = var.project_id
  service            = each.value
  disable_on_destroy = false
}

resource "google_firebase_project" "this" {
  provider = google-beta
  project  = var.project_id
}
