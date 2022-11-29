output "aws_vpc_output_id" {
    value = aws_vpc.aws_vpc.id
  }

  output "pub_snet_output_id" {
    value = aws_subnet.pub_snet
  }