resource "aws_instance" "ec2-web01" {
  instance_type = "t2.micro"
  ami           = "ami-07983613af1a3ef44"


  ### VPC
  subnet_id         = aws_subnet.in8-subnet.id
  availability_zone = var.AWS_REGION_AZ_WEB_1
  ### Atribuir Security Group
  vpc_security_group_ids = [aws_security_group.instance.id]


  tags = {
    Name = "ec2-web01"
  }



}