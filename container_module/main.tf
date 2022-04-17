resource "docker_container" "blockchain_container" {

  name  = var.name_in
  image = var.image_in
  ports {
    internal = var.internal_port_in
    external = var.external_port_in
  }

  volumes {
    container_path = var.container_path_in
    # host_path = var.host_path_in
    volume_name = docker_volume.dv.name
  }
}


resource "docker_volume" "dv" {
  name = "${var.name_in}-volume"
}
