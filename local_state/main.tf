# Terraform Block
terraform {
  required_version = ">= 1.2"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.92"
    }
  }
}

#Provider Block
provider "aws" {
  region = "us-east-1"
}

# Resource blocks
resource "aws_instance" "tf_first_instance" {
  ami = "ami-0fa3fe0fa7920f68e"
  instance_type = "t2.micro"

  tags = {
    Name = "TF_first_instance"
  }
}
