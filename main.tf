terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.16.0"
    }
  }
}

provider "docker" {}

resource "null_resource" "testDirectory" {
  provisioner "local-exec" {
      command = "mkdir elliotts_blockchain_volume && echo volume created! || true && echo volume exists!"  
  }
}

resource "docker_image" "blockchain_image" {
  name = lookup(var.deployment_image,  var.env)
}

resource "docker_container" "blockchain_container" {
  count = local.container_count
  name = join("-",["blockchain_container", random_string.var[count.index].result])
  image = docker_image.blockchain_image.latest
  ports {
      internal = 80
      external = var.ext_port_list[count.index]
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

