

output "restores_app_name" {
  value     = heroku_app.restores
  sensitive = true
}

output "restores_database" {
  value     = heroku_addon.database
  sensitive = true
}
