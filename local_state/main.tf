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

# Data Source Block

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["Amazon Linux*"]
  }
  filter {
    name = "FreeTierEligible"
    values = ["true"]
  }
}


# Resource blocks
resource "aws_instance" "tf_first_instance" {
  ami = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}
