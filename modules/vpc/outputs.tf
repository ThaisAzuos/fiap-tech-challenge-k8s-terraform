output "vpc_id" {
  value = aws_vpc.oficina.id
}

output "subnet_ids" {
  value = [aws_subnet.public.id]
}
