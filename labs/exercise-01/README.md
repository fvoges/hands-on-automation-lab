# Lab exercises

## Exercise 1: The "Copy & Paste" Method

This exercise simulates a scenario where infrastructure code is duplicated for similar resources, leading to inefficiencies and difficulties in maintenance.

### Instructions for Exercise 1

1. **Navigate to `exercise-01/terraform` directory.**
2. **Review the Code:** You don't have to change anything yet
    - `provider.tf`: Configures the AWS provider.
    - `variables.tf`: Defines input variables like `aws_region` and `vpc_name`.
    - `data.tf`: Contains the data sources used to obtain some necessary information (e.g., latest Ubuntu AMI ID),
    - `main.tf`: Contains the resource definitions for 5 EC2 instances and their corresponding security groups. Notice how each resource is defined separately, leading to a lot of repeated code. The resources have slightly different names and tags to mimic a less standardized environment.
    - `outputs.tf`: Defines outputs, such as instance IDs.
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

    Confirm the plan by typing `yes`. This will create 5 EC2 instances and 5 security groups.
5. **Perform the Following Modifications:** The goal is to see how cumbersome it is to make changes across multiple, separately defined resources.
    - **Task 1:** Modify the instance type of `instance_uno_compute` from `t4g.nano` to `t4g.small`.
    - **Task 2:** Add a custom inbound SSH rule (TCP port 22) to the security group `firewall_for_dos_app` (associated with `application_server_dos`). Allow SSH access from your IP address (e.g., `YOUR_IP/32`).
    - **Task 3:** Add a new 10GB EBS volume mounted as `/dev/xvdf` to the `tres_worker_node` instance. Ensure it's deleted on termination.
6. **Apply Changes:** After making the code changes, run `terraform apply` again and observe the proposed changes.
7. **Clean Up:** When done, run `terraform destroy`, and confirm by typing `yes`.
