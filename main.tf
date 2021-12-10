# terraform apply -var-file=restores-dev.tfvars
# https://github.com/heroku-examples/terraform-heroku-pipeline-slugs/blob/master/variables.tf
# terraform apply -var-file=restores-prod.tfvars -var personal=false

terraform {
  backend "pg" {
  }
}

provider "heroku" {
}

# TODO: heroku-formation to add webs...etc
# https://www.terraform.io/docs/providers/heroku/r/formation.html
# https://github.com/heroku-examples/terraform-heroku-common-kong-microservices/blob/master/main.tf
