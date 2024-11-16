# To always have a unique bucket name in this example
resource "random_string" "unique_id" {
  length  = 8
  upper   = false
  lower   = true
  numeric = true
  special = false
}

module "s3" {
  source = "../../"
  max_size              = 1073741824
  default_storage_class = "COLD"
  bucket_name = "simple-bucket-${random_string.unique_id.result}"
}

