ext_port_mapping= {
    dev = [8001,8002,8003]
    prod = [7722, 8324, 5334]
    
     }

#  plan -var="env=dev" | grep external
#  plan -var="env=prod" | grep externalprod