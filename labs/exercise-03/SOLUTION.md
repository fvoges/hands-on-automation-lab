### Solution for Exercise 2 Modifications

Create a file named `solution_exercise-02.md` in the `exercise-02` directory or refer to the instructions below.

**To complete the tasks, you would modify `exercise-02/locals.tf` as follows:**

1. **Task 1: Modify instance type of `instance_uno_compute` to `t4g.small`.**

    - In the `local.instances` map, find the `instance_uno_compute` entry.
    - Change its `instance_type` attribute.

    Diff

    ```diff
    # locals.tf
    # ...
      "instance_uno_compute" = {
    -   instance_type = "t4g.nano"
    +   instance_type = "t4g.small" # MODIFIED
        tags = {
          Purpose = "GenericCompute"
          ID      = "Uno"
        }
      },
    # ...
    ```

2. **Task 2: Add custom inbound SSH rule to `application_server_dos`.**

    - In `local.instances`, find the `application_server_dos` entry.
    - Add or modify the `security_group_rules` attribute. Remember the module's default is outbound only. You need to provide the full list of rules you want, including the default egress if you still need it.

    Diff

    ```diff
    # locals.tf
    # ...
      "application_server_dos" = {
        instance_type = "t4g.nano"
        tags = {
          Purpose = "AppServer"
          ID      = "Dos"
          Version = "1.0"
        }
    -   security_group_rules = null # Will use module default initially
    +   # MODIFIED: Add custom SSH rule, keeping the default egress rule.
    +   security_group_rules = {
    +     "default-egress" = {
    +       type        = "egress"
    +       from_port   = 0
    +       to_port     = 0
    +       protocol    = "-1"
    +       cidr_blocks = ["0.0.0.0/0"]
    +       description = "Allow all outbound traffic"
    +     },
    +     "ingress-ssh" = {
    +       type        = "ingress"
    +       from_port   = 22
    +       to_port     = 22
    +       protocol    = "tcp"
    +       cidr_blocks = [var.my_ip_for_ssh] # Use the variable for your IP
    +       description = "Allow SSH access"
    +     }
    +   }
      },
    # ...
    ```

    _(Note: Ensure `var.my_ip_for_ssh` is defined in `variables.tf` and you provide its value or change it directly)._

3. **Task 3: Add a new 10GB EBS volume to `tres_worker_node`.**

    - In `local.instances`, find the `tres_worker_node` entry.
    - Add an `ebs_volumes` attribute.

    Diff

    ```diff
    # locals.tf
    # ...
      "tres_worker_node" = {
        instance_type          = "t4g.nano"
        root_block_device_size = 12
        tags = {
          Purpose = "Worker"
          ID      = "Tres"
        }
    +   # MODIFIED: Add custom EBS volume
    +   ebs_volumes = [
    +     {
    +       device_name           = "/dev/sdf" # or /dev/xvdf
    +       volume_size           = 10
    +       volume_type           = "gp3"
    +       delete_on_termination = true
    +     }
    +   ]
      },
    # ...
    ```

After applying these changes in `locals.tf`, `terraform plan` will show the same intended infrastructure changes as in Exercise 1, but the modifications to the code are much more concise and centralized.

This lab structure should provide a clear, hands-on comparison of the two approaches and effectively highlight the advantages of using Terraform modules for AWS infrastructure. Remember to have an existing VPC and an SSH key pair in your AWS account and region before starting the lab.
