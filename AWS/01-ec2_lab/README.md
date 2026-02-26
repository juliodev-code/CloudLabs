# Terraform EC2 AWS Diagram


## Instructions for install this lab

1 - Initiate terraform with: terraform init
2 - In AWS console create a EC2 pair key for be used when EC2 resource is created: https://docs.aws.amazon.com/batch/latest/userguide/create-a-key-pair.html#:~:text=AWS%20uses%20public%2Dkey%20cryptography,the%20Amazon%20EC2%20User%20Guide and download the private key in a safe location.

3 - Replace the key created in variables/key_name - line 20
4 - type terraform plan and proceed with terraform apply
5 - Access EC2 virtual server using: ssh -i your-key.pem ec2-user@<PUBLIC_IP>

This diagram shows the relationships between Terraform AWS resources for this lab:

- **VPC**: Private network (City)
- **Subnet**: IP range inside VPC (Colony)
- **Internet Gateway**: Gateway to internet (Main Access)
- **Route Table**: Routes traffic (Street Name)
- **Security Group**: Firewall rules 
- **EC2 Instance**: Server (Home)

```mermaid
graph TD
    VPC["VPC (Ciudad)"]
    SUBNET["Subnet (Colonia)"]
    IGW["Internet Gateway (Puerta)"]
    RT["Route Table (Calle)"]
    RTASSOC["Route Table Association"]
    SG["Security Group (Firewall)"]
    EC2["EC2 Instance (Casa)"]

    VPC --> SUBNET
    VPC --> IGW
    VPC --> SG
    SUBNET --> RTASSOC
    RT --> RTASSOC
    SUBNET --> EC2
    SG --> EC2
    IGW --> RT


