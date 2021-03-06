

resource "heroku_addon" "database" {
  for_each = toset(var.backup_ids)

  app  = each.value
  plan = var.heroku_postgresql

  depends_on = [heroku_app.restores]
}
