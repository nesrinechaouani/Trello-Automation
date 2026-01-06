output "lambda_function_arn" {
  description = "ARN of the Lambda function"
  value       = aws_lambda_function.webhook_handler.arn
}

output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = aws_lambda_function.webhook_handler.function_name
}

output "api_gateway_url" {
  description = "API Gateway invoke URL"
  value       = aws_apigatewayv2_api.webhook_api.api_endpoint
}

output "webhook_callback_url" {
  description = "Full webhook callback URL for Trello"
  value       = "${aws_apigatewayv2_api.webhook_api.api_endpoint}/trello"
}

output "api_gateway_id" {
  description = "ID of the API Gateway"
  value       = aws_apigatewayv2_api.webhook_api.id
}

output "cloudwatch_log_group" {
  description = "CloudWatch log group for Lambda"
  value       = aws_cloudwatch_log_group.lambda_logs.name
}

output "deployment_info" {
  description = "Deployment information"
  value = {
    region            = var.aws_region
    function_name     = aws_lambda_function.webhook_handler.function_name
    api_endpoint      = aws_apigatewayv2_api.webhook_api.api_endpoint
    webhook_url       = "${aws_apigatewayv2_api.webhook_api.api_endpoint}/trello"
    log_group         = aws_cloudwatch_log_group.lambda_logs.name
  }
}
