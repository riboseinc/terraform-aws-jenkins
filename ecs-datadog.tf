module "ecs-datadog" {
  source = "github.com/riboseinc/terraform-aws-ecs-datadog"

  datadog-api-key = "${var.datadog-api-key}"
  datadog-extra-config = "${var.datadog-extra-config}"
  env = "${var.env}"
  identifier = "${var.identifier}"
  ecs-cluster-id = "${module.ecs.ecs-cluster-id}"
}
