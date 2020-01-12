# Criando repositório CodeCommit
resource "aws_codecommit_repository" "repo" {
  repository_name = var.repository_name
  description     = "CodeCommit Terraform"
}


# ARN do CodeCommit - Enviando output para o main.tf
output "terraform_codecommit_repo_arn" {
  value = aws_codecommit_repository.repo.arn
}

# Nome do repositório
output "terraform_codecommit_repo_name" {
  value = var.repository_name
}

output "clone_url_ssh" {
  description = "URL for cloning the repository with SSH"
  value = aws_codecommit_repository.repo.clone_url_ssh
}
