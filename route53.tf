resource "aws_route53_record" "workspace_record" {
  zone_id = "Z0804944375KWXIC7X506"
  name    = "infogyan.online"
  type    = "A"

  alias {
    name                   = aws_lb.example.dns_name
    zone_id                = aws_lb.example.zone_id
    evaluate_target_health = true
  }
}

output "dns" {
  value = aws_lb.example.dns_name
}
