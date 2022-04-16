
resource "docker_image" "blockchain_image" {
  # name = var.deployment_image[terraform.workspace]
  name =  "si3mshady/blockchain_app:1"
}
