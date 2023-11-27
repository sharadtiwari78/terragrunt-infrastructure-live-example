include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../../infra/modules/codecommit"
}

inputs = {
  repository_name = "Demo"
}