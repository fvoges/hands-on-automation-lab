locals {
  instance_name = "${var.prefix}${var.instance_name}"
  security_group_rules = coalesce(var.security_group_rules, var.default_security_group_rule)
}


resource "aws_security_group" "main" {
  name        = "${local.instance_name}_sg"
  description = "Security group for instance ${local.instance_name}"
  vpc_id      = var.vpc_id

  tags = merge(var.tags, {
    Name = "${local.instance_name}_sg"
  })
  # No inline rules; all rules are managed by aws_security_group_rule resources
}

output "security_group_rules" {
  value = local.security_group_rules

}

# resource "aws_security_group_rule" "custom" {
#   for_each = local.security_group_rules

#   security_group_id        = aws_security_group.main.id
#   type                     = each.value.type
#   from_port                = each.value.from_port
#   to_port                  = each.value.to_port
#   protocol                 = each.value.protocol
#   cidr_blocks              = ["0.0.0.0/0"] # Defaultlookup(each.value, "cidr_blocks", "self")
#   ipv6_cidr_blocks         = lookup(each.value, "ipv6_cidr_blocks", null)
#   prefix_list_ids          = lookup(each.value, "prefix_list_ids", null)
#   source_security_group_id = lookup(each.value, "security_group_id", null)
#   self                     = lookup(each.value, "self", null)
#   description              = lookup(each.value, "description", null)
# }

resource "aws_instance" "main" {
  ami                     = data.aws_ami.selected_ami.id
  instance_type           = var.instance_type
  key_name                = var.key_name
  subnet_id               = var.subnet_id
  vpc_security_group_ids  = [aws_security_group.main.id]
  user_data               = var.user_data
  disable_api_termination = var.disable_api_termination

  dynamic "root_block_device" {
    for_each = var.root_block_device_size != null ? [1] : []
    content {
      volume_size = var.root_block_device_size
    }
  }

  dynamic "ebs_block_device" {
    for_each = var.ebs_volumes
    content {
      device_name           = ebs_block_device.value.device_name
      volume_size           = ebs_block_device.value.volume_size
      volume_type           = lookup(ebs_block_device.value, "volume_type", "gp3")
      iops                  = lookup(ebs_block_device.value, "iops", null)
      throughput            = lookup(ebs_block_device.value, "throughput", null)
      delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", true)
      encrypted             = lookup(ebs_block_device.value, "encrypted", false)
      kms_key_id            = lookup(ebs_block_device.value, "kms_key_id", null)
    }
  }

  tags = merge(var.tags, {
    Name = local.instance_name
  })
}
