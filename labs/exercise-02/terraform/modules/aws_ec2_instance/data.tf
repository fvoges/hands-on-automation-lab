# We need the supported architectures for the instance type
# to filter the AMI by architecture
data "aws_ec2_instance_type" "details" {
  instance_type = var.instance_type
}

# Search for the latest AMI
data "aws_ami" "selected_ami" {
  most_recent = true
  owners      = var.ami_owners

  filter {
    name   = "name"
    values = [var.ami_name_filter]
  }

  filter {
    name   = "architecture"
    values = data.aws_ec2_instance_type.details.supported_architectures
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
