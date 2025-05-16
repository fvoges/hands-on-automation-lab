# Automation Hands-on Lab

## Lab Overview

This lab is divided into two exercises. Both exercises aim to achieve the same initial setup: deploying 5 EC2 instances, each with its own dedicated security group. The key difference lies in _how_ these resources are defined and managed in Terraform.

**Common Infrastructure Requirements for Initial Setup (Both Exercises):**

- **EC2 Instances:** 5 instances.
- **Instance Type:** `t4g.nano`.
- **Security Groups:** Each instance will have its own security group.
  - **Default Rule:** Only allow all outbound traffic (all ports, all protocols, to `0.0.0.0/0`). No inbound traffic allowed by default.
- **VPC:** Instances will be deployed into a VPC specified by its name (the VPC ID will be looked up using a data source). You'll need to provide the name of an existing VPC.
- **SSH Key:** WIll use a key named `default`. It must exist in your AWS account.
- **AMI:** The latest available Ubuntu Server 24.04 LTS AMI for the `t4g.nano` architecture (`arm64`) will be used, discovered via data sources.

## Directory Structure

The files are organized as follows:

```plain
hands-on-automation-lab/
├── labs
│   ├── exercise-01
│   │   ├── README.md
│   │   ├── SOLUTION.md
│   │   └── terraform
│   │       ├── data.tf
│   │       ├── main.tf
│   │       ├── outputs.tf
│   │       ├── provider.tf
│   │       └── variables.tf
│   ├── exercise-02
│   │   ├── README.md
│   │   ├── SOLUTION.md
│   │   └── terraform
│   │       ├── data.tf
│   │       ├── locals.tf
│   │       ├── main.tf
│   │       ├── modules
│   │       │   └── aws_ec2_instance
│   │       │       ├── data.tf
│   │       │       ├── main.tf
│   │       │       ├── outputs.tf
│   │       │       └── variables.tf
│   │       ├── outputs.tf
│   │       ├── provider.tf
│   │       └── variables.tf
│   └── README.md
├── README.md
└── REQUIREMENTS.md
```

## Labs

For the labs instructions, see [labs/README.md](labs/README.md).
