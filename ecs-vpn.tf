module "ecs" {
  source = "github.com/riboseinc/terraform-aws-ecs-vpn"

  name = "${var.name}"
  aws-region = "${var.aws-region}"
  aws-ami-account-id = "${var.aws-ami-account-id}"
  ebs-id = "${data.aws_ebs_volume.jenkins_home.id}"
  vpc_cidr = "${var.vpc_cidr}"
  instance_type_vpn = "${var.instance_type_vpn}"
  dns-public-name = "${var.dns-public-name}"
  dns-internal-name = "${var.dns-internal-name}"
  file-ssl-cert-body = "${var.file-ssl-cert-body}"
  file-ssl-cert-chain = "${var.file-ssl-cert-chain}"
  file-ssl-cert-key = "${var.file-ssl-cert-key}"
  bootstrap = "${var.bootstrap}"
  instance_type = "${var.instance_type}"
  env = "${var.env}"
  identifier = "${var.identifier}"
  ports = "${var.ports}"
  ami-ecs = "${var.ami-ecs}"
  ami-vpn = "${var.ami-vpn}"
  public_key = "${var.public_key}"
  slave_public_key = "${var.slave_public_key}"
  ssh-ip = "${var.ssh-ip}"
  elb-int-name = "${module.ecs-jenkins.elb-int-name}"
  dyn-iam-s3-bucket = "${var.dyn-iam-s3-bucket}"
  dyn-access-iam-group-name = "${var.dyn-access-iam-group-name}"
  allow-vpn-git-pull-roles = "${var.allow-vpn-git-pull-roles}"
  infrastructure_release = "${var.infrastructure_release}"
  vpn_cidr_block = "${var.vpn_cidr_block}"
}
