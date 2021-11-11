terraform {
  required_version = ">1.0.0"

  required_providers {
    aws = {
      version = ">3.0.0"
      source  = "hashicorp/aws"
    }

    tls = {
      version = ">=3.1.0"
      source  = "hashicorp/tls"
    }

    local = {
      version = ">=2.1.0"
      source  = "hashicorp/local"
    }

    null = {
      version = ">=3.1.0"
      source  = "hashicorp/null"
    }

  }
}
