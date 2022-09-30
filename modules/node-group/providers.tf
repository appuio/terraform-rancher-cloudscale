terraform {
  required_version = ">= 1.3.0"
  required_providers {
    cloudscale = {
      source = "cloudscale-ch/cloudscale"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}
