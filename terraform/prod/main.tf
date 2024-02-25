module "network" {
  source = "../modules/network-module/"

  region                = "eu-west-1"
  env_name              = "prod"
  VPC_CIDR              = "172.10.0.0/16"
  public_subnets_names  = ["pub-sub-stg-01", "pub-sub-stg-02", "pub-sub-stg-03"]
  public_subnets_cidr   = ["172.10.1.0/24", "172.10.2.0/24", "172.10.3.0/24"]
  private_subnets_names = ["prv-sub-stg-01", "prv-sub-stg-02", "prv-sub-stg-03"]
  private_subnets_cidr  = ["172.10.4.0/24", "172.10.5.0/24", "172.10.6.0/24"]

}

module "security-groups" {
  source = "../modules/sec-groups-module"
  vpc_id = module.network.vpc-id
}

module "ecr" {
  source    = "../modules/ecr-module"
  repo_name = "web-app"
}

module "ecs" {
  source           = "../modules/ecs-module"
  ecs-cluster-name = "web-app"
}

module "alb" {
  source      = "../modules/alb-module"
  alb-name    = "app-ecs-alb"
  alb-sg      = module.security-groups.alb-security-group
  alb-subnets = module.network.public-subnets
}

module "app-service" {
  source            = "../modules/ecs-service-module"
  td_name           = "web-app"
  td-cpu            = 512
  td-memory         = 2048
  td-port           = "3000"
  vpc-id            = module.network.vpc-id
  my-alb-arn        = module.alb.alb-arn
  td-file           = file("./task-definitions/app.json")
  ecs-cluster-id    = module.ecs.ecs-cluster-id
  service-subnets   = module.network.private-subnets
  service-sec-group = module.security-groups.ecs-task-security-group
}
