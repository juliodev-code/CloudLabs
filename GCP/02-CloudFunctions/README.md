# Terraform GCP Cloud Functions Diagram


## Instructions for install this lab

1 - Initiate terraform with: terraform init.

2 - Enable the following services in gcloud:
   ```
    gcloud services enable artifactregistry.googleapis.com
    gcloud services enable cloudbuild.googleapis.com
    gcloud services enable cloudfunctions.googleapis.com
   ```

3 - terraform plan and terraform apply

4 - test the function: curl FUNCTION_URL

This diagram shows the relationships between Terraform AWS resources for this lab:

- **Storage Bucket**: Storage for the function archive.
- **Archive file**: This is the data source where the function zip is available and uploaded to storage bucket
- **Google Cloud Function**: Resource where the function instance is created
- **IAM Invoker**: Public role that let the function being executed by any user


```mermaid
graph TD
    STORAGE["Storage Bucket"]
    FILE["Archive file"]
    FUNCTION["Google Cloud Function"]
    ROLE["IAM Invoker"]



    FILE --> STORAGE
    STORAGE --> FUNCTION
    FUNCTION --> ROLE


