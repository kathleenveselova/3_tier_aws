resource "aws_db_subnet_group" "example" {
  name       = "example-db-subnet-group"
  subnet_ids = aws_subnet.private_subnets.*.id
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

  
  tags = {
    Name = "example-rds-cluster"
  }
}

resource "aws_rds_cluster_instance" "writer" {
  count                      = 1
  identifier                 = "example-writer-${count.index}"
  cluster_identifier         = aws_rds_cluster.default.id
  instance_class             = "db.r5.large"
  engine                     = "aurora-mysql"
  publicly_accessible        = false
  tags = {
    Name = "example-writer-${count.index}"
  }
}

resource "aws_rds_cluster_instance" "reader" {
  count                      = 3
  identifier                 = "example-reader-${count.index+1}"
  cluster_identifier         = aws_rds_cluster.default.id
  instance_class             = "db.r5.large"
  engine                     = "aurora-mysql"
  publicly_accessible        = false
  tags = {
    Name = "example-reader-${count.index}"
  }
}
