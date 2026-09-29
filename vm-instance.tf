# Выполняем через for_each, чтобы vm_db определили свой boot
data "yandex_compute_image" "instance_img" {
  for_each = {
    for key, vm in local.vm_each :
    key => vm
    if vm.image_id == null
  }
  family = each.value.family
}
resource "yandex_compute_instance" "instance_cloud" {

  for_each                  = local.vm_each
  allow_stopping_for_update = each.value.allow_stop_update

  hostname    = each.value.count == 1 ? each.value.hostname : "${each.value.hostname}-${each.value.index}"
  name        = each.value.count == 1 ? each.value.hostname : "${each.value.hostname}-${each.value.index}"
  platform_id = each.value.platform_id
  zone        = each.value.zone

  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = each.value.image_id != null ? (
        each.value.image_id
        ) : (
        data.yandex_compute_image.instance_img[each.key].image_id
      )

      size = each.value.disk_size
      type = each.value.disk_type
    }

    auto_delete = each.value.disk_auto_delete
  }

  scheduling_policy {
    preemptible = each.value.preemptible
  }
  network_interface {
    subnet_id = module.vpc.network[each.value.name_network].subnet[each.value.name_subnet].subnet_id
    #security_group_ids = [module.vpc.security_group[each.value.name_sg].sg_id]
    ip_address = each.value.ip_address
    nat        = each.value.nat
  }

  metadata = merge(
    var.vms_resources_metadata.metadata,
    {
      ssh-keys = "${each.value.user}:${local.vms_ssh_public_root_key}"
  })

}