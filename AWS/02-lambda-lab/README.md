# Terraform EC2 AWS Diagram


## Instructions for install this lab

1 - Make sure to create the aws profile in your pc for terraform and use it in providers section in this project.

2 - Make sure to assign permission to terraform user to manage Lamda functions.

3 - Initiate terraform with: terraform init

4 - Revise the configurations: terraform plan

5 - Apply the change to AWS: terraform apply

6 - Revise your function using the AWS CLI:

```
aws lambda invoke \
  --function-name terraform-demo-lambda \
  --payload '{}' \
  response.json

  cat response.json
```



This diagram shows the relationships between Terraform AWS resources for this lab:

- **IAM Role(aws_iam_role)**: Created for manage permission to lambda function service.
- **Role Policy (aws_iam_role_policy_attachment)**: Assignment of AWSLambdaBasicExecutionRole prebuilt AWS policy to IAM role created.
- **ZIP Package(archive_file)**: Needed Packed code to be execute as lambda function
- **Lambda expression(aws_lambda_function)**: Lambda resource instance creation to serve the function 

```mermaid
graph TD
    ROLE["IAM Role"]
    POLICY["Role Policy"]
    CODE["ZIP Package(archive_file)"]
    LAMBDA["Lambda expression"]


    ROLE --> POLICY
    ROLE --> LAMBDA
    CODE --> LAMBDA


