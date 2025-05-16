variable "instance_name" {
  description = "Name of the EC2 instance and prefix for related resources."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t4g.nano"
}

variable "vpc_id" {
  description = "ID of the VPC where the instance and security group will be created."
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet where the instance will be launched."
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key pair to use for the instance."
  type        = string
}

variable "ami_name_filter" {
  description = "Name filter for AMI lookup."
  type        = string
  default     = "ubuntu/images/hvm-ssd*/ubuntu-noble-24.04-*-server-*" # %s will be replaced by architecture
}

variable "ami_owners" {
  description = "List of AMI owners."
  type        = list(string)
  default     = ["099720109477"] # Canonical
}

variable "security_group_rules" {
  description = "A list of security group rule objects to apply to the instance's security group."
  type = map(object({
    type              = string # "ingress" or "egress"
    from_port         = number
    to_port           = number
    protocol          = string # Typically "tcp", "udp", "icmp", "icmpv6", or "-1" for all protocols
    cidr_blocks       = optional(list(string))
    ipv6_cidr_blocks  = optional(list(string))
    prefix_list_ids   = optional(list(string))
    security_group_id = optional(string) # For source/dest SGs
    self              = optional(bool)
    description       = optional(string)
  }))
  default = null
}

variable "default_security_group_rule" {
  type = map(object({
    type              = string # "ingress" or "egress"
    from_port         = number
    to_port           = number
    protocol          = string # Typically "tcp", "udp", "icmp", "icmpv6", or "-1" for all protocols
    cidr_blocks       = optional(list(string))
    ipv6_cidr_blocks  = optional(list(string))
    prefix_list_ids   = optional(list(string))
    security_group_id = optional(string) # For source/dest SGs
    self              = optional(bool)
    description       = optional(string)
  }))
  description = "Default security group rule."
  default = {
    "outbound-all" = {
      type        = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1" # All protocols
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all outbound traffic"
    },
  }
}

variable "ebs_volumes" {
  description = "A list of EBS block device objects to attach to the instance."
  type = list(object({
    device_name           = string
    volume_size           = number # In GiB
    volume_type           = optional(string, "gp3")
    iops                  = optional(number)
    throughput            = optional(number) # In MiB/s, for gp3
    delete_on_termination = optional(bool, true)
    encrypted             = optional(bool, false)
    kms_key_id            = optional(string)
  }))
  default = []
}

variable "tags" {
  description = "A map of tags to assign to the instance and security group."
  type        = map(string)
  default     = {}
}

variable "root_block_device_size" {
  description = "Size of the root block device in GiB. If null, uses AMI default."
  type        = number
  default     = null # Use AMI default
}

variable "disable_api_termination" {
  description = "If true, enables EC2 instance termination protection."
  type        = bool
  default     = false
}

variable "user_data" {
  description = "User data script to launch with the instance."
  type        = string
  default     = null
}

variable "prefix" {
  description = "Prefix for the resources created by this module."
  type        = string
  default     = ""
}