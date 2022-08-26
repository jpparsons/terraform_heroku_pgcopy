# terraform apply -var-file=restores-dev.tfvars
# https://github.com/heroku-examples/terraform-heroku-pipeline-slugs/blob/master/variables.tf
# terraform apply -var-file=restores-prod.tfvars -var personal=false

provider "heroku" {}
