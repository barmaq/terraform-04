terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = "~>1.8.4"
}

resource "yandex_mdb_mysql_cluster" "example" {
  name        = var.cluster_name
  network_id  = var.network_id
  environment = var.environment
  version     = var.cluster_version

  resources {
    resource_preset_id = var.resource_preset_id
    disk_type_id       = var.disk_type_id
    disk_size          = var.disk_size
  }

  mysql_config = {
    sql_mode                      = var.sql_mode
  }
  
#один всегда создаем
  host {
    zone      = var.zone
    subnet_id = var.subnet_id
  }

# создаем 2й хост в зависимости от переменной HA
  dynamic "host" {
    for_each = var.HA ? [1] : []
    content {
      zone      = var.zone
      subnet_id = var.subnet_id
    }
  }
}
