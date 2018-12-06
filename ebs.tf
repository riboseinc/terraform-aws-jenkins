data "aws_ebs_volume" "jenkins_home" {
  most_recent = true
  filter {
    name = "volume-type"
    values = ["gp2"]
  }
  filter {
    name = "tag:EBS_JENKINS_ENV"
    values = ["${var.name}"]
  }
}
