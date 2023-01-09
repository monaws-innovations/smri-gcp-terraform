module "iam" {
  source = "../../modules/terraform-state-bucket"

  project = var.project
  location = var.location
}