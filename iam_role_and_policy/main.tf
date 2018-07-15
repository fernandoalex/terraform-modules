data "template_file" "role_policy" {
  template = "${var.role_policy == "" ? file("${path.module}/templates/default_role_policy.json") : var.role_policy}"
}

data "template_file" "iam_policy" {
  template = "${var.iam_policy == "" ? file("${path.module}/templates/default_iam_policy.json")  : var.iam_policy}"
}

resource "aws_iam_role" "iam_role" {
  name = "${var.iam_role_name}"

  assume_role_policy = "${data.template_file.role_policy.rendered}"
}

resource "aws_iam_policy" "iam_policy" {
  name        = "${var.iam_policy_name}"
  path        = "/"
  description = "some description"

  policy = "${data.template_file.iam_policy.rendered}"
}

resource "aws_iam_policy_attachment" "attach_policy_role" {
  name       = "Policy Attachment"
  roles      = ["${aws_iam_role.iam_role.name}"]
  policy_arn = "${aws_iam_policy.iam_policy.arn}"
}
