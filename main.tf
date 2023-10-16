terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "high_jvm_heap_usage_in_elasticsearch" {
  source    = "./modules/high_jvm_heap_usage_in_elasticsearch"

  providers = {
    shoreline = shoreline
  }
}