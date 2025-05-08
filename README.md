# Automation Hands-on Lab

This repo contains the code for a simple automation hands-on lab.

The goal of the lab is to compare DRY vs WET coding using Terraform and AWS EC2 instances.

There are two main directories:

- `copypaste` - Example code using multiple similar resource declarations (simulating a typical case of copy & paste coding).
- `reusable` - Example data-driven code using modules and reusable code patterns.

## Using the lab

The Terraform code included in the lab will create a series of EC2 instances with similar, but not exactly the same, configuration.

The delegates will have to change the configuration for a sub-set of the instances.

First using the non-reusable code (`copypaste`), and then, using the data-driven code (`reusable`).

## Requirements

### Lab infrastructure

EC2 infrastructure and credentials for applying the Terraform code (there's a separate repo that takes care of that).

### Delegates

- Desktop environment with
  - Visual Studio Code
    - Required extensions:
      - [Remote - SSH](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh)
    - Recommended extensions:
      - [Remote Development](https://marketplace.visualstudio.com/items/?itemName=ms-vscode-remote.vscode-remote-extensionpack) - which includes:
        - [Remote - SSH](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh)
        - [Remote - Tunnels](https://marketplace.visualstudio.com/items?itemName=ms-vscode.remote-server)
        - [Dev Containers](https://marketplace.visualstudio.com/items/?itemName=ms-vscode-remote.remote-containers)
        - [WSL](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.wsl)
      - [Visual Studio Code Remote - SSH: Editing Configuration Files](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-ssh-edit)
  - SSH client
  - Ability to connect to a public EC2 instance using SSH (outbound 22/TCP)

> **NOTE:**
>
> We recommend using a personal laptop instead of a work one. Work laptops usually have restrictions that might not allow delegates to perform some of the required tasks.
>
> For example, install the required software, limit connectivity, etc.

## Instructions

### Basic setup

In this section, we'll get the basics sorted out.

We're going to connect to the lab server using VS Code, and then we're going to make sure that everything is ready for the first exercise.

1. You should get the login information from the instructor
   - Hostname
   - Username
   - Password
2. Open VS Code
3. From the welcome screen, select "Connect to...", or use the command palette and select "Remote-SSH: Connect to host..."
4. In the dialog, enter the user and hostname provided using the `user@hostname` format
5. When prompted, enter the provided password

### Part one - WET coding

### Part two - DRY coding
