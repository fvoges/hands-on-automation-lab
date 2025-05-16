output "instance_id" {
  description = "ID of the EC2 instance."
  value       = aws_instance.main.id
}

output "instance_arn" {
  description = "ARN of the EC2 instance."
  value       = aws_instance.main.arn
}

output "primary_network_interface_id" {
  description = "ID of the primary network interface."
  value       = aws_instance.main.primary_network_interface_id
}

output "private_ip" {
  description = "Private IP address of the instance."
  value       = aws_instance.main.private_ip
}

output "public_ip" {
  description = "Public IP address of the instance (if applicable)."
  value       = aws_instance.main.public_ip
}

output "public_dns" {
  description = "Public DNS of the instance (if applicable)."
  value       = aws_instance.main.public_dns
}

output "security_group_id" {
  description = "ID of the security group associated with the instance."
  value       = aws_security_group.main.id
}

output "ami_id_used" {
  description = "The ID of the AMI that was used to launch the instance."
  value       = data.aws_ami.selected_ami.id
}
