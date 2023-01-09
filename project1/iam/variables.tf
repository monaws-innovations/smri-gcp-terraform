variable "projects" {
  description = "Projects list to add the IAM policies/bindings"
  default     = ["secret-medium-373003"]
  type        = list(string)
}

variable "mode" {
  description = "Mode for adding the IAM policies/bindings, additive and authoritative"
  default     = "additive"
}

variable "bindings" {
  description = "Map of role (key) and list of members (value) to add the IAM policies/bindings"
  type        = map(list(string))
  default     = {
    "roles/logging.viewer" = [
      "user:mozimos@gmail.com",
      "user:monaws.innovation@gmail.com"
    ]
  }
}

variable "conditional_bindings" {
  description = "List of maps of role and respective conditions, and the members to add the IAM policies/bindings"
  type = list(object({
    role        = string
    title       = string
    description = string
    expression  = string
    members     = list(string)
  }))
  default = []
}