terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.16.0"
    }
  }
}

provider "docker" {}


resource "docker_image" "blockchain_image" {
  name = "si3mshady/blockchain_app:1"
}

resource "docker_container" "blockchain_container" {
  name = join("-",["blockchain_container", random_string.var.result])
  image = docker_image.blockchain_image.latest
  ports {
      internal = 80
    #   external = 8080

 }
}

resource "random_string" "var" {
    length = 5
    special = false
  
}

output "joined_container_ip_and_port"{
    value = join(":", [docker_container.blockchain_container.ip_address, docker_container.blockchain_container.ports[0].external])
  description = "joined container ip and port"
}

output "container_name"{
    value = docker_container.blockchain_container.name
  description = "container_name"
}