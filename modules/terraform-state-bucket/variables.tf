variable "project" {
  description = "Projects list to add the IAM policies/bindings"
  default     = "secret-medium-373003"
  type        = string
}

variable "location" {
  description = "Region to create Cloud Storage bucket"
  default = "asia-southeast1"
  type = string
}