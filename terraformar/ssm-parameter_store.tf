resource "aws_ssm_parameter" "testeEnv3" {
  name  = "testeEnv3"
  type  = "String"
  value = "TesteEnv3 - Terraform - SSM Parameter Store"
}
