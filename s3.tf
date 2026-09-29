module "storage" {
  source = "./modules/storage"

  folder_id = var.folder_id

  service_account = var.storage_service_account
  kms_key         = var.storage_kms_key
  bucket          = var.storage_bucket
}