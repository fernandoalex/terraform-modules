# Template Role Policy
# Template IAM Policy
variable default_role_policy {
  default = "templates/default_role_policy.json"
}

variable default_iam_policy {
  default = "templates/default_iam_policy.json"
}

data "template_file" "role_policy" {
  template = "${var.role_policy == "" ? file("${path.module}/templates/default_role_policy.json") : var.role_policy}"
}

data "template_file" "iam_policy" {
  template = "${var.iam_policy == "" ? file("${path.module}/templates/default_iam_policy.json")  : var.iam_policy}"
}

resource "aws_iam_role" "iam_role" {
  name = "iam_for_lambda"

  assume_role_policy = "${data.template_file.role_policy.rendered}"
}

resource "aws_iam_policy" "iam_policy" {
  name        = "test_policy"
  path        = "/"
  description = "My test policy"

  policy = "${data.template_file.iam_policy.rendered}"
}

resource "aws_iam_policy_attachment" "attach_policy_role" {
  name       = "Policy Attachment"
  roles      = ["${aws_iam_role.iam_role.name}"]
  policy_arn = "${aws_iam_policy.iam_policy.arn}"
}
