resource "libvirt_volume" "ubuntu-2404" {
  name   = "ubuntu-2404"
  source = "./images/ubuntu_2404.img"
}