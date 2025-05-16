data "aws_vpc" "selected_vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnets" "selected_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected_vpc.id]
  }
  filter {
    name   = "availability-zone"
    values = [data.aws_availability_zones.available.names[0]]
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

// Check if a subnet was found
resource "null_resource" "subnet_check" {
  count = local.subnet_id == null ? 1 : 0
  provisioner "local-exec" {
    when    = create
    command = "echo 'Error: No suitable subnet found in the specified VPC and first available AZ. Please check your VPC configuration.' && exit 1"
  }
}
