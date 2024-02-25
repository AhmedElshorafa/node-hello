resource "aws_ecs_task_definition" "my_task_definition" {
  family                   = var.td_name
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.td-cpu
  memory                   = var.td-memory

  container_definitions = var.td-file
  execution_role_arn = "arn:aws:iam::013859417906:role/ecsTaskExecutionRole"
  task_role_arn      = "arn:aws:iam::013859417906:role/ecsTaskExecutionRole"
}

resource "aws_lb_target_group" "my_target_group" {
  name        = var.td_name
  port        = var.td-port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc-id
  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = var.td-port
    healthy_threshold   = 2
    unhealthy_threshold = 5
    timeout             = 30
    interval            = 60
  }
}

resource "aws_lb_listener" "my_listener" {
  
  load_balancer_arn = var.my-alb-arn
  port = 80
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_target_group.arn
  }
}

# ECS Service
resource "aws_ecs_service" "my_ecs_service" {
  name            = var.td_name
  cluster         = var.ecs-cluster-id
  task_definition = aws_ecs_task_definition.my_task_definition.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets = var.service-subnets # Replace with your subnet IDs
    security_groups = var.service-sec-group # Replace with your security group IDs
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.my_target_group.arn
    container_name   = var.td_name
    container_port   = var.td-port
  }

}

