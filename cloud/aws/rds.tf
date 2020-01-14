
provider "aws" {
  region = "us-east-1"
}

resource "aws_db_instance" "spiderdb" {
  allocated_storage       = 256 # gigabytes
  max_allocated_storage   = 500
  backup_retention_period = 7 # in days
  engine                  = "postgres"
  engine_version          = "9.5.4"
  identifier              = "spiderdb"
  instance_class          = "db.r3.large"
  multi_az                = true
  name                    = "spiderdb"
  password                = "supersecretpassword"
  port                    = 5432
  publicly_accessible     = true
  storage_encrypted       = true # you should always do this
  storage_type            = "gp2"
  username                = "supersecretusername"
  vpc_security_group_ids  = ["${aws_security_group.spiderdb.id}"]
}

resource "aws_security_group" "spiderdb" {
  name = "spiderdb"

  description = "RDS postgres servers (terraform-managed)"

  # Only postgres in
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}