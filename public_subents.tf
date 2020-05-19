####################################
### public subnets
####################################
resource "aws_subnet" "public" {
  count = length(var.public_subnets) > 0 ? length(var.public_subnets) : 0

  vpc_id                  = aws_vpc.this.id
  cidr_block              = element(var.public_subnets, count.index)
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = true
  tags = merge(
    {
      "Name" = format(
        "%s-public-%s",
        var.name-prefix,
        element(var.azs, count.index),
      )
    },
    var.tags,
  )
}

# associate subnet to public route table
resource "aws_route_table_association" "subnets_public_association" {
  count = length(var.public_subnets) > 0 ? length(var.public_subnets) : 0

  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public_route_table.id
}
