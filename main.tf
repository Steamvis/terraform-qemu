resource "libvirt_domain" "hosts" {
  for_each = {
    for v in local.hosts  : v.name => v
  }
  name   = "${each.key}-vm"
  memory = "2048"
  vcpu   = 2

  disk {
    volume_id = libvirt_volume.volumes[each.value.name].id
  }

  cloudinit = libvirt_cloudinit_disk.commoninit.id

  network_interface {
    network_id = libvirt_network.common.id
    addresses = [each.value.ip]
    wait_for_lease = true
  }

  graphics {
    type        = "vnc"
    listen_type = "address"
  }
}
