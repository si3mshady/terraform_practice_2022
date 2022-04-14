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
  name = var.container_image
}

resource "docker_container" "blockchain_container" {
  count = var.container_count
  name = join("-",["blockchain_container", random_string.var[count.index].result])
  image = docker_image.blockchain_image.latest
  ports {
      internal = 80
      external = var.ext_port + count.index
 }

 volumes {
     container_path = "/app"
     host_path = "/Users/si3mshady/terraform2022/docker_lesson/elliotts_blockchain_volume"
 }
}

resource "random_string" "var" {
    count = var.container_count
    length = 5
    special = false
  
}

