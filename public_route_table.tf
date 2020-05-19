# a route table to associate public subnets
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.this.id
  tags = merge(
    {
      "Name" = format("%s-public-rtb", var.name-prefix)
    },
    var.tags,
  )
}

# create a route to internet
resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

# associate subnet to public route table
resource "aws_route_table_association" "subnets_public_association" {
  count = length(var.public_subnets) > 0 ? length(var.public_subnets) : 0

  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public_route_table.id
}
