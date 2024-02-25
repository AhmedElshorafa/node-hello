resource "aws_lb" "my_alb" {
  name                       = var.alb-name
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = var.alb-sg # Replace with your security group IDs
  subnets                    = var.alb-subnets
  enable_deletion_protection = false

  enable_http2 = true

  enable_cross_zone_load_balancing = true
}
