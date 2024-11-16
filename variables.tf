

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}


###example vm_web var
variable "vm_name" {
  type        = string
  default     = "netology-vm"
  description = "example vm_name prefix"
}


locals {
  vm_labels = [
    {
      project = "marketing"
    },
    {
      project = "analytics"
    }
  ]
}


#для задания 4
variable "vpc_prod" {
  description = "vpc_prod список"
  type = list(object({
    zone = string
    cidr = string
  }))
  default = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-d", cidr = "10.0.3.0/24" }
  ]
}

variable "vpc_dev" {
  description = "vpc_dev список"
  type = list(object({
    zone = string
    cidr = string
  }))
  default = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
  ]
}


#mysql cluster для задания 5
variable "cluster_name" {
  description = "Имя кластера MySQL"
  type        = string
  default = "example"
}

variable "mysql_db_name" {
  description = "mysql db name"
  type        = string
  default     = "test_base"
}

variable "mysql_db_user" {
  description = "mysql db user"
  type        = string
  default     = "test_user"
}

#для задания 6

variable "s3_name" {
  description = "s3 name"
  type        = string
  default     = "s3"
}
