output "clone_url_ssh" {
  description = "URL for cloning the repository with SSH"
  value       = module.codecommit.clone_url_ssh
}

output "clone_url_ssh-application" {
  description = "URL for cloning the repository with SSH"
  value       = module.codecommit-application.clone_url_ssh
}

/*
output "arn_codecommit" {
  value = module.codecommit.terraform_codecommit_repo_arn
}

output "repository_name" {
  value = module.codecommit.terraform_codecommit_repo_name
}

*/
