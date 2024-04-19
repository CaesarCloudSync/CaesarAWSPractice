// main.tf

provider "aws" {
  region                    = "us-east-1"
  shared_credentials_files  = ["/home/amari/.aws/credentials"]
  profile                   = "palindrome"
}



resource "aws_security_group" "example" {
  name_prefix = "example-"
  ingress {
    from_port   = 0
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "example" {
  engine                 = "mysql"
  db_name                = "example"
  identifier             = "example"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  publicly_accessible    = true
  username               = var.db-username
  password               = var.db-password
  vpc_security_group_ids = [aws_security_group.example.id]
  skip_final_snapshot    = true

  tags = {
    Name = "example-db"
  }
}