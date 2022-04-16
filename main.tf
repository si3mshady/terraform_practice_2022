
resource "null_resource" "testDirectory" {
  provisioner "local-exec" {
      command = "mkdir elliotts_blockchain_volume && echo volume created! || true && echo volume exists!"  
  }
}


module "docker_image" {
  source = "./image_module"
}
# resource "docker_image" "blockchain_image" {
  # name = var.deployment_image[terraform.workspace]
# }

resource "docker_container" "blockchain_container" {
  count = local.container_count
  name = join("-",["blockchain_container", terraform.workspace, random_string.var[count.index].result])
  image = module.image_module.docker_image_output
  ports {
      internal = 80
      external = var.ext_port_mapping[terraform.workspace][count.index]
 }

 volumes {
     container_path = "/app"
     host_path = "${path.cwd}/elliotts_blockchain_volume"
 }
}

resource "random_string" "var" {
    count = local.container_count
    length = 5
    special = false
  
}

