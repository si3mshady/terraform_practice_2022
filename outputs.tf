output "container_connections" {
  value = [for x in module.docker_container[*] : x]
}

#
# output "module_container_metadata" {
#     value = module.docker_container[*]
# }
#
# output "module_container_name" {
#     value = module.docker_container[*].container_name
# }
#
# output "module_container_ip_with_port" {
#     value = module.docker_container[*].joined_container_ip_and_port_forLoop
# }
#
#
# # output "joined_container_ip_and_port_flatten"{
# #     value = join(":", flatten([docker_container.blockchain_container[*].ip_address,
# #     docker_container.blockchain_container[0].ports[0].external]))
#
# #   description = "joined container ip and port using flatten"
# # }
#
# # output "joined_container_ip_and_port_forLoop"{
# #     value = [for i in  docker_container.blockchain_container[*]:
# #      join(":",[i.ip_address],[i.ports[0].external])]
#
# #   description = "joined container ip and port using flatten"
# # }
#
# # output "container_name"{
#
# #     value = docker_container.blockchain_container[*].name
#
# #   description = "container_name"
# # }
#
