provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "tf_state" {
  bucket = "terraform-state-s3-mhaluska"
  lifecycle {
    prevent_destroy = true
  }
  tags = {
    Name = "terraform-state"
  }
}

resource "aws_dynamodb_table" "tf_lock" {
  name         = "mhaluska-S3-state"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}