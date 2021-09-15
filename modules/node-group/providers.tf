terraform {
  required_version = ">= 0.14"
  required_providers {
    cloudscale = {
      source = "cloudscale-ch/cloudscale"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}
