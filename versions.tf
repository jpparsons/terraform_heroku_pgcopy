terraform {
  required_providers {
    heroku = {
      source = "terraform-providers/heroku"
    }
    null = {
      source = "hashicorp/null"
    }
  }
  required_version = ">= 0.13"
}
