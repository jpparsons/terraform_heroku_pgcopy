

resource "heroku_app" "restores" {
  for_each = toset(var.backup_ids)

  name   = each.value
  region = "us"

  buildpacks = var.heroku_app_buildpacks

  organization {
    name     = var.heroku_team
    locked   = true
    personal = var.personal ? true : false
  }

  #config_vars {
  #  RAILS_ENV = "staging"
  #}

  # is it ready?
  # https://devcenter.heroku.com/articles/using-terraform-with-heroku#use-provisioner-health-checks
  # https://github.com/heroku-examples/terraform-heroku-enterprise-kong-microservices/blob/master/main.tf
}


# Heroku API does not support restore operations, so Heroku provider does not either
# https://github.com/heroku/platform-api/issues/72
resource "null_resource" "import" {
  for_each = toset(var.backup_ids)

  # only run if new app
  triggers = {
    restores_app = heroku_app.restores[each.key].uuid
  }

  # TODO: allow to pass in a backup ID or use latest if not set
  provisioner "local-exec" {
    #command = "go run restore.go --fromApp=${var.backup_app_name} --toApp=${each.value} --backupID=${each.value}"
    command = "bin/restore --fromApp=${var.backup_app_name} --toApp=${each.value} --backupID=${each.value}"
  }

  depends_on = [heroku_addon.database]
}
