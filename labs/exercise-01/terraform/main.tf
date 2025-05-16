resource "random_pet" "prefix" {
  length = 1
}

# --- Instance 1 ---
resource "aws_security_group" "sg_uno" {
  name        = "sg_uno_firewall"
  description = "Firewall for instance uno"
  vpc_id      = data.aws_vpc.selected_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg_uno_firewall"
  }
}

resource "aws_instance" "instance_uno" {
  ami                    = data.aws_ami.ubuntu_arm64.id
  instance_type          = "t4g.nano"
  key_name               = var.ssh_key_name
  subnet_id              = local.subnet_id
  vpc_security_group_ids = [aws_security_group.sg_uno.id]

  tags = {
    Name    = "instance_uno_compute"
    Purpose = "GenericCompute"
    ID      = "Uno"
  }
}

# --- Instance 2 ---
resource "aws_security_group" "sg_dos" {
  name        = "firewall_for_dos_app"
  description = "Firewall for instance dos"
  vpc_id      = data.aws_vpc.selected_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "firewall_for_dos_app"
  }
}

resource "aws_instance" "instance_dos" {
  ami                    = data.aws_ami.ubuntu_arm64.id
  instance_type          = "t4g.nano"
  key_name               = var.ssh_key_name
  subnet_id              = local.subnet_id
  vpc_security_group_ids = [aws_security_group.sg_dos.id]

  tags = {
    Name    = "application_server_dos"
    Purpose = "AppServer"
    ID      = "Dos"
    Version = "1.0"
  }
}

# --- Instance 3 ---
resource "aws_security_group" "sg_tres" {
  name        = "security_group_tres"
  description = "Security group for instance tres"
  vpc_id      = data.aws_vpc.selected_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "security_group_tres"
  }
}

resource "aws_instance" "instance_tres" {
  ami                    = data.aws_ami.ubuntu_arm64.id
  instance_type          = "t4g.nano"
  key_name               = var.ssh_key_name
  subnet_id              = local.subnet_id
  vpc_security_group_ids = [aws_security_group.sg_tres.id]

  root_block_device {
    volume_size = 12 # Slightly different root volume
  }

  tags = {
    Name    = "tres_worker_node"
    Purpose = "Worker"
    ID      = "Tres"
  }
}

# --- Instance 4 ---
resource "aws_security_group" "sg_quatro" {
  name        = "quatro_instance_access" # Slightly different naming
  description = "Access rules for instance quatro"
  vpc_id      = data.aws_vpc.selected_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "quatro_instance_access"
  }
}

resource "aws_instance" "instance_quatro" {
  ami                    = data.aws_ami.ubuntu_arm64.id
  instance_type          = "t4g.nano"
  key_name               = var.ssh_key_name
  subnet_id              = local.subnet_id
  vpc_security_group_ids = [aws_security_group.sg_quatro.id]
  user_data              = <<-EOF
              #!/bin/bash
              echo "Hello from instance Quatro" > /tmp/quatro.txt
              EOF

  tags = {
    Name        = "data_processor_quatro"
    Purpose     = "Processing"
    ID          = "Quatro"
    Criticality = "Medium"
  }
}

# --- Instance 5 ---
resource "aws_security_group" "sg_cinco" {
  name        = "cinco-sg-policy" # Different naming convention
  description = "SG policy for instance cinco"
  vpc_id      = data.aws_vpc.selected_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cinco-sg-policy"
  }
}

resource "aws_instance" "instance_cinco" {
  ami                     = data.aws_ami.ubuntu_arm64.id
  instance_type           = "t4g.nano"
  key_name                = var.ssh_key_name
  subnet_id               = local.subnet_id
  vpc_security_group_ids  = [aws_security_group.sg_cinco.id]
  disable_api_termination = true

  tags = {
    Name    = "cinco_monitoring_box"
    Purpose = "Monitoring"
    ID      = "Cinco"
  }
}
