terraform {
  required_version = ">= 0.13"
  required_providers {

    google = {
      source  = "hashicorp/google"
      version = ">= 3.53, < 5.0"
    }
  }

  backend "gcs" {
    bucket  = "81beb295e1ad7ec4-project1-tfstate"
    prefix  = "terraform/state"
  }

  provider_meta "google" {
    module_name = "blueprints/terraform/terraform-google-iam:projects_iam/v7.4.1"
  }
}