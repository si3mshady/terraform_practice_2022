resource "docker_container" "blockchain_container" {

  name = var.name_in
  image = var.image_in
    ports {
        internal = var.internal_port_in
        external = var.external_port_in
    }  

 volumes {
     container_path = var.container_path_in
     host_path = var.host_path_in
 }
}