# Terraform and Ansible Integration on Microsoft Azure

## Introduction

Terraform and Ansible are powerful tools that can work synergistically to provision and configure cloud infrastructure. In this repository, we'll explore how to utilize Terraform for infrastructure provisioning and Ansible for configuration management, specifically to install Docker, start the service on boot, and deploy a basic HTML application—all within the context of Microsoft Azure.

## Prerequisites

- **Azure Account**: Required to create and manage resources on the Azure cloud platform.
- **Service Principal**: Needed to connect from GitHub to Azure for resource deployment; it should have the required permissions on Azure.
- **GitHub Account**: Used for version control and repository management.

## Repository Folder Structure

## Repository Folder Structure

```plaintext
.
├── terraform/         # Contains Terraform code for provisioning Azure resources
├── ansible/           # Contains Ansible playbooks and configuration files
├── app/               # Contains basic application code (HTML, CSS, images)
└── .github/workflows/ # Contains GitHub Actions workflows for automation
```

## Terraform Folder

1. Navigate to the `terraform/` directory.
2. Defined required Terraform files:
   - `main.tf`: Main configuration file for resource definitions.
   - `variables.tf`: Contains variable declarations.
   - `outputs.tf`: Specifies output values after resource creation.
3. Steps to create resources:
   - Run `terraform init` to initialize the working directory.
   - Execute `terraform plan` to see what will be created.
   - Apply changes with `terraform apply`.

## Ansible Folder

1. Navigate to the `ansible/` directory.
2. Locate the `playbook.yaml` file:
   - Open the playbook to explore its contents and understand the configuration steps.
   - Modify the playbook as needed to customize the static website you want to host.
3. Execute the playbook using Ansible to apply the configuration to your provisioned web servers.

## App Folder

1. Navigate to the `/app` folder.
2. This folder contains a basic HTML page along with CSS files and images that you want to deploy on the Linux machine.

## Automation with GitHub Actions

To take advantage of automation for seamless deployments, this repository provides GitHub Actions workflows in the `.github/workflows` directory that enable you to automate the entire process from provisioning to configuration.

## GitHub Actions Workflows

1. Navigate to the `.github/workflows` directory.
2. Review `deploy.yaml`, which automates the entire process.
3. Customize workflows as needed to match your environment and preferences:
   - GitHub Actions will trigger these workflows based on specific events, such as pushes and pull requests to the main repository.

## GitHub Jobs Defined for Whole Process

- **Environment Setup**:
  - Use GitHub runner VM (`ubuntu-latest`).
  - Define GitHub environment variables & secrets for Azure authentication:
    - `AZURE_CLIENT_ID`: Service Principal ID
    - `AZURE_CLIENT_SECRET`: Service Principal Secret
    - `AZURE_SUBSCRIPTION_ID`: Azure Subscription ID
    - `AZURE_TENANT_ID`: Azure AD Tenant ID
- **Workflow Steps**:
  1. Checkout the repository (copy entire code to GitHub VM).
  2. Authenticate with Azure.
  3. Set up Terraform.
  4. Initialize Terraform.
  5. Plan Terraform changes.
  6. Apply Terraform changes.
  7. Retrieve Public IP of VM.
  8. Validate SSH connection.
  9. Install dependencies for Ansible on source and destination VM.
  10. Run Ansible playbook.

## Conclusion

By embracing GitHub Actions workflows available in the `.github/workflows` directory, you can streamline your deployment process, eliminate manual intervention, and ensure efficient provisioning and configuration of your Azure cloud infrastructure. This automation empowers you to focus on refining your Terraform configurations and Ansible playbooks while maintaining confidence in your deployments.
