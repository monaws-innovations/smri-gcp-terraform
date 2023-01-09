variable "project" {
  description = "Project to add Cloud Storage bucket for TF state"
  default     = "secret-medium-373003"
  type        = string
}

variable "location" {
  description = "Region to create Cloud Storage bucket"
  default = "asia-southeast1"
  type = string
}