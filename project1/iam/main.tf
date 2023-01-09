module "iam" {
  source = "../../modules/iam"

  projects = var.projects
  mode = var.mode
  bindings = var.bindings
  conditional_bindings = var.conditional_bindings
}