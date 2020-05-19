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
