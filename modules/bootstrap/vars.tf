variable "s3_tfstate_bucket" {
  description = "Nome do bucket S3 usado para armazenamento do estado Terraform"
}

variable "s3_logging_bucket_name" {
  description = "Nome do bucket S3 a ser usado para o log de acesso"
}

variable "codebuild_iam_role_name" {
  description = "Nome da role do IAM utilizada pelo CodeBuild"
}

variable "codebuild_iam_role_policy_name" {
  description = "Nome da política do IAM usada pelo CodeBuild"
}

variable "terraform_codecommit_repo_arn" {
  description = "ARN do CodeCommit"
}

variable "tf_codepipeline_artifact_bucket_arn" {
  description = "ARN de artefato Codepipeline/s3"
}
