#   type =  string
#   description = "deployment environment"
#   default = "dev"
# variable "env" {
  
# }
variable "deployment_image" {

  type = map 
  description = "deployment image"
  default = {
    dev = "nginx:latest"
    qa = "nginx:latest"
    prod = "si3mshady/blockchain_app:1"
  }
  
}


variable "ext_port" {
  type = number
  default = 899
  validation {
    condition  = var.ext_port >= 888 &&  var.ext_port <=1000
    error_message = "Valid port range is 888 - 1000."
  }
}


variable "ext_port_mapping" {
  type = map
  
  validation {
    condition  = max(var.ext_port_mapping["dev"]...) >= 888 &&  min(var.ext_port_mapping["dev"]...) <=10000
    error_message = "Ports are not within range.var."
  }

   validation {
    condition  = max(var.ext_port_mapping["prod"]...) >= 888 &&  min(var.ext_port_mapping["prod"]...) <=10000
    error_message = "Ports are not within range.var."
  }
}

locals {
  container_count = length(var.ext_port_mapping[terraform.workspace])

}

variable "container_count" {
  type = number
  default = 4
}

# variable "container_image" {
#   type = string
#   default = "si3mshady/blockchain_app:1"

#   validation {
#     condition  = var.container_image == "si3mshady/blockchain_app:1"
#     error_message = "Currently only version 1 of Elliot's blockchain app exists."
#   }
# }   


  