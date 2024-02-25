variable "alb-name" {
  type        = string
  default     = "prod-lb"
}
variable "alb-sg" {
  type        = list(string)
}
variable "alb-subnets" {
  type        = list(string)
}