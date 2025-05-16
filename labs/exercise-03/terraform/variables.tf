variable "aws_region" {
  description = "AWS region to deploy resources."
  type        = string
  default     = "eu-west-2"
}

variable "vpc_name" {
  description = "Name of the existing VPC to deploy resources into."
  type        = string
  default     = "default"
}

variable "ssh_key_name" {
  description = "Name of the SSH key pair to use for EC2 instances."
  type        = string
  default     = "default" # Replace with your actual key name
}

variable "my_ip_for_ssh" {
  description = "Your IP address for SSH access (e.g., x.x.x.x/32). Used in the solution for Task 2."
  type        = string
  default     = "0.0.0.0/0" # WARNING: Open to all, for lab only if your IP is dynamic. Replace with your actual IP.
}
