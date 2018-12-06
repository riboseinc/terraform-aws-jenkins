/*
 * This role is used to provide the terraform container with ability
 * to run packer.
 */

resource "aws_iam_role" "packer-task-role" {
  name = "${var.env}-${var.identifier}-packer-task-role"
  assume_role_policy = "${data.aws_iam_policy_document.packer-task-assume-policy.json}"
}

data "aws_iam_policy_document" "packer-task-assume-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "packer-task-policy" {
  name = "${var.env}-${var.identifier}-packer-task-policy"
  role = "${aws_iam_role.packer-task-role.id}"
  policy = "${data.aws_iam_policy_document.packer-task-role.json}"
}

data "aws_iam_policy_document" "packer-task-role" {
  statement {
    sid = "AllowJenkinsToDescribeThingsForPacker"
    effect = "Allow"
    actions = [
      "iam:ListInstanceProfiles",
      "ec2:DescribeVpcs",
      "ec2:RevokeSecurityGroupIngress",
      "ecs:*"
    ]
    resources = [ "*" ]
  }

  # https://www.packer.io/docs/builders/amazon.html
  statement {
    sid = "AllowPackerOperations"
    effect = "Allow"
    actions = [
      "ec2:AttachVolume",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:CopyImage",
      "ec2:CreateImage",
      "ec2:CreateKeypair",
      "ec2:CreateSecurityGroup",
      "ec2:CreateSnapshot",
      "ec2:CreateTags",
      "ec2:CreateVolume",
      "ec2:DeleteKeyPair",
      "ec2:DeleteSecurityGroup",
      "ec2:DeleteSnapshot",
      "ec2:DeleteVolume",
      "ec2:DeregisterImage",
      "ec2:DescribeImageAttribute",
      "ec2:DescribeImages",
      "ec2:DescribeInstances",
      "ec2:DescribeRegions",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSnapshots",
      "ec2:DescribeSubnets",
      "ec2:DescribeTags",
      "ec2:DescribeVolumes",
      "ec2:DetachVolume",
      "ec2:GetPasswordData",
      "ec2:ModifyImageAttribute",
      "ec2:ModifyInstanceAttribute",
      "ec2:ModifySnapshotAttribute",
      "ec2:RegisterImage",
      "ec2:RunInstances",
      "ec2:StopInstances",
      "ec2:TerminateInstances"
    ]
    resources = [ "*" ]
  }

  # https://www.packer.io/docs/builders/amazon.html
  # Packer for spot instances
  statement {
    sid = "AllowPackerSpotOperations"
    effect = "Allow"
    actions = [
      "ec2:RequestSpotInstances",
      "ec2:CancelSpotInstanceRequests",
      "ec2:DescribeSpotInstanceRequests",
      "ec2:DescribeSpotPriceHistory"
    ]
    resources = [ "*" ]
  }

  # https://www.packer.io/docs/builders/amazon.html
  # Packer for spot instances
  statement {
    sid = "PackerIAMPassRole"
    effect = "Allow"
    actions = [
      "iam:PassRole"
    ]
    resources = [ "*" ]
  }
}
