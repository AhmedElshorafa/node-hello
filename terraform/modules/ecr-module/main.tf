resource "aws_ecr_repository" "ecr-repo" {
  name = var.repo_name
}