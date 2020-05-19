# Elastic IP
resource "aws_eip" "this" {
  vpc = true
  tags = merge(
    {
      "Name" = format("%s-eip", var.name-prefix)
    },
    var.tags,
  )
  # depends_on = ["aws_internet_gateway.default"]
}

# Nat Gateway, so instance on private subnet  can talk to internet outside
# put it on one of public subnet
resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = element(aws_subnet.public.*.id, 0)
  depends_on    = [aws_eip.this]
}
