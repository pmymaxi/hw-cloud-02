# LOAD BALANCERS
module "load_balancer" {
  source = "./modules/load-balancer"

  folder_id = var.folder_id

  # NETWORK LOAD BALANCER
  network_load_balancer_enabled = var.network_load_balancer_enabled
  network_load_balancer_name    = var.network_load_balancer_name

  network_load_balancer_target_group_id = (
    var.network_load_balancer_enabled
    ? module.instance_group.network_load_balancer.target_group_id
    : null
  )

  network_load_balancer_listener    = (var.network_load_balancer_listener)
  network_load_balancer_healthcheck = (var.network_load_balancer_healthcheck)

  # APPLICATION LOAD BALANCER
  application_load_balancer_enabled = (var.application_load_balancer_enabled)
  application_load_balancer_name    = (var.application_load_balancer_name)
  application_load_balancer_target_group_id = (
    var.application_load_balancer_enabled
    ? module.instance_group.application_load_balancer.target_group_id
    : null
  )
  application_load_balancer_network_id   = (module.vpc.network[var.instance_group_network].network_id)
  application_load_balancer_zone         = (var.instance_group_zone)
  application_load_balancer_subnet_id    = (module.vpc.network[var.instance_group_network].subnet[var.instance_group_subnet].subnet_id)
  application_load_balancer_http_router  = (var.application_load_balancer_http_router)
  application_load_balancer_backend      = (var.application_load_balancer_backend)
  application_load_balancer_virtual_host = (var.application_load_balancer_virtual_host)
  application_load_balancer_listener     = (var.application_load_balancer_listener)
}