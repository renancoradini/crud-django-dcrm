##### ALB - Application Load Balancing #####
##### ALB - Load Balancer #####sudo yum update -y
resource "aws_lb" "loadbalancer" {
  internal           = "false" # internal = true else false
  name               = "denzelrr-alb"
  load_balancer_type = "application"
  subnets            = module.vpc.public_subnets # Subnets públicas
  security_groups    = [aws_security_group.public.id]
}

##### ALB - Target Groups #####


resource "aws_alb_target_group" "alb_public_webservice_target_group" {
  name     = "public-webservice-tg3"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    healthy_threshold   = "3"
    interval            = "15"
    path                = "/"
    protocol            = "HTTP"
    unhealthy_threshold = "10"
    timeout             = "10"
  }

}

resource "aws_lb_listener" "lb_listener-webservice-https" {
  load_balancer_arn = aws_lb.loadbalancer.arn
  port              = "80"
  protocol          = "HTTP"
  #ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn = aws_acm_certificate.appdenzelcert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb_public_webservice_target_group.id
  }
}

#Aplly listeners again when u have ssl certicate
##### ALB - Listeners #####

# resource "aws_lb_listener" "lb_listener-webservice-https-redirect" {
#   load_balancer_arn = aws_lb.loadbalancer.arn
#   port              = "80"
#   protocol          = "HTTP"
#   default_action {
#     type = "redirect"
#     redirect {
#       port        = "443"
#       protocol    = "HTTPS"
#       status_code = "HTTP_301"
#     }
#   }
# }

resource "aws_lb_listener_certificate" "example" {
  listener_arn    = aws_lb_listener.lb_listener-webservice-https.arn
  certificate_arn = aws_acm_certificate.appdenzelcert.arn
}


