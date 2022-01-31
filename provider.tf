terraform {
  required_version = ">= 0.14"
  // Use experimental feature to allow making object fields optional, cf.
  // https://www.terraform.io/docs/language/expressions/type-constraints.html#experimental-optional-object-type-attributes
  //
  // While there's no guarantee this feature doesn't see breaking changes even
  // in minor releases, I think the upsides to allow users to omit some
  // configurations for additional worker groups (e.g. node state, disk size)
  // outweigh potential changes that we need to make in the future.
  // -SG, 2021-08-02
  experiments = [module_variable_optional_attrs]
  required_providers {
    cloudscale = {
      source  = "cloudscale-ch/cloudscale"
      version = ">= 3.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 2.1"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 2.3"
    }
    gitfile = {
      source  = "igal-s/gitfile"
      version = "1.0.0"
    }
    rancher2 = {
      source  = "rancher/rancher2"
      version = "1.22.2"
    }
  }
}
