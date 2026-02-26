variable "aws_profile" {
  description = "AWS Profile"
  type        = string
  default     = "terraform"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

#Create the create-key-pair in AWS first and replace the default value
variable "key_name" {
  description = "terraform-lab-key"
  type        = string
  default     = "<paste key pair name created in AWS console>"
}
