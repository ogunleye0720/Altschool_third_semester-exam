terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket = "ogunleye-bucket"
    key = "Eks_Network/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "state_lock"
  }
}

provider "aws" {
  region = "us-east-1"
}

#terraform {
  #backend "s3" {
    #bucket = var.bucket_name 
    #key = var.key 
    #region = "us-east-1"
    #dynamodb_table = var.db_state_lock
  #}
#}