resource "aws_iam_role_policy_attachment" "jenkins-instance-addition" {
  role = "${module.ecs.ecs-instance-role-id}"
  policy_arn = "${aws_iam_policy.jenkins-instance-addition-role-policy.arn}"
}

resource "aws_iam_policy" "jenkins-instance-addition-role-policy" {
  name = "${var.env}-${var.identifier}-jenkins-instance-addition-role-policy"
  policy = "${data.aws_iam_policy_document.jenkins-instance-addition-role.json}"
}

data "aws_iam_policy_document" "jenkins-instance-addition-role" {

  /* BEGIN used by Jenkins mount volume */
  statement {
    sid = "JenkinsEBSdisk"
    effect = "Allow"
    actions = [
      "ec2:AttachVolume",
      "ec2:DetachVolume"
    ]
    resources = [ "${var.arn_path}:volume/${data.aws_ebs_volume.jenkins_home.id}" ]
  }

  statement {
    sid = "JenkinsEBSinstance"
    effect = "Allow"
    actions = [
      "ec2:AttachVolume",
      "ec2:DetachVolume"
    ]
    resources = [ "${var.arn_path}:instance/*" ]
  }

  statement {
    sid = "JenkinsEBSDescribeVolumes"
    effect = "Allow"
    actions = [
      "ec2:DescribeVolumes"
    ]
    resources = [ "*" ]
  }
  /* END used by Jenkins mount volume */

}

