data "aws_iam_policy_document" "ecs-instance-policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
data "aws_iam_policy_document" "ecsInstanceRole-policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
data "aws_iam_policy_document" "ecs_agent" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_agent" {
  name               = "ecs-agent"
  assume_role_policy = data.aws_iam_policy_document.ecs_agent.json
}

resource "aws_iam_role_policy_attachment" "ecs_agent1" {
  role       = aws_iam_role.ecs_agent.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
  depends_on = [aws_iam_role.ecs_agent]
}

resource "aws_iam_role_policy_attachment" "ecs_agent2" {
  role       = aws_iam_role.ecs_agent.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSAppRunnerServicePolicyForECRAccess"
  depends_on = [aws_iam_role.ecs_agent]
}

resource "aws_iam_role_policy_attachment" "ecs_agent3" {
  role       = aws_iam_role.ecs_agent.name
  policy_arn = aws_iam_policy.ecs_policy_task_test.arn
  depends_on = [aws_iam_role.ecs_agent]
}

resource "aws_iam_role_policy_attachment" "Cloudwatch_FullAccess" {
  role       = aws_iam_role.ecs_agent.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

resource "aws_iam_instance_profile" "ecs_agent" {
  name = "ecs-agent"
  role = aws_iam_role.ecs_agent.name
}

#########

# Creating an IAM policy
resource "aws_iam_policy" "ecs_policy_task_test" {
  name = "ecs_policy_task_test"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "ssm:GetParameters"
        ]
        Resource = aws_ssm_parameter.testeEnv3.arn
      }
    ]
  })
}

# Creating an IAM role
resource "aws_iam_role" "ecs_role_task_test" {
  name = "ecs_role_task_test"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach the IAM policy to the IAM role
resource "aws_iam_policy_attachment" "ecs_role_policy_attacnhement" {
  name       = "Policy Attachement"
  policy_arn = aws_iam_policy.ecs_policy_task_test.arn
  roles      = [aws_iam_role.ecs_role_task_test.name]
}


resource "aws_iam_role_policy_attachment" "ecs_role_policy_attacnhement2" {
  role       = aws_iam_role.ecs_role_task_test.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSAppRunnerServicePolicyForECRAccess"
  depends_on = [aws_iam_role.ecs_agent]
}

resource "aws_iam_role_policy_attachment" "ecs_role_policy_attacnhement3" {
  role       = aws_iam_role.ecs_role_task_test.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
  depends_on = [aws_iam_role.ecs_agent]
}

#Lembrar de add esta policies ao ecs_agent
#AmazonSSMFullAccess
