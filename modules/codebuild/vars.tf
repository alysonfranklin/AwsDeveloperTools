variable "codebuild_project_name" {
  description = "Nome do projeto no CodeBuild"
}

/*
variable "codebuild_project_name" {
  description = "Nome do projeto no CodeBuild"
}
*/

variable "s3_logging_bucket_id" {
  description = "ID do bucket S3 para log de acesso"
}

variable "s3_logging_bucket" {
  description = "Nome do bucket S3 para log de acesso"
}

variable "codebuild_iam_role_arn" {
  description = "ARN da role CodeBuild"
}

variable "buildspec" {
  description = "Nome do arquivo buildspect"
}

variable "group_name" {
  description = "Nome do grupo de logs no CloudWatch"
}
