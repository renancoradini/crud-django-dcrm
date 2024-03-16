# # SSL Certificate
# resource "aws_acm_certificate" "ssl_certificate" {
#   provider                  = aws.acm_provider
#   domain_name               = var.domain_name
#   subject_alternative_names = ["*.${var.domain_name}"]
#   validation_method         = "DNS"

#   lifecycle {
#     create_before_destroy = true
#   }
# }
# # SSL Certificate validation
# resource "aws_acm_certificate_validation" "cert_validation" {
#   provider        = aws.acm_provider
#   certificate_arn = aws_acm_certificate.ssl_certificate.arn
# }
#
### uncomment for upload valid certificate
# resource "aws_acm_certificate" "appdenzelcert" {
#   private_key       = file("appdenzel_privatekey.pem")
#   certificate_body  = file("appdenzel_cert.pem")
#   certificate_chain = file("appdenzel_fullchain.pem")
# }
