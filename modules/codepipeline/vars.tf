variable "codepipeline_artifact_bucket_name" {
  description = "Nome do repositório TF CodePipeline S3 para artefatos"
}

variable "codepipeline_role_name" {
  description = "Nome da role que o CodePipeline irá usar com Terraform"
}

variable "codepipeline_role_policy_name" {
  description = "Nome da política a ser usada pelo CodePipeline/Terraform"
}

variable "codepipeline_name" {
  description = "Nome do projeto no CodePipeline"
}

variable "terraform_codecommit_repo_name" {
  description = "Nome do repositório CodeCommit"
}

variable "codebuild_terraform_plan_name" {
  description = "Nome do projeto no CodeBuild"
}

variable "codebuild_terraform_apply_name" {
  description = "Nome do projeto no CodeBuild"
}
