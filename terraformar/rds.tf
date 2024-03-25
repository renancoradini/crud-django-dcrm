
resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = [module.vpc.public_subnets[0], module.vpc.public_subnets[1], module.vpc.public_subnets[2]]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "name1db" {
  allocated_storage    = 5
  storage_type         = "gp2"
  instance_class       = "db.t3.micro"
  identifier           = "name1db"
  engine               = "mysql"
  engine_version       = "8.0.34"
  parameter_group_name = "default.mysql8.0"
  db_subnet_group_name = aws_db_subnet_group.default.name
  db_name              = var.namedb
  username             = var.usernameDB
  password             = var.passwordDB

  vpc_security_group_ids = [aws_security_group.mysql.id, aws_security_group.mysql-pub.id]
  publicly_accessible    = true # Only for testing!!!
  skip_final_snapshot    = true
}
