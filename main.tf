# run heroku pg:backups -a <app name> to get a list of backup IDs

# terraform apply -var-file=restores-dev.tfvars
# terraform apply -var restores_app_name=dev-test232322334444 -var backup_app_name=productplan -var heroku-_ostgresql=heroku_postgresql:hobby-dev
# TODO: create restores.tfvars instead of var options
# https://github.com/heroku-examples/terraform-heroku-pipeline-slugs/blob/master/variables.tf
#
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
