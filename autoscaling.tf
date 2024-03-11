resource "aws_launch_template" "foo" {
  name = "${var.WORKSPACE_NAME}_template"

  image_id      = var.ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.launch_tamplate.key_name

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups   = [aws_security_group.allow_tls.id]
    device_index      = 0
    network_card_index= 0  
  }

  placement {
    availability_zone = var.region
  }

  tags = {
    Name = "${var.WORKSPACE_NAME}_sg"
  }

  user_data = filebase64("${path.module}/run.sh")
}

resource "aws_autoscaling_group" "bar" {
  desired_capacity = 2
  max_size         = 2
  min_size         = 1
  #vpc_zone_identifier   = data.aws_security_groups.vpc_security_group.ids
  vpc_zone_identifier       = [aws_subnet.public.id]
  health_check_type         = "EC2"
  health_check_grace_period = 100

  launch_template {
    id      = aws_launch_template.foo.id
    version = "$Latest"
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_cloudwatch_metric_alarm" "cpu_utilization_alarm" {
  alarm_name          = "example-cpu-utilization-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "50"
  alarm_description   = "Scale up when CPU exceeds 50%"
  alarm_actions       = [aws_autoscaling_policy.scale_up_policy.arn]
}

resource "aws_autoscaling_policy" "scale_up_policy" {
  name               = "scale-up-policy"
  scaling_adjustment = 1
  cooldown           = 200
  adjustment_type    = "ChangeInCapacity"

  autoscaling_group_name = aws_autoscaling_group.bar.name
}

resource "aws_autoscaling_policy" "scale_down_policy" {
  name               = "scale-down-policy"
  scaling_adjustment = -1
  cooldown           = 200
  adjustment_type    = "ChangeInCapacity"

  autoscaling_group_name = aws_autoscaling_group.bar.name
}


