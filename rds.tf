
provider "aws" {
  region = "us-east-1"
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 2
  identifier         = "aurora-cluster-demo-${count.index}"
  cluster_identifier = "${aws_rds_cluster.postgresql.id}"
  instance_class     = "db.r4.large"
}

resource "aws_rds_cluster" "postgresql" {
  cluster_identifier = "aurora-cluster-demo"
  availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
  database_name      = "spiderdb"
  engine             = "aurora-postgresql"
  master_username    = "username"
  master_password    = "password"
}