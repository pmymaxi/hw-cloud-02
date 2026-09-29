storage_service_account = {
  admin = {
    name     = "sa-admin-s3"
    role     = "storage.admin"
    desc_key = "static access key for object storage"
  }
  instance-group = {
    name = "sa-instance-group"
    role = "editor"
  }
}