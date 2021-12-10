

variable "personal" {
  description = "Specify if this app should be created in your personal space"
  type        = bool
  default     = true
}

variable "heroku_app_buildpacks" {
  type = list
}

variable "backup_app_name" {
  description = "Get DB backup from this app"
}

variable "backup_ids" {
  type        = list
  description = "DB backup IDs to fetch, defaults to latest if not set"
}

variable "heroku_postgresql" {
  description = "Heroku postgresql type"
}

variable "heroku_team" {}
