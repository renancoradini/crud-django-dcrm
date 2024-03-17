##### ECS-Cluster #####
resource "aws_ecs_cluster" "cluster" {
  name = "ecs-denzelrr-cluster"
}

resource "aws_ecs_cluster_capacity_providers" "cluster-cp-association" {
  cluster_name       = aws_ecs_cluster.cluster.name
  capacity_providers = [aws_ecs_capacity_provider.capacity-provider.name]

  default_capacity_provider_strategy {
    base              = 2
    weight            = 0
    capacity_provider = aws_ecs_capacity_provider.capacity-provider.name
  }
}

##### AWS ECS-TASK #####

resource "aws_ecs_task_definition" "task_definition" {
  container_definitions    = data.template_file.task_definition_json.rendered # task defination json file location
  family                   = "denzelrr-task-defination-webservice"            # task name
  network_mode             = "host"                                           #was bridge before # network mode awsvpc, brigde
  memory                   = "256"
  cpu                      = "256"
  requires_compatibilities = ["EC2"] # Fargate or EC2
  execution_role_arn       = aws_iam_role.ecs_role_task_test.arn
}

data "template_file" "task_definition_json" {
  template = file("task_definition.json")

  vars = {
    CONTAINER_IMAGE = var.container_image,
    SSM_TERRAFORM   = aws_ssm_parameter.testeEnv3.arn
  }
}

##### AWS ECS-SERVICE #####
resource "aws_ecs_service" "service-webservice" {
  cluster       = aws_ecs_cluster.cluster.id # ECS Cluster ID
  desired_count = 2                          # Number of tasks running
  #launch_type                        = "EC2"                                       # Cluster type [ECS OR FARGATE]
  name                               = "denzelrr-webservice-service-webservice"    # Name of service
  task_definition                    = aws_ecs_task_definition.task_definition.arn # Attach the task to service
  deployment_minimum_healthy_percent = 100
  health_check_grace_period_seconds  = 30
  load_balancer {
    container_name   = "denzelrr-webservice"
    container_port   = "80"
    target_group_arn = aws_alb_target_group.alb_public_webservice_target_group.arn
  }

  lifecycle {
    ignore_changes = [desired_count, task_definition]
  }

  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.capacity-provider.name
    base              = 2
    weight            = 1
  }

  ordered_placement_strategy {
    type  = "spread"
    field = "host"
  }

}

resource "aws_ecs_capacity_provider" "capacity-provider" {
  name = "capacity-provider-denzel"

  auto_scaling_group_provider {
    auto_scaling_group_arn = aws_autoscaling_group.tf2.arn
    # managed_termination_protection = "ENABLED"

    managed_scaling {
      status          = "ENABLED"
      target_capacity = 90 #50
    }
  }
}
