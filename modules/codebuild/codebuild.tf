# Criando projeto CodeBuild para o Terraform plan
resource "aws_codebuild_project" "codebuild_project_terraform_plan" {
  name          = var.codebuild_project_terraform_plan_name
  description   = "CodeBuild - Projeto Terraform plan"
  build_timeout = "5"
  service_role  = var.codebuild_iam_role_arn

  artifacts {
    type = "CODEPIPELINE"
  }

  cache {
    type     = "S3"
    location = var.s3_logging_bucket
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:2.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true

    # Variáveis de ambiente
    environment_variable {
      name  = "TERRAFORM_VERSION"
      value = "0.12.17"
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "codebuild"
      stream_name = "log-stream"
    }

    s3_logs {
      status   = "ENABLED"
      location = "${var.s3_logging_bucket_id}/${var.codebuild_project_terraform_plan_name}/build-log"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec_terraform_plan.yml"
  }

  tags = {
    Terraform = "true"
  }
}


# Criando projeto CodeBuild para o Terraform apply
resource "aws_codebuild_project" "codebuild_project_terraform_apply" {
  name          = var.codebuild_project_terraform_apply_name
  description   = "CodeBuild - Projeto Terraform apply"
  build_timeout = "5"
  service_role  = var.codebuild_iam_role_arn

  artifacts {
    type = "CODEPIPELINE"
  }

  cache {
    type     = "S3"
    location = var.s3_logging_bucket
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:2.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true

    environment_variable {
      name  = "TERRAFORM_VERSION"
      value = "0.12.17"
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "codebuild"
      stream_name = "log-stream"
    }

    s3_logs {
      status   = "ENABLED"
      location = "${var.s3_logging_bucket_id}/${var.codebuild_project_terraform_apply_name}/build-log"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec_terraform_apply.yml"
  }

  tags = {
    Terraform = "true"
  }
}
