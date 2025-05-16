resource "random_pet" "prefix" {
  length = 1
}


module "ec2_instances" {
  for_each = local.instances # Iterate over the map defined in locals.tf
  source   = "./modules/aws_ec2_instance"

  instance_name        = each.key                                        # e.g., "instance_uno_compute"
  instance_type        = lookup(each.value, "instance_type", "t4g.nano") # Use default if not specified
  vpc_id               = local.vpc_id
  subnet_id            = local.subnet_id                                  # Ensure this is not null
  key_name             = var.ssh_key_name                                 # Ensure this is not an empty string
  security_group_rules = lookup(each.value, "security_group_rules", null) # Pass null to use module default
  ebs_volumes          = lookup(each.value, "ebs_volumes", [])
  tags                 = lookup(each.value, "tags", {})
  # Module specific overrides from local map if present
  root_block_device_size  = lookup(each.value, "root_block_device_size", null)
  disable_api_termination = lookup(each.value, "disable_api_termination", false)
  user_data               = lookup(each.value, "user_data", null)
  prefix                  = "${resource.random_pet.prefix.id}_"

  # Potentially other module variables like ami_name_pattern, ami_owners if you want to customize them per instance
}

