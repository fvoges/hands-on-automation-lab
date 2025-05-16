# Solution for Exercise 1 Modifications

Create a file named `solution_exercise-01.md` in the `exercise-01` directory or refer to the instructions below.

**To complete the tasks, you would modify `exercise-01/main.tf` as follows:**

1. **Task 1: Modify instance type of `instance_uno_compute` to `t4g.small`.**

    - Find the `aws_instance.instance_uno` resource.
    - Change `instance_type = "t4g.nano"` to `instance_type = "t4g.small"`.

    Diff

    ```diff
    # --- Instance 1 ---
    # ...
    resource "aws_instance" "instance_uno" {
      ami                    = data.aws_ami.ubuntu_arm64.id
    - instance_type          = "t4g.nano"
    + instance_type          = "t4g.small" # MODIFIED
      key_name               = local.ssh_key_name
      # ...
    }
    ```

2. **Task 2: Add custom inbound SSH rule to `firewall_for_dos_app`.**

    - Below the `aws_security_group.sg_dos` resource, add a new `aws_security_group_rule` resource.
    - Replace `var.my_ip_for_ssh` with your actual IP or use the variable.

    Terraform

    ```terraform
    # ... (end of aws_security_group.sg_dos) ...

    # ADDED for Task 2
    resource "aws_security_group_rule" "dos_ssh_ingress" {
      type              = "ingress"
      from_port         = 22
      to_port           = 22
      protocol          = "tcp"
      cidr_blocks       = [var.my_ip_for_ssh] # Use your IP address here e.g. "YOUR_IP/32"
      security_group_id = aws_security_group.sg_dos.id
      description       = "Allow SSH access"
    }

    resource "aws_instance" "instance_dos" {
    # ...
    ```

3. **Task 3: Add a new 10GB EBS volume to `tres_worker_node`.**

    - Find the `aws_instance.instance_tres` resource.
    - Add an `ebs_block_device` block.

    Diff

    ```diff
    resource "aws_instance" "instance_tres" {
      ami                    = data.aws_ami.ubuntu_arm64.id
      instance_type          = "t4g.nano"
      key_name               = local.ssh_key_name
      subnet_id              = local.subnet_id
      vpc_security_group_ids = [aws_security_group.sg_tres.id]

      root_block_device {
        volume_size = 12
      }

    + # ADDED for Task 3
    + ebs_block_device {
    +   device_name           = "/dev/sdf" # or /dev/xvdf depending on OS/AMI
    +   volume_size           = 10
    +   volume_type           = "gp3"
    +   delete_on_termination = true
    + }

      tags = {
        Name    = "tres_worker_node"
        Purpose = "Worker"
        ID      = "Tres"
      }
    }
    ```

After applying these changes, `terraform plan` will show one instance modified, one security group rule added, and one instance with a new EBS volume.
