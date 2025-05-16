resource "random_pet" "prefix" {
  length = 1
}


module "instance_uno" {
   source   = "./modules/aws_ec2_instance"

  instance_name        = local.instance_uno_compute.name
  instance_type        = can(local.instance_uno_compute.instance_type) ? local.instance_uno_compute.instance_type : "t4g.nano"
  vpc_id               = local.vpc_id
  subnet_id            = local.subnet_id                                  # Ensure this is not null
  key_name             = var.ssh_key_name                                 # Ensure this is not an empty string
  security_group_rules = can(local.instance_uno_compute.security_group_rules) ? local.instance_uno_compute.security_group_rules : null
  ebs_volumes          = can(local.instance_uno_compute.ebs_volumes) ? local.instance_uno_compute.ebs_volumes : []
  tags                 = can(local.instance_uno_compute.tags) ? local.instance_uno_compute.tags : {}
  # Module specific overrides from local map if present
  root_block_device_size  = can(local.instance_uno_compute.root_block_device_size) ? local.instance_uno_compute.root_block_device_size : null
  disable_api_termination = can(local.instance_uno_compute.disable_api_termination) ? local.instance_uno_compute.disable_api_termination : false
  user_data               = can(local.instance_uno_compute.user_data) ? local.instance_uno_compute.user_data : null
  prefix                  = "${resource.random_pet.prefix.id}_"

  # Potentially other module variables like ami_name_pattern, ami_owners if you want to customize them per instance
}

module "instance_dos" {
   source   = "./modules/aws_ec2_instance"

  instance_name        = local.application_server_dos.name
  instance_type        = can(local.application_server_dos.instance_type) ? local.application_server_dos.instance_type : "t4g.nano"
  vpc_id               = local.vpc_id
  subnet_id            = local.subnet_id                                  # Ensure this is not null
  key_name             = var.ssh_key_name                                 # Ensure this is not an empty string
  security_group_rules = can(local.application_server_dos.security_group_rules) ? local.application_server_dos.security_group_rules : null
  ebs_volumes          = can(local.application_server_dos.ebs_volumes) ? local.application_server_dos.ebs_volumes : []
  tags                 = can(local.application_server_dos.tags) ? local.application_server_dos.tags : {}
  # Module specific overrides from local map if present
  root_block_device_size  = can(local.application_server_dos.root_block_device_size) ? local.application_server_dos.root_block_device_size : null
  disable_api_termination = can(local.application_server_dos.disable_api_termination) ? local.application_server_dos.disable_api_termination : false
  user_data               = can(local.application_server_dos.user_data) ? local.application_server_dos.user_data : null
  prefix                  = "${resource.random_pet.prefix.id}_"

  # Potentially other module variables like ami_name_pattern, ami_owners if you want to customize them per instance
}

module "instance_tres" {
   source   = "./modules/aws_ec2_instance"

  instance_name        = local.tres_worker_node.name
  instance_type        = can(local.tres_worker_node.instance_type) ? local.tres_worker_node.instance_type : "t4g.nano"
  vpc_id               = local.vpc_id
  subnet_id            = local.subnet_id                                  # Ensure this is not null
  key_name             = var.ssh_key_name                                 # Ensure this is not an empty string
  security_group_rules = can(local.tres_worker_node.security_group_rules) ? local.tres_worker_node.security_group_rules : null
  ebs_volumes          = can(local.tres_worker_node.ebs_volumes) ? local.tres_worker_node.ebs_volumes : []
  tags                 = can(local.tres_worker_node.tags) ? local.tres_worker_node.tags : {}
  # Module specific overrides from local map if present
  root_block_device_size  = can(local.tres_worker_node.root_block_device_size) ? local.tres_worker_node.root_block_device_size : null
  disable_api_termination = can(local.tres_worker_node.disable_api_termination) ? local.tres_worker_node.disable_api_termination : false
  user_data               = can(local.tres_worker_node.user_data) ? local.tres_worker_node.user_data : null
  prefix                  = "${resource.random_pet.prefix.id}_"

  # Potentially other module variables like ami_name_pattern, ami_owners if you want to customize them per instance
}

module "instance_cuantro" {
   source   = "./modules/aws_ec2_instance"

  instance_name        = local.data_processor_quatro.name
  instance_type        = can(local.data_processor_quatro.instance_type) ? local.data_processor_quatro.instance_type : "t4g.nano"
  vpc_id               = local.vpc_id
  subnet_id            = local.subnet_id                                  # Ensure this is not null
  key_name             = var.ssh_key_name                                 # Ensure this is not an empty string
  security_group_rules = can(local.data_processor_quatro.security_group_rules) ? local.data_processor_quatro.security_group_rules : null
  ebs_volumes          = can(local.data_processor_quatro.ebs_volumes) ? local.data_processor_quatro.ebs_volumes : []
  tags                 = can(local.data_processor_quatro.tags) ? local.data_processor_quatro.tags : {}
  # Module specific overrides from local map if present
  root_block_device_size  = can(local.data_processor_quatro.root_block_device_size) ? local.data_processor_quatro.root_block_device_size : null
  disable_api_termination = can(local.data_processor_quatro.disable_api_termination) ? local.data_processor_quatro.disable_api_termination : false
  user_data               = can(local.data_processor_quatro.user_data) ? local.data_processor_quatro.user_data : null
  prefix                  = "${resource.random_pet.prefix.id}_"

  # Potentially other module variables like ami_name_pattern, ami_owners if you want to customize them per instance
}

module "instance_cinco" {
   source   = "./modules/aws_ec2_instance"

  instance_name        = local.cinco_monitoring_box.name
  instance_type        = can(local.cinco_monitoring_box.instance_type) ? local.cinco_monitoring_box.instance_type : "t4g.nano"
  vpc_id               = local.vpc_id
  subnet_id            = local.subnet_id                                  # Ensure this is not null
  key_name             = var.ssh_key_name                                 # Ensure this is not an empty string
  security_group_rules = can(local.cinco_monitoring_box.security_group_rules) ? local.cinco_monitoring_box.security_group_rules : null
  ebs_volumes          = can(local.cinco_monitoring_box.ebs_volumes) ? local.cinco_monitoring_box.ebs_volumes : []
  tags                 = can(local.cinco_monitoring_box.tags) ? local.cinco_monitoring_box.tags : {}
  # Module specific overrides from local map if present
  root_block_device_size  = can(local.cinco_monitoring_box.root_block_device_size) ? local.cinco_monitoring_box.root_block_device_size : null
  disable_api_termination = can(local.cinco_monitoring_box.disable_api_termination) ? local.cinco_monitoring_box.disable_api_termination : false
  user_data               = can(local.cinco_monitoring_box.user_data) ? local.cinco_monitoring_box.user_data : null
  prefix                  = "${resource.random_pet.prefix.id}_"

  # Potentially other module variables like ami_name_pattern, ami_owners if you want to customize them per instance
}
