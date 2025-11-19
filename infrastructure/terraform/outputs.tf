output "bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.website.id
}

output "bucket_website_endpoint" {
  description = "S3 bucket website endpoint"
  value       = aws_s3_bucket_website_configuration.website.website_endpoint
}

output "bucket_website_url" {
  description = "S3 bucket website URL"
  value       = "http://${aws_s3_bucket_website_configuration.website.website_endpoint}"
}

output "aws_region" {
  description = "AWS region where bucket is deployed"
  value       = var.aws_region
}
