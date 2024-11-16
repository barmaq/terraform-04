
#данные для кластера

variable "cluster_name" {
  description = "Имя кластера MySQL"
  type        = string
}

variable "network_id" {
  description = "ID сети для кластера"
  type        = string
}

variable "HA" {
  description = "High Availability режим для кластера"
  type        = bool
  default     = false
}

variable "subnet_id" {
  description = "ID сети для кластера"
  type        = string
}

variable "environment" {
  description = "env кластера"
  type        = string
  default = "PRODUCTION"
}

variable "cluster_version" {
  description = "версия mysql кластера"
  type        = string
  default = "8.0"
}

variable "zone" {
  description = "зона"
  type        = string
  default     = "ru-central1-a" 
}

variable "sql_mode" {
  description = "sql_mode"
  type        = string
  default     = "ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION"
}

variable "resource_preset_id" {
  description = "пресет"
  type        = string
  default     = "s3-c2-m8"
}

variable "disk_type_id" {
  description = "disk_type_id"
  type        = string
  default     = "network-ssd"
}

variable "disk_size" {
  description = "disk_size"
  type        = number
  default     = 10 
}

