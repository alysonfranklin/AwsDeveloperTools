// Requer versão igual ou superior à 0.12.16

// Descomente o bloco abaixo depois que o AWS DeveloperTools
// for provisionado e execute terraform apply --auto-aprove

/*
terraform {
  backend "s3" {
    bucket         = "elo7-devops-engineer"
    key            = "terraform/developer_tools-elo7/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "developer_tools-elo7-terraform-locking"
    encrypt        = true
  }
}
*/

// Provider
provider "aws" {
  region = "us-east-1"
 #version = "~> 2.36.0"

}

data "aws_caller_identity" "current" {
}

resource "aws_ssm_parameter" "account_id" {
  name  = "account_id"
  description = "ID da conta AWS criptografado usando chave KMS default"
  type  = "SecureString"
  value = data.aws_caller_identity.current.account_id

  tags = {
    Name = "Account_ID"
  }
}


// Cria uma tabela no DynamoDB para lock do estado do terraform
module "dynamodb" {
  source               = "./modules/dynamodb"
  dynamo_db_table_name = "developer_tools-elo7-terraform-locking"
}

// Cria um bucket S3 para o estado do Terraform
// Se o bucket não existir, ele cria um novo. Se existir, ele usa o bucket existente
module "bootstrap" {
  source                              = "./modules/bootstrap"
  s3_tfstate_bucket                   = "elo7-devops-engineer"
  s3_logging_bucket_name              = "elo7-devops-engineer"
  codebuild_iam_role_name             = "CodeBuildIamRole"
  codebuild_iam_role_policy_name      = "CodeBuildIamRolePolicy"
  terraform_codecommit_repo_arn       = module.codecommit.terraform_codecommit_repo_arn
  tf_codepipeline_artifact_bucket_arn = module.codepipeline.tf_codepipeline_artifact_bucket_arn
}

// CodeCommit
module "codecommit" {
  source          = "./modules/codecommit"
  repository_name = "repo-elo7-devops_engineer"
}

// CodeBuild Terraform plan 
module "codebuild-terraform_plan" {
  source                 = "./modules/codebuild"
  codebuild_project_name = "TerraformPlan"
  buildspec              = "buildspec_terraform_plan.yml"
  group_name             = "codebuild/terraform"
  s3_logging_bucket_id   = module.bootstrap.s3_logging_bucket_id
  codebuild_iam_role_arn = module.bootstrap.codebuild_iam_role_arn
  s3_logging_bucket      = module.bootstrap.s3_logging_bucket
}

// CodeBuild Terraform apply
module "codebuild-terraform_apply" {
  source                 = "./modules/codebuild"
  codebuild_project_name = "TerraformApply"
  buildspec              = "buildspec_terraform_apply.yml"
  group_name             = "codebuild/terraform"
  s3_logging_bucket_id   = module.bootstrap.s3_logging_bucket_id
  codebuild_iam_role_arn = module.bootstrap.codebuild_iam_role_arn
  s3_logging_bucket      = module.bootstrap.s3_logging_bucket
}

// CodePipeline
module "codepipeline" {
  source                            = "./modules/codepipeline"
  codepipeline_name                 = "TerraformCodePipeline"
  codepipeline_artifact_bucket_name = "elo7-devops-engineer"
  codepipeline_role_name            = "TerraformCodePipelineIamRole"
  codepipeline_role_policy_name     = "TerraformCodePipelineIamRolePolicy"
  terraform_codecommit_repo_name    = module.codecommit.terraform_codecommit_repo_name
  codebuild_terraform_plan_name     = module.codebuild-terraform_plan.codebuild_terraform_plan_name
  codebuild_terraform_apply_name    = module.codebuild-terraform_apply.codebuild_terraform_apply_name
}
