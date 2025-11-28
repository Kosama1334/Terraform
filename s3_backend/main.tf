terraform {

  required_version = ">= 1.2"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.92"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

# resource block for S3 bucket

resource "aws_s3_bucket" "tf_state_backend" {
  bucket = var.bucket_name

  #Enable versioning
  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

#resource block for DynamoDB table

resource "aws_dynamodb_table" "tf_state_table" {
  name = tf_backend_state_dynamo
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  billing_mode = "PAY_PER_REQUEST"
}


#resource block for an EC2 instance

resource "aws_instance" "app-server" {
  instance_type = "t3.micro"
  tags = {
    Name = "app-server"
  }
}
