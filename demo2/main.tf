# DynamoDB table
resource "aws_dynamodb_table" "demo_table" {
  name           = "demo-table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

# Lambda
resource "aws_lambda_function" "demo_lambda" {
  filename         = "lambda_function.zip"
  function_name    = "demo-lambda"
  role            = aws_iam_role.lambda_role.arn
  handler         = "index.handler"
  runtime         = "nodejs18.x"

  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.demo_table.name
    }
  }
}

# API Gateway
resource "aws_apigatewayv2_api" "demo_api" {
  name          = "demo-api"
  protocol_type = "HTTP"
}

# API Gateway Stage
resource "aws_apigatewayv2_stage" "demo_stage" {
  api_id      = aws_apigatewayv2_api.demo_api.id
  name        = "$default"
  auto_deploy = true
}

# API Gateway Integration
resource "aws_apigatewayv2_integration" "lambda_integration" {
  api_id           = aws_apigatewayv2_api.demo_api.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.demo_lambda.invoke_arn
}

# API Gateway Route
resource "aws_apigatewayv2_route" "demo_route" {
  api_id    = aws_apigatewayv2_api.demo_api.id
  route_key = "POST /items"
  target    = "integrations/${aws_apigatewayv2_integration.lambda_integration.id}"
}

# role
resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.demo_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.demo_api.execution_arn}/*/*"
} 