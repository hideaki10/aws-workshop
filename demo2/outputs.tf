output "api_endpoint" {
  value = aws_apigatewayv2_api.demo_api.api_endpoint
}

output "lambda_function_name" {
  value = aws_lambda_function.demo_lambda.function_name
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.demo_table.name
} 