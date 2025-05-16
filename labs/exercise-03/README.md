## Exercise 3: Using a Reusable Module with simpler data structure

This exercise demonstrates how to use a Terraform module to create the same 5 EC2 instances and their security groups. You'll see how modifications become much simpler.

### Instructions for Exercise 3

1. **Navigate to `exercise-02` directory.**
2. **Review the Code:** You don't have to change anything yet
    - `provider.tf`, `variables.tf`, `data.tf`: Similar to Exercise 1.
    - `modules/aws_ec2_instance/`: This directory contains a reusable module for creating an EC2 instance with an associated security group.
        - `modules/aws_ec2_instance/data.tf`: Contains the data sources used to obtain some necessary information (e.g., latest Ubuntu AMI ID).
        - `modules/aws_ec2_instance/main.tf`: Defines the `aws_instance` and `aws_security_group`, using `for_each` for rules and dynamic blocks for EBS. It also includes data sources for AMI selection based on instance type.
        - `modules/aws_ec2_instance/variables.tf`: Defines input variables for the module (e.g., `instance_name`, `instance_type`, `security_group_rules`, `ebs_volumes`).
        - `modules/aws_ec2_instance/outputs.tf`: Defines outputs of the module.
    - `locals.tf`: Defines the configuration for each of the 5 instances using a map. This is where you'll make customizations.
    - `main.tf`: Uses the `aws_ec2_instance` module in a `for_each` loop to create the 5 instances based on the configurations in `locals.tf`.
    - `outputs.tf`: Defines outputs based on the module outputs.
3. **Initialize Terraform:**

    Bash

    ```shell
    terraform init
    ```

4. **Apply the Configuration:**

    Bash

    ```shell
    terraform apply
    ```

    Confirm the plan. This will create 5 EC2 instances and 5 security groups, managed by the module.
5. **Perform the Following Modifications (Same as Exercise 1):** The goal is to see how much easier it is to make these changes by only modifying the input data in `locals.tf`.
    - **Task 1:** Modify the instance type of `instance_uno_compute` from `t4g.nano` to `t4g.small`.
    - **Task 2:** Add a custom inbound SSH rule (TCP port 22) to the security group for `application_server_dos`. Allow SSH access from your IP address.
    - **Task 3:** Add a new 10GB EBS volume mounted as `/dev/sdf` to the `tres_worker_node` instance. Ensure it's deleted on termination.
6. **Apply Changes:** After making the code changes in `locals.tf`, run `terraform apply` again and observe the proposed changes. Notice how much cleaner the modification process is.
7. **Clean Up:** When done, run `terraform destroy`, and confirm by typing `yes`.

