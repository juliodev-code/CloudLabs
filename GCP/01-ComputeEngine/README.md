# Terraform Compute Engine GCP Diagram


## Instructions for install this lab

1 - Initiate terraform with: terraform init
2 - In your terraform service account add the following roles in IAM: roles/compute.admin, roles/iam.serviceAccountUser
3 - Create your terraform.tfvars and add your project id where you want to insert your vm: project_id = "<projectid>"
4 - terraform plan and terraform apply
5 - http://VM_externalIP

This diagram shows the relationships between Terraform AWS resources for this lab:

- **Firewall rules (80,22)**: Rules for be applied into Compute Engine instance by tags
- **Compute Instance**: Compute Engine instance that contain a vm image mounted


