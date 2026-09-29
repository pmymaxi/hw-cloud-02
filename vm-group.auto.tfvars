# INSTANCE GROUP
instance_group_name            = "lamp-instance-group"
instance_group_service_account = "instance-group"
instance_group_network         = "develop"
instance_group_subnet          = "public"
instance_group_zone            = "ru-central1-a"
instance_group_count           = 3

# IMAGE
instance_group_image_id = "fd827b91d99psvq5fjit"

# PLATFORM
instance_group_platform_id = "standard-v3"

# RESOURCES
instance_group_cores         = 2
instance_group_memory        = 2
instance_group_core_fraction = 20

# DISK
instance_group_disk_size = 15
instance_group_disk_type = "network-hdd"

# SCHEDULING
instance_group_preemptible = true

# SSH
instance_group_ssh_user = "ubuntu"

# NETWORK
instance_group_network_nat = true

# OBJECT STORAGE
instance_group_image_url = "https://storage.yandexcloud.net/hw-cloud-02-test-20260929/img/picture.jpg"

# DEPLOY POLICY
instance_group_deploy_policy = {
  max_unavailable = 1
  max_expansion   = 1
  strategy        = "proactive"
}

# HEALTH CHECK
instance_group_health_check = {
  interval            = 10
  timeout             = 5
  unhealthy_threshold = 3
  healthy_threshold   = 2
  port                = 80
}