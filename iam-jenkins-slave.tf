resource "aws_iam_role_policy_attachment" "jenkins-slave-instance" {
  role = "${module.ecs-jenkins.slave-iam-instance-profile-role-id}"
  policy_arn = "${aws_iam_policy.jenkins-slave-instance-role-policy.arn}"
}

resource "aws_iam_policy" "jenkins-slave-instance-role-policy" {
  name = "${var.env}-${var.identifier}-jenkins-slave-instance-role-policy"
  policy = "${data.aws_iam_policy_document.jenkins-slave-instance-role.json}"
}


data "aws_iam_policy_document" "jenkins-slave-instance-role" {

  statement {
    sid = "AllowJenkinsSlave"
    effect = "Allow"
    actions = [

      /*
        Used for describe-instances in scripts to find out instance's own TAGs
       */
      "ec2:DescribeInstances",

      /* Download ECR images BEGIN */
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      /* Download ECR images END */

      /* Pushing ECR images BEGIN */
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:PutImage",
      /* Pushing ECR images END */
    ]
    resources = [ "*" ]
  }

}
