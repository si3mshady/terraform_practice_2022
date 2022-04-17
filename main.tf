
#
# resource "null_resource" "testDirectory" {
#   provisioner "local-exec" {
#       command = "mkdir elliotts_blockchain_volume && echo volume created! || true && echo volume exists!"
#   }
# }
locals {

  deployment = {
    blockchain = {
      image          = var.deployment_image["blockchain"][terraform.workspace]
      internal       = 3000
      external       = var.ext_port_mapping["blockchain"][terraform.workspace][0]
      container_path = "/app"
    }

    nginx = {
      image          = var.deployment_image["nginx"][terraform.workspace]
      internal       = 80
      external       = var.ext_port_mapping["nginx"][terraform.workspace][0]
      container_path = "/app"
    }
  }
}

module "image" {
  source   = "./image_module"
  for_each = local.deployment
  image_in = each.value.image
}

# module "blockchain_docker_image" {
#   source   = "./image_module"
#   image_in = var.deployment_image["blockchain"][terraform.workspace]
# }




module "docker_container" {
  source   = "./container_module"
  image_in = module.image["blockchain"].docker_image_output

  for_each = local.deployment
  name_in  = join("-", [each.key, terraform.workspace, random_string.var[each.key].result])

  # count             = local.container_count
  internal_port_in  = each.value.internal
  external_port_in  = each.value.external
  container_path_in = each.value.container_path
  host_path_in      = "${path.cwd}/elliotts_blockchain_volume"


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
  for_each = local.deployment
  length   = 5
  special  = false

}
