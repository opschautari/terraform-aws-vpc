# internet gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = merge(
    {
      "Name" = format("%s-igw", var.name-prefix)
    },
    var.tags,
  )
}
