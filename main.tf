
# 
resource "null_resource" "testDirectory" {
  provisioner "local-exec" {
      command = "mkdir elliotts_blockchain_volume && echo volume created! || true && echo volume exists!"  
  }
}


module "docker_image" {
  source = "./image_module"
 image_in =  var.deployment_image[terraform.workspace]
}

module "docker_container" {
  source = "./container_module"
  image_in = module.docker_image.docker_image_output    
  name_in = join("-",["blockchain_container",null_resource.testDirectory.id, terraform.workspace, random_string.var[count.index].result])
  count = local.container_count
  internal_port_in = 80
  external_port_in = var.ext_port_mapping[terraform.workspace][count.index]
  container_path_in = "/app"
  host_path_in = "${path.cwd}/elliotts_blockchain_volume"
 
# 


}

# resource "docker_image" "blockchain_image" {
  # name = var.deployment_image[terraform.workspace]
# }

# resource "docker_container" "blockchain_container" {
#   depends_on = [null_resource.testDirectory]

#   count = local.container_count
#   name = join("-",["blockchain_container",null_resource.testDirectory.id, terraform.workspace, random_string.var[count.index].result])
#   image = var.deployment_image[terraform.workspace]
#   ports {
#       internal = 80
#       external = var.ext_port_mapping[terraform.workspace][count.index]
#  }

#  volumes {
#      container_path = "/app"
#      host_path = "${path.cwd}/elliotts_blockchain_volume"
#  }

#  volumes {
#      container_path = "/app"
#      host_path = "${path.cwd}/elliotts_blockchain_volume"
#  }
# 
# }

resource "random_string" "var" {
    count = local.container_count
    length = 5
    special = false
  
}

