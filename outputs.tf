output "packer-iam-role-arn" {
  value = "${aws_iam_role.packer-task-role.arn}"
}

output "r53-public-zone-zoneid" {
  value = "${module.ecs.r53-public-zone-zoneid}"
}

output "r53-public-zone-id" {
  value = "${module.ecs.r53-public-zone-id}"
}

output "r53-public-zone-name" {
  value = "${module.ecs.r53-public-zone-name}"
}

output "r53-public-ns" {
  value = "${module.ecs.r53-public-ns}"
}

output "ecs-cluster-id" {
  value = "${module.ecs.ecs-cluster-id}"
}