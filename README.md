# Automated Deployment Project

This project automates the deployment of a simple HTML application using Terraform, Ansible, Docker, and Azure DevOps.

## Project Structure
- **Terraform**: Infrastructure provisioning with Azure VM.
- **Ansible**: Configuration management for setting up Docker.
- **Docker**: Containerized application using Nginx.
- **Azure Pipelines**: CI/CD pipeline to automate deployment.

## Instructions
1. Clone the repository.
2. Navigate to the `Terraform/` folder and run:
   ```bash
   terraform init
   terraform apply
