# Creates RDS Instance 
resource "aws_db_instance" "mysql" {
  identifier             = "roboshop-${var.ENV}-mysql"
  allocated_storage      = var.MYSQL_STORAGE
  engine                 = "mysql"
  engine_version         = var.MYSQL_ENGINE_VERSION
  instance_class         = var.MYSQL_INSTANCE_TYPE
  username               = "admin1"
  password               = "roboshop1"
  parameter_group_name   = aws_db_parameter_group.default.name
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.mysql.name
  vpc_security_group_ids = [aws_security_group.allows_mysql.id]
}

resource "aws_db_subnet_group" "mysql" {
  name       = "roboshop-${var.ENV}-mysql-subnet-group"
  subnet_ids = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_IDS 
  tags = {
    Name = "roboshop-${var.ENV}-mysql-subnet-group"
  }
}

resource "aws_db_parameter_group" "default" {
  name   = "roboshop-${var.ENV}-mysql-pg"
  family = "mysql5.7"
}


