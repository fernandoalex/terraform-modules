provider "aws" {
  region = "us-east-1"
}

module "iam_role_and_policy" {
  source = "../../iam_role_and_policy"
}
