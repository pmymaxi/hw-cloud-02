# INSTANCE GROUP
module "instance_group" {
  source = "./modules/instance-group"

  name      = var.instance_group_name
  folder_id = var.folder_id

  # SERVICE ACCOUNT
  service_account_id = (module.storage.service_account[var.instance_group_service_account].id)

  # NETWORK
  subnet_id = (module.vpc.network[var.instance_group_network].subnet[var.instance_group_subnet].subnet_id)
  zone      = var.instance_group_zone

  # COMPUTE
  platform_id   = var.instance_group_platform_id
  cores         = var.instance_group_cores
  memory        = var.instance_group_memory
  core_fraction = var.instance_group_core_fraction
  image_id      = var.instance_group_image_id

  # DISK
  disk_size = var.instance_group_disk_size
  disk_type = var.instance_group_disk_type

  # NETWORK NAT
  network_nat = var.instance_group_network_nat

  # SCHEDULING
  preemptible = var.instance_group_preemptible

  # SSH
  ssh_user       = var.instance_group_ssh_user
  ssh_public_key = local.vms_ssh_public_root_key

  # USER DATA
  user_data = templatefile(
    "${path.root}/templates/user-data.yaml",
    {
      index_html_base64 = base64encode(
        replace(
          file("${path.root}/templates/index.html"),
          "__IMAGE_URL__",
          var.instance_group_image_url
        )
      )
    }
  )

  # INSTANCE COUNT
  instance_count = var.instance_group_count

  # DEPLOY POLICY
  deploy_policy = var.instance_group_deploy_policy

  # HEALTH CHECK
  health_check = var.instance_group_health_check

  # NETWORK LOAD BALANCER
  network_load_balancer = {
    enabled = var.network_load_balancer_enabled

    target_group_name = (
      var.network_load_balancer_target_group_name
    )

    target_group_description = (
      var.network_load_balancer_target_group_description
    )
  }

  # APPLICATION LOAD BALANCER
  application_load_balancer = {
    enabled = var.application_load_balancer_enabled

    target_group_name = (
      var.application_load_balancer_target_group_name
    )

    target_group_description = (
      var.application_load_balancer_target_group_description
    )
  }
}