# Azure Application Gateway Lab with Terraform

This project creates a simple web application infrastructure on Microsoft Azure using Terraform.

## What Does This Lab Do?

This lab creates the following resources on Azure:

- 1 Resource Group
- 1 Virtual Network with 2 Subnets
- 1 Network Security Group
- 2 Windows Server 2022 Virtual Machines (with IIS)
- 1 Application Gateway

The Application Gateway receives traffic from the internet and sends it to the virtual machines. Each time you refresh the page, you see a different server (Server 1 or Server 2).

## Requirements

Before you start, you need:

- [Terraform](https://developer.hashicorp.com/terraform/downloads) installed
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) installed
- An active Azure subscription

## How to Use

**1. Login to Azure**
```bash
az login
```

**2. Clone this repository**
```bash
git clone https://github.com/YOUR_USERNAME/terraform-tutorials.git
cd terraform-tutorials
```

**3. Create terraform.tfvars file**
```hcl
vm_username = "your-username"
vm_password = "your-password"
```

**4. Run Terraform**
```bash
terraform init
terraform plan
terraform apply
```

**5. Install IIS on Virtual Machines**

After the virtual machines are created, connect to each VM with RDP and run this command in PowerShell:

For VM-1:
```powershell
Install-WindowsFeature -Name Web-Server -IncludeManagementTools
Set-Content -Path "C:\inetpub\wwwroot\Default.htm" -Value "<h1>Server 1</h1>"
```

For VM-2:
```powershell
Install-WindowsFeature -Name Web-Server -IncludeManagementTools
Set-Content -Path "C:\inetpub\wwwroot\Default.htm" -Value "<h1>Server 2</h1>"
```

**6. Test**

After Terraform finishes, run this command to get the Application Gateway IP address:
```bash
terraform output appgw_public_ip
```

Open your browser and go to that IP address. Refresh the page to see Server 1 and Server 2.

**7. Clean Up**

To delete all resources:
```bash
terraform destroy
```

## Important

- Do not push your `terraform.tfvars` file to GitHub. It contains your password.
- The `.gitignore` file already blocks this file.

## What I Learned

- Terraform module structure
- Azure networking (VNet, Subnet, NSG)
- Azure Application Gateway
- How to pass data between modules using outputs