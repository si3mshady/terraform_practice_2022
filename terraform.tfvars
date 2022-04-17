ext_port_mapping = {
  blockchain = {
    dev  = [8001]
    prod = [7722]
  }

  nginx = {
    dev  = [8041]
    prod = [7322]

  }

}

#  plan -var="env=dev" | grep external
#  plan -var="env=prod" | grep externalprod
