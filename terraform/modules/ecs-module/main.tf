resource "aws_ecs_cluster" "ecs-cluster" {
  name = var.ecs-cluster-name
}

resource "aws_ecs_cluster_capacity_providers" "ecs-cap-provider" {
  cluster_name = aws_ecs_cluster.ecs-cluster.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}