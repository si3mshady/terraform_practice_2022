resource "docker_container" "container" {

  count = var.container_count

  name  = join("-", [var.name_in, terraform.workspace, random_string.var[count.index].result])
  image = var.image_in
  ports {
    internal = var.internal_port_in
    external = var.external_port_in[count.index]
  }

  volumes {
    container_path = var.container_path_in
    # host_path = var.host_path_in
    volume_name = docker_volume.dv[count.index].name
  }
}


resource "docker_volume" "dv" {
  count = var.container_count
  name  = "${var.name_in}-${random_string.var[count.index].result}-volume"
}

resource "random_string" "var" {
  count = var.container_count

  length  = 5
  special = false

}
