resource "random_id" "bucket_prefix" {
  byte_length = 8
}

resource "google_storage_bucket" "default" {
  name          = "${random_id.bucket_prefix.hex}-project1-tfstate"
  force_destroy = false
  location      = var.location
  storage_class = "STANDARD"
  project = var.project
  versioning {
    enabled = true
  }
}