
variable "ext_port" {
  type = number
  default = 899
  validation {
    condition  = var.ext_port >= 888 &&  var.ext_port <=1000
    error_message = "Valid port range is 888 - 1000."
  }
}

variable "container_count" {
  type = number
  default = 4
}

variable "container_image" {
  type = string
  default = "si3mshady/blockchain_app:1"

  validation {
    condition  = var.container_image == "si3mshady/blockchain_app:1"
    error_message = "Currently only version 1 of Elliot's blockchain app exists."
  }
}