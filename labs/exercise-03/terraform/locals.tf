locals {
  # Common data lookups, similar to Exercise 1 but used for module inputs
  vpc_id    = data.aws_vpc.selected_vpc.id
  subnet_id = length(data.aws_subnets.selected_subnets.ids) > 0 ? data.aws_subnets.selected_subnets.ids[0] : tostring(null) # tostring(null) to avoid type issues if null

  # Define configurations for each of the 5 instances
  # These names correspond to the names used in Exercise 1 for easier comparison

  instance_uno_compute = {
    name         = "uno_compute"
    instance_type = "t4g.nano" # Initial
    tags = {
      Purpose = "GenericCompute"
      ID      = "Uno"
    }
    # security_group_rules: uses module default (outbound only)
    # ebs_volumes: uses module default (none)
  }
  application_server_dos = {
    name = "dos_app_server"
    instance_type = "t4g.nano"
    tags = {
      Purpose = "AppServer"
      ID      = "Dos"
      Version = "1.0"
    }
    # Custom security_group_rules can be added here for Task 2 solution
    security_group_rules = null # Will use module default initially
  }
  tres_worker_node = {
    name = "tres_worker_node"
    instance_type          = "t4g.nano"
    root_block_device_size = 12 # Custom root volume size
    tags = {
      Purpose = "Worker"
      ID      = "Tres"
    }
    # Custom ebs_volumes can be added here for Task 3 solution
  }
  data_processor_quatro = {
    name         = "quatro_processor"
    instance_type = "t4g.nano"
    user_data     = <<-EOF
                      #!/bin/bash
                      echo "Hello from instance Quatro (Module)" > /tmp/quatro_module.txt
                      EOF
    tags = {
      Purpose     = "Processing"
      ID          = "Quatro"
      Criticality = "Medium"
    }
  }
  cinco_monitoring_box = {
    name = "cinco_monitoring"
    instance_type           = "t4g.nano"
    disable_api_termination = true
    tags = {
      Purpose = "Monitoring"
      ID      = "Cinco"
    }
  }
}
