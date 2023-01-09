resource "random_id" "bucket_prefix" {
  byte_length = 8
}

resource "google_storage_bucket" "default" {
  name          = "${random_id.bucket_prefix.hex}-project1-tfstate"
  force_destroy = false
  location      = "US"
  storage_class = "STANDARD"
  project = "secret-medium-373003"
  versioning {
    enabled = true
  }
}