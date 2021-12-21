resource "aws_lb_target_group" "test" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.graylogvpc.id
}

resource "aws_lb_target_group_attachment" "atttest" {
  target_group_arn = aws_lb_target_group.test.arn
  target_id        = aws_instance.HelloGraylog.id
  port             = 80
}

