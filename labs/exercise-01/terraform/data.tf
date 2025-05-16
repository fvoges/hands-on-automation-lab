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
    name   = "availability-zone" # Ensure we pick a subnet in a specific AZ or just take the first
    values = [data.aws_availability_zones.available.names[0]]
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  # Select the first available subnet from the selected AZ.
  # A more robust solution would iterate or allow specific subnet IDs.
  subnet_id = length(data.aws_subnets.selected_subnets.ids) > 0 ? data.aws_subnets.selected_subnets.ids[0] : null
}

// Check if a subnet was found
resource "null_resource" "subnet_check" {
  count = local.subnet_id == null ? 1 : 0 # Create this resource only if subnet_id is null
  provisioner "local-exec" {
    when    = create
    command = "echo 'Error: No suitable subnet found in the specified VPC and first available AZ. Please check your VPC configuration.' && exit 1"
  }
}

// Common AMI for t4g.nano (arm64)
data "aws_ami" "ubuntu_arm64" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd*/ubuntu-*-24.04-*-server-*"] # For Ubuntu 24.04 ARM64
  }

  filter {
    name   = "architecture"
    values = ["arm64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
