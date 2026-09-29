locals {
  vm_each = merge([
    for vm in var.each_vm : {
      for i in range(vm.count) :
      "${vm.vm_name}-${i + 1}" => merge(vm, {
        index = i + 1
      })
    }
  ]...)
}
locals {
  vms_ssh_public_root_key = file(pathexpand("~/.ssh/id_ed25519.pub"))
}