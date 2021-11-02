### Create VPC
resource "aws_vpc" "IN8-vpc" {
  cidr_block       = "172.31.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "prod-vpc"
  }
}

resource "aws_subnet" "in8-subnet" {
  vpc_id     = aws_vpc.IN8-vpc.id
  cidr_block = "172.31.0.0/20"
    map_public_ip_on_launch =   "true"
  availability_zone    =   var.AWS_REGION_AZ_WEB_1

  tags = {
    Name = "prod-subnet-in8-subnet"
  }
}

### Criação de Internet Nat Gateway
resource "aws_internet_gateway" "prod-igw" {
  vpc_id = aws_vpc.IN8-vpc.id

  tags = {
    Name = "prod-igw"
  }
}

### Criação de rota customizadas para subnets públicas
resource "aws_route_table" "prod-public-crt" {
    vpc_id = aws_vpc.IN8-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.prod-igw.id
    }

    tags = {
        Name = "prod-public-crt"
    }
}

### Criação de Elastic IP para NAT Gateway
resource "aws_eip" "nat" {
vpc      = true
    tags = {
        Name = "prod-elastic-ip-crt"
    }
}

### Criação de NAT Gateway
resource "aws_nat_gateway" "nat-gw" {
allocation_id = aws_eip.nat.id
subnet_id = aws_subnet.in8-subnet.id
depends_on = [aws_internet_gateway.prod-igw]
    tags = {
        Name = "prod-nat-gateway-crt"
    }
}
### Define Route
resource "aws_main_route_table_association" "IN8-route" {
  vpc_id         = aws_vpc.IN8-vpc.id
  route_table_id = aws_route_table.prod-public-crt.id
}
