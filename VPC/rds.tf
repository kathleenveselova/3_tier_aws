/*
resource "aws_db_subnet_group" "example" {
  name        = "my-db-subnet-group"
  description = "Subnet group for my RDS instance"
  subnet_ids  = [
    aws_subnet.private_subnet1.id,
    aws_subnet.private_subnet2.id,
    aws_subnet.private_subnet3.id
  ]
}


resource "random_password" "db_master_password" {
  length = 16
  special = true
}

resource "aws_rds_cluster" "default" {
  cluster_identifier      = "aurora-cluster-demo"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.07.2"
  database_name           = "mydb"
  master_username         = "foo"
  master_password         = random_password.db_master_password.result
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
  skip_final_snapshot       = true
  vpc_security_group_ids   = [aws_security_group.allow_RDS_sg.id]
  db_subnet_group_name = aws_db_subnet_group.example.name
  availability_zones = data.aws_availability_zones.available.names
  
  tags = {
    Name = "example-rds-cluster"
  }
}

resource "aws_rds_cluster_instance" "writer" {
  identifier                 = "example-writer"
  availability_zone       = data.aws_availability_zones.available.names[0]
  cluster_identifier         = aws_rds_cluster.default.id
  instance_class             = "db.r5.large"
  engine                     = "aurora-mysql"
  publicly_accessible        = false
  tags = {
    Name = "example-writer"
  }
}


resource "aws_rds_cluster_instance" "reader1" {
  identifier                 = "example-reader-1"
  availability_zone       = data.aws_availability_zones.available.names[0]
  cluster_identifier         = aws_rds_cluster.default.id
  instance_class             = "db.r5.large"
  engine                     = "aurora-mysql"
  publicly_accessible        = false
  tags = {
    Name = "example-reader-1"
  }
}

resource "aws_rds_cluster_instance" "reader2" {
  identifier                 = "example-reader-2"
  availability_zone       = data.aws_availability_zones.available.names[1]
  cluster_identifier         = aws_rds_cluster.default.id
  instance_class             = "db.r5.large"
  engine                     = "aurora-mysql"
  publicly_accessible        = false
  tags = {
    Name = "example-reader-2"
  }
}

resource "aws_rds_cluster_instance" "reader3" {
  identifier                 = "example-reader-3"
  availability_zone       = data.aws_availability_zones.available.names[2]
  cluster_identifier         = aws_rds_cluster.default.id
  instance_class             = "db.r5.large"
  engine                     = "aurora-mysql"
  publicly_accessible        = false
  tags = {
    Name = "example-reader-3"
  }
}

*/