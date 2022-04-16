ext_port_mapping= {
    dev = [8001]
    prod = [7722]
    
     }

#  plan -var="env=dev" | grep external
#  plan -var="env=prod" | grep externalprod