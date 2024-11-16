terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.8.4"
}

resource "yandex_mdb_mysql_database" "bd1" {
  cluster_id = var.cluster_id
  name       = var.mysql_db_name
}

resource "yandex_mdb_mysql_user" "dbser1" {
  cluster_id = var.cluster_id
  name       = var.mysql_db_user
  password   = var.db_password
  permission {
    database_name = var.mysql_db_name
    roles         = ["ALL"]
  }
}