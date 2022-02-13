# Fun with GCP

## Authentication from Github to GCP
The module is sets up authentication from github to GCP according to [this blog post](https://cloud.google.com/blog/products/identity-security/enabling-keyless-authentication-from-github-actions).  More documentation on security hardnening with OICD tokens can be found [here](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect).

## Initial Set-up 
In order to make Continuous Integration work deploy locally the module **inital_setup**:
1. Create GCP project
1. Create file **terraform.tfvars** inside initital_setup directory:
```tf
project_id          = <your-project-id>
attribute_condition = <your-desired-atrtribute condition> e.g. "attribute.actor==\"<your-github-name>\""
github_owner        = <repo-owner>
github_repo         = <repo-name>
```
3. run terraform init
```bash
terraform init
```
4. run terraform apply. When prompted check configuration changes and approve apply
```bash
terraform apply
```
5. add the following secrets to Github repo
  * GCP_PROJECT_ID
  * GCP_SERVICE_ACCOUNT_EMAIL
  * WORKLOAD_IDENTITY_PROVIDER

## Developer Setup

* install Google Cloud SDK
* install terraform
* install pre-commit

