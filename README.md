Introduction
Terraform and Ansible are powerful tools that can work synergistically to provision and configure cloud infrastructure. In this repository, we'll explore how to utilize Terraform for infrastructure provisioning and Ansible for configuration management i.e. Installing Docker and start service on boot and deploy basic HTML applicaiton , all within the context of Microsoft Azure


Prerequisite:
Azure Account-  To create and manage resources on the Azure cloud platform.
Service Principal - To connect from Github to Azure to deploy resources and it should have required permissions on Azure
GitHub account - used for version control and repository
*****************************************************************************************************************************************************
Repository folder structure:
1. Terraform folder - It has all Terraform code to deploy Linux Virtaul machine on Azure with assocaited resources
2. Ansible folder - It contains all files it required to automate configuration and playbook YAML file
3. App folder - It contains basic application code

1. Terraform folder - Navigate to the terraform/ directory.

  . Defined required terraform files ( main.tf, variable.tf, outputs.tf ) which is required to deploy linux VM and it's associated resources 
  . Below are the steps used to create resources defined in GitHub actions
     -> terraform init
     -> terraform plan 
     -> terraform apply

2. Ansible folder - Navigate to the ansible/ directory 

Locate the playbook.yaml playbook.
Open the playbook to explore its contents and understand the configuration steps.
Modify the playbook as needed to customize the static website you want to host.
Execute the playbook using Ansible to apply the configuration to your provisioned web servers.
Please note that this example playbook demonstrates the power of using Ansible for configuration management. 

3. App Folder - Navigate to /app folder

It contains basic HTML page with CSS files and image that we want to deploy on Linux machine

********************************************************************************************************************************************************
Automation with GitHub Actions
it's time to take advantage of automation for seamless deployments. In this repository, we've provided GitHub Actions workflows in the .github/workflows directory that enable you to automate the entire process from provisioning to configuration.

GitHub Actions Workflows
In the .github/workflows directory, you'll find predefined workflows that leverage GitHub Actions to automate the Terraform provisioning and Ansible configuration steps. These workflows ensure consistency, reliability, and efficiency throughout your deployment process.

To utilize these workflows:

Navigate to the .github/workflows directory.
Review deploy.yaml used to automatate this whole process
Customize the workflows as needed to match your environment and preferences.
GitHub Actions will trigger these workflows based on specific events, such as pushes and pull request to the main repository.
Please note that these GitHub Actions workflows are designed to eliminate the need for manual intervention during deployments. This means that the steps you previously followed for local development are now automated through GitHub Actions.

Below GitHub jobs defined for whole process:
- We used GitHub runner VM ( ubuntu-latest )
- Defined GitHub Environment varabiles & Secrets for Azure Authentication
      AZURE_CLIENT_ID - SPN ID
      AZURE_CLIENT_SECRET - SPN Secret
      AZURE_SUBSCRIPTION_ID - Azure Subscription
      AZURE_TENANT_ID - Azure AD Tenant ID
- Checkout the repository ( Copy entire code to GitHub VM )
- Azure Login ( Authenticate to Azure )
- Set up Terraform
- Initialize Terraform
- Terraform Plan
- Terraform Apply
- Retreive Public IP of VM
- Validate SSH connectoion
- Install dependencies for Ansible on source and destination VM
- Run Ansible playbook

Conclusion
By embracing GitHub Actions workflows available in the .github/workflows directory, you can streamline your deployment process, eliminate manual intervention, and ensure efficient provisioning and configuration of your Azure cloud infrastructure. This automation empowers you to focus on refining your Terraform configurations and Ansible playbooks while maintaining confidence in your deployments.


