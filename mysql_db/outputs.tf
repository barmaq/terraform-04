
output "yandex_mdb_mysql_database_info" {
  description = "cluster info"
  value       = yandex_mdb_mysql_database.bd1
}


output "yandex_mdb_mysql_user_info" {
  description = "cluster info"
  value       = yandex_mdb_mysql_user.dbser1
}
