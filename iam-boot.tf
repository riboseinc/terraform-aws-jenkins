resource "aws_iam_role_policy_attachment" "jenkins-instance-boot-addition" {
  role = "${module.ecs.ecs-instance-role-id}"
  policy_arn = "${aws_iam_policy.ec2-instance-boot-role-policy.arn}"
}

resource "aws_iam_role_policy_attachment" "jenkins-slave-boot-addition" {
  role = "${module.ecs-jenkins.slave-iam-instance-profile-role-id}"
  policy_arn = "${aws_iam_policy.ec2-instance-boot-role-policy.arn}"
}

resource "aws_iam_policy" "ec2-instance-boot-role-policy" {
  name = "${var.env}-${var.identifier}-ec2-instance-boot-role-policy"
  policy = "${data.aws_iam_policy_document.ec2-instance-boot-addition-role.json}"
}

data "aws_iam_policy_document" "ec2-instance-boot-addition-role" {

  /* BEGIN used by git pull from other account's CodeCommit repo */
  statement {
    sid = "AllowSourceGitPullDelegation"
    effect = "Allow"
    actions = [ "sts:AssumeRole" ]
    resources = "${var.allow-source-git-pull-roles}"
  }
  /* END used by git pull from other account's CodeCommit repo */

  /* BEGIN used by set ssh account script */
  statement {
    sid = "GetSSHPublicKeysForEC2SSHusers"
    effect = "Allow"
    actions = [
      "iam:ListSSHPublicKeys",
      "iam:GetSSHPublicKey",
      "iam:GetGroup"
    ]
    resources = [ "*" ]
  }
  /* END used by set ssh account script */

  /* BEGIN used by boot scripts */
  statement {
    sid = "InstanceBootScript"
    effect = "Allow"
    actions = [
      "ec2:Describe*"
    ]
    resources = [ "*" ]
  }
  /* END used by boot scripts */
}


