####################################
# Connect private subnet to internet
####################################

# create a route table entry and route traffic
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.this.id
  tags = merge(
    {
      "Name" = format("%s-private-rtb", var.name-prefix)
    },
    var.tags,
  )
}

# attach nat gateway to the route table entry
resource "aws_route" "private_route" {
  count = var.create_nat_gateway ? 1 : 0

  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.this.*.id, 0)
}

# associate private subnets
resource "aws_route_table_association" "subnets_private_association" {
  count = var.create_nat_gateway ? 1 : 0

  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private_route_table.id
}
