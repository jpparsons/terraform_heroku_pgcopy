

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

  # is it ready?
  # https://devcenter.heroku.com/articles/using-terraform-with-heroku#use-provisioner-health-checks
  # https://github.com/heroku-examples/terraform-heroku-enterprise-kong-microservices/blob/master/main.tf
}


# Heroku API does not support restore operations, so Heroku provider does not either
# https://github.com/heroku/platform-api/issues/72
# resource "null_resource" "import" {
#   for_each = toset(var.backup_ids)
#
#   # only run if new app
#   triggers = {
#     restores_app = heroku_app.restores[each.key].uuid
#   }
#
#   provisioner "local-exec" {
#     #command = "go run restore.go --fromApp=${var.backup_app_name} --toApp=${each.value} --backupID=${each.value}"
#     command = "bin/restore --fromApp=${var.backup_app_name} --toApp=${each.value} --backupID=${each.value}"
#   }
#
#   depends_on = [heroku_addon.database]
# }


# Build code & release to the app
resource "heroku_build" "pplan" {
  for_each = toset(var.backup_ids)

  app = each.value

  source {
    path = "/Users/johnparsons/workspace/productplan"
  }
  depends_on = [heroku_addon.database]
}

# Launch the app's web process by scaling-up
resource "heroku_formation" "example" {
  for_each = toset(var.backup_ids)

  app        = each.value
  type       = "web"
  quantity   = 1
  size       = "Standard-1x"
  depends_on = [heroku_build.pplan]
}
