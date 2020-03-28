[![N|Solid](https://image.slidesharecdn.com/awsbosnia6thmeetup-continuousdelivery-170520154936/95/aws-developer-tools-continuous-delivery-5-638.jpg?cb=1495295947)](https://www.linkedin.com/in/alysonfranklin/)

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://www.linkedin.com/in/alysonfranklin/)

Este código foi criado para provisionar os serviços AWS Developer Tools (CodeCommit, CodeBuild & CodePipeline) via Terraform.

##### A imagem acima representa parcialmente o nosso cenário.


#### Passo a passo para execução
```
  $ git clone https://github.com/alysonfranklin/AwsDeveloperTools.git
  $ cd AwsDeveloperTools && terraform init && terraform plan
  $ terraform apply --auto-approve
```
# Aviso!
Caso dê o erro **"Error creating CodeBuild project: InvalidInputException"** ou **"Error putting S3 versioning: OperationAborted: A conflicting conditional operation is currently in progress against this resource. Please try again"**, execute terraform apply --auto-approve novamente. Este erro é intermitente e ainda não parei pra ver se é por causa da versão (0.12.19) do Terraform ou outra coisa.

##### OBS:
Caso seja exibido um erro diferente, provavelmente é porque o bucket já existe em outra conta da AWS. Altere o nome do bucket no arquivo main.tf (s3_tfstate_bucket, s3_logging_bucket_name & codepipeline_artifact_bucket_name).

![N|Solid](https://i.imgur.com/MVVLucg.png)
Depois que configurar seu usuário git para ter acesso ao repositório criado no CodeCommit, copie seu código terraform para o repositório informado e faça o commit. Após o commit, o CodePipeline será acionado automaticamente.

OBS: No repositório a seguir você pode baixar o código completo da infraestrutura e copiar para o repositório repo-elo7-devops_enginner.\
```https://github.com/alysonfranklin/elo7-devops_engineer.git```

#### No repositório mencionado acima eu explico como concluir este CI/CD

