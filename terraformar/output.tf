output "name_database" {
  value = aws_db_instance.name1db.endpoint
}

output "dns_alb" {
  value = aws_lb.loadbalancer.dns_name
}
