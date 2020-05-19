####################################
### private subnets
####################################
resource "aws_subnet" "private" {
  count = length(var.private_subnets) > 0 ? length(var.private_subnets) : 0

  vpc_id            = aws_vpc.this.id
  cidr_block        = element(var.private_subnets, count.index)
  availability_zone = element(var.azs, count.index)
  tags = merge(
    {
      "Name" = format(
        "%s-private-%s",
        var.name-prefix,
        element(var.azs, count.index),
      )
    },
    var.tags,
  )
}

