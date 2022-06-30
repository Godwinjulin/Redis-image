locals {
  # Common tags to be assigned to all resources
  common_tags = {
    Service     = "elitesolutionIT"
    Owner       = "elitesolutionIT LLC"
    Department  = "devOps engineering"
    ManagedWith = "terraform"
    Environment = "dev"
    casecode    = "esc300"
  }

  network = {
    Department  = "devOps engineering"
    ManagedWith = "terraform"
    Environment = "dev"
    Network     = "main elite network mainframe"
  }
}