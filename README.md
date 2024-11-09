├── Terraform/ │ ├── main.tf │ ├── variables.tf │ ├── outputs.tf │ └── provider.tf ├── Ansible/ │ ├── ansible.cfg │ ├── inventory │ └── playbook.yml ├── Docker/ │ ├── Dockerfile │ └── index.html ├── Azure-Pipelines/ │ └── azure-pipelines.yml └── 

## 🛠️ Tools and Technologies Used
- **Terraform**: For provisioning infrastructure on Azure.
- **Ansible**: For automated server configuration.
- **Docker**: For containerizing the web application.
- **Azure DevOps**: For CI/CD pipeline setup.

## 🚀 Deployment Steps

### Prerequisites
- Azure account
- Azure DevOps account
- Terraform installed on your local machine
- Ansible installed on your local machine
- Git

Step 1: Clone the Repository
```bash
git clone https://github.com/your-repo/Automated-Deployment-Project.git
cd Automated-Deployment-Project

Step 2: Terraform Setup
Navigate to the Terraform/ directory:
```bash
cd Terraform

Initialize Terraform:
```bash
terraform init

Review the plan:
```bash
terraform plan

Apply the configuration:
```bash
terraform apply

Step 3: Ansible Configuration
Navigate to the Ansible/ directory:
```bash
cd ../Ansible
Edit the inventory file:
Run with your Azure VM's public IP.

Run the playbook:
```bash
ansible-playbook playbook.yml

Step 4: Docker Deployment
Verify the Nginx server is running by accessing the server IP

Step 5: Azure DevOps CI/CD Pipeline
Go to your Azure DevOps account.
Create a new pipeline using the azure-pipelines.yml file.
Set up your service connection for Docker registry if needed.

Run the pipeline to automatically deploy updates on code push.
🗒️ Troubleshooting
Ensure that your Azure VM has the correct firewall rules to allow HTTP traffic (port 80).
If the Ansible playbook fails, verify the server IP and credentials in the inventory file.
