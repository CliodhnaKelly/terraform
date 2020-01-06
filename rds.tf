
provider "aws" {
  region = "us-east-1"
}

//resource "aws_rds_cluster_instance" "postgres-instance" {
//  identifier         = "postgres"
//  cluster_identifier = "${aws_rds_cluster.postgres.id}"
//  instance_class     = "db.r4.large"
//  engine_version     = "9.6.6"
//  engine             = "aurora-postgresql"
//  publicly_accessible = true
//}
//
//resource "aws_rds_cluster" "postgres" {
//  cluster_identifier      = "postgres-cluster"
//  engine                  = "aurora-postgresql"
//  availability_zones      = ["us-east-1a", "us-east-1b"]
//  database_name           = "spiderdb"
//  master_username         = "username1"
//  master_password         = "password1"
//  backup_retention_period = 5
//  preferred_backup_window = "07:00-09:00"
//  engine_version          = "9.6.6"
//}

resource "aws_db_instance" "default" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "10"
  instance_class       = "db.t2.micro"
  name                 = "spiderdb"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.postgres10"
  max_allocated_storage = 60
  port = 5432
  publicly_accessible = true
}