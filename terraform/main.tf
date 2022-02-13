locals {
  service_list = toset([
    "compute.googleapis.com",
  ])
}

resource "google_project_service" "this" {
  for_each = local.service_list

  project = var.project_id
  service = each.value
}
