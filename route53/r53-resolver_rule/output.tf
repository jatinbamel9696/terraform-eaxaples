output "resolver_rule_id" {
  description = "forword rule id"
  value = aws_route53_resolver_rule.fwd.id
}

output "resolver_rule_arn" {
  description = "forword rule arn"
  value = aws_route53_resolver_rule.fwd.arn
}