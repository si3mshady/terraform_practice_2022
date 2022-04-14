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
  count = 3
  name = join("-",["blockchain_container", random_string.var[count.index].result])
  image = docker_image.blockchain_image.latest
  ports {
      internal = 80
    #   external = 8080

 }
}

resource "random_string" "var" {
    count = 3
    length = 5
    special = false
  
}

# output "joined_container_ip_and_port_flatten"{
#     value = join(":", flatten([docker_container.blockchain_container[*].ip_address, docker_container.blockchain_container[0].ports[0].external]))
#   description = "joined container ip and port using flatten"
# }

output "joined_container_ip_and_port_forLoop"{
    value = [for i in  docker_container.blockchain_container[*]: join(":",[i.ip_address],[i.ports[0].external])]
  description = "joined container ip and port using flatten"
}

output "container_name"{
    
    value = docker_container.blockchain_container[*].name
  description = "container_name"
}