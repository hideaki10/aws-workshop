provider "aws" {
  region = "ap-northeast-1"  # 东京区域
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"  # 指定AWS provider的版本
    }
  }
} 