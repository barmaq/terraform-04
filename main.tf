# resource "yandex_vpc_network" "develop" {
#   name = var.vpc_name
# }
# resource "yandex_vpc_subnet" "develop" {
#   name           = var.vpc_name
#   zone           = var.default_zone
#   network_id     = yandex_vpc_network.develop.id
#   v4_cidr_blocks = var.default_cidr
# }

# начальный вариант
# module "vpc_dev" {
#   source        = "./vpc"
#   vpc_name      = var.vpc_name
#   default_zone  = var.default_zone
#   default_cidr  = var.default_cidr
# }

# вариант для задания 4. для нескольких сетей использовать переменную vpc_prod
module "vpc_dev" {
  source       = "./vpc2"
  vpc_name     = "production"
  vpc_subnets  =  var.vpc_dev
  
}

# fo debug
# output "vpc_dev_subnet" {
#   value = module.vpc_dev.yandex_vpc_subnet_info
# }

# #блок с вирт машинами

module "test-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = var.vm_name 
  network_id     = module.vpc_dev.yandex_vpc_net_info.id
  subnet_zones   = [for key, subnet in module.vpc_dev.yandex_vpc_subnet_info : subnet.zone]
  subnet_ids     = [for key, subnet in module.vpc_dev.yandex_vpc_subnet_info : subnet.id]
  instance_name  = local.vm_labels[0].project
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  labels = { 
    project = local.vm_labels[0].project
     }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered 
    serial-port-enable = 1
  }

}

module "test-vm2" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = var.vm_name 
  network_id     = module.vpc_dev.yandex_vpc_net_info.id
  subnet_zones   = [for key, subnet in module.vpc_dev.yandex_vpc_subnet_info : subnet.zone]
  subnet_ids     = [for key, subnet in module.vpc_dev.yandex_vpc_subnet_info : subnet.id]
  instance_name  = local.vm_labels[1].project
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  labels = { 
    project = local.vm_labels[1].project
     }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered 
    serial-port-enable = 1
  }

}


# #передача cloud-config
data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")

  vars = {
    ssh_public_key     = file("~/.ssh/ycbarmaq.pub")
  }

}

# конец блока с вирт машинами  


# задание 5

# module "mysql_cluster" {
#     source = "./mysql"
#     subnet_id     = module.vpc_dev.yandex_vpc_subnet_info.id
#     network_id    = module.vpc_dev.yandex_vpc_net_info.id
#     cluster_name  = var.cluster_name
#     HA            = true
# }

# module "db_and_user" {
#   source = "./mysql_db"
#   cluster_id = module.mysql_cluster.yandex_mdb_mysql_cluster_info.id
#   mysql_db_name = var.mysql_db_name
#   mysql_db_user = var.mysql_db_user 
# }

# задание 6

# module "s3_bucket" {
#   source  = "./terraform-yc-s3-master"
#   folder_id = var.folder_id
#   bucket_name = var.s3_name
# }



module "s3" {
  source = "./terraform-yc-s3-master/examples/simple-bucket"
}




#старый метод создания без учета нескольких подсетей

# module "test-vm" {
#   source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
#   env_name       = var.vm_name 
#   network_id     = module.vpc_dev.yandex_vpc_net_info.id
#   subnet_zones   = [module.vpc_dev.yandex_vpc_subnet_info.zone]
#   subnet_ids     = [module.vpc_dev.yandex_vpc_subnet_info.id]
#   instance_name  = local.vm_labels[0].project
#   instance_count = 1
#   image_family   = "ubuntu-2004-lts"
#   public_ip      = true

#   labels = { 
#     project = local.vm_labels[0].project
#      }

#   metadata = {
#     user-data          = data.template_file.cloudinit.rendered 
#     serial-port-enable = 1
#   }

# }

# module "test-vm2" {
#   source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
#   env_name       = var.vm_name 
#   network_id     = module.vpc_dev.yandex_vpc_net_info.id
#   subnet_zones   = [module.vpc_dev.yandex_vpc_subnet_info.zone]
#   subnet_ids     = [module.vpc_dev.yandex_vpc_subnet_info.id]
#   instance_name  = local.vm_labels[1].project
#   instance_count = 1
#   image_family   = "ubuntu-2004-lts"
#   public_ip      = true

#   labels = { 
#     project = local.vm_labels[1].project
#      }

#   metadata = {
#     user-data          = data.template_file.cloudinit.rendered 
#     serial-port-enable = 1
#   }

# }