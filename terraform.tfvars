ext_port_mapping = {
  blockchain = {
    dev  = [8001]
    prod = [7722, 3453, 8133, 8433]
  }

  nginx = {
    dev  = [8041]
    prod = [8003, 889, 811, 888]

  }

}

#  plan -var="env=dev" | grep external
#  plan -var="env=prod" | grep externalprod
