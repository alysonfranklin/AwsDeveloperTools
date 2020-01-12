# Output TF Plan CodeBuild name to main.tf
output "codebuild_terraform_plan_name" {
  value = var.codebuild_project_terraform_plan_name
}

# Output TF Plan CodeBuild name to main.tf
output "codebuild_terraform_apply_name" {
  value = var.codebuild_project_terraform_apply_name
}
