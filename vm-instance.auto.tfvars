each_vm = [
  {
    count             = 0
    hostname          = "nat-instance"
    vm_name           = "nat-instance"
    user              = "ubuntu"
    image_id          = "fd80mrhj8fl2oe87o4e1"
    platform_id       = "standard-v3"
    zone              = "ru-central1-a"
    cpu               = 4
    ram               = 4
    core_fraction     = 20
    disk_size         = 15
    disk_type         = "network-hdd"
    disk_auto_delete  = true
    preemptible       = true
    nat               = true
    name_network      = "develop"
    name_subnet       = "public"
    ip_address        = "192.168.10.254"
    allow_stop_update = true
  },
  {
    count             = 0
    hostname          = "public-node"
    vm_name           = "public-node"
    user              = "ubuntu"
    family            = "ubuntu-2404-lts"
    platform_id       = "standard-v3"
    zone              = "ru-central1-a"
    cpu               = 4
    ram               = 2
    core_fraction     = 20
    disk_size         = 15
    disk_type         = "network-hdd"
    disk_auto_delete  = true
    preemptible       = true
    nat               = true
    name_network      = "develop"
    name_subnet       = "public"
    allow_stop_update = true
  },
  {
    count             = 0
    hostname          = "private-node"
    vm_name           = "private-node"
    user              = "ubuntu"
    family            = "ubuntu-2404-lts"
    platform_id       = "standard-v3"
    zone              = "ru-central1-a"
    cpu               = 4
    ram               = 2
    core_fraction     = 20
    disk_size         = 15
    disk_type         = "network-hdd"
    disk_auto_delete  = true
    preemptible       = true
    nat               = false
    name_network      = "develop"
    name_subnet       = "private"
    allow_stop_update = true
  },

]

vms_resources_metadata = {
  metadata = {
    serial-port-enable = "1"
  }
}