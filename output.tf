output "clone_url_ssh" {
  description = "URL do repositório"
  value       = module.codecommit.clone_url_ssh
}

/*
output "arn_codecommit" {
  value = module.codecommit.terraform_codecommit_repo_arn
}

output "repository_name" {
  value = module.codecommit.terraform_codecommit_repo_name
}

*/
