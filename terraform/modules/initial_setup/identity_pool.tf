data "google_project" "this" {
  project_id = var.project_id
}

resource "google_service_account" "github_actions" {
  project      = var.project_id
  account_id   = "github-actions"
  display_name = "Github Actions Connection"
  description  = "deploy from Github"
}

resource "google_iam_workload_identity_pool" "github" {
  provider = google-beta

  project                   = var.project_id
  workload_identity_pool_id = "github"
  display_name              = "Github"
}

resource "google_iam_workload_identity_pool_provider" "github" {
  provider = google-beta

  project                            = data.google_project.this.number
  workload_identity_pool_id          = google_iam_workload_identity_pool.github.workload_identity_pool_id
  workload_identity_pool_provider_id = "github"
  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.aud"        = "assertion.aud"
    "attribute.actor"      = "assertion.actor"
    "attribute.repository" = "assertion.repository"
    "attribute.ref_type"   = "assertion.ref_type"


  }
  oidc {
    allowed_audiences = var.allowed_audiences
    issuer_uri        = "https://token.actions.githubusercontent.com"
  }
  attribute_condition = var.attribute_condition
}

resource "google_service_account_iam_binding" "github_actions" {
  service_account_id = "projects/${var.project_id}/serviceAccounts/${google_service_account.github_actions.email}"
  role               = "roles/iam.workloadIdentityUser"
  members = [
    "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github.name}/attribute.repository/${var.github_org}/${var.github_repo}",
  ]
}
