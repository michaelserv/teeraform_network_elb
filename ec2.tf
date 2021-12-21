resource "aws_instance" "HelloGraylog" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id = aws_subnet.publicsubnet.id
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  user_data = "${file("apache.sh")}"
  associate_public_ip_address = true
  tags = {
    Name = "HelloGraylog"
  }
}
