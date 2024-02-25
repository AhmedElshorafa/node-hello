variable "td_name" {
  type = string
  default= "web-app"
}
variable "td-cpu" {
  type        = number
}
variable "td-memory" {
  type        = number
}
variable "td-port" {
  type        = string
  default     = "80"
}
variable "vpc-id" {
  type        = string
  default     = "app"
}

variable "td-file" {
  type        = string
  default     = "test"
}
variable "ecs-cluster-id" {
  type        = string
  default     = "app"
}
variable "service-subnets" {
  type        = list(string)
}
variable "service-sec-group" {
  type        = list(string)
}
variable "my-alb-arn" {
  type=string
  default="app"
}

