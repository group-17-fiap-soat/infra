
resource "aws_cognito_user_pool" "main" {
  name = "lambda-auth-pool"

  auto_verified_attributes = ["email"]
}

resource "aws_cognito_resource_server" "admin_api" {
  identifier   = "api"
  name         = "Admin API"
  user_pool_id = aws_cognito_user_pool.main.id

  scope {
    scope_name        = "admin"
    scope_description = "Permissão de administrador"
  }
}

resource "aws_cognito_user_pool_client" "app_client" {
  name         = "lambda-auth-client"
  user_pool_id = aws_cognito_user_pool.main.id

  generate_secret             = true
  allowed_oauth_flows        = ["client_credentials"]
  allowed_oauth_scopes       = [
    for scope in aws_cognito_resource_server.admin_api.scope :
    "${aws_cognito_resource_server.admin_api.identifier}/${scope.scope_name}"
  ]
  allowed_oauth_flows_user_pool_client = true

  callback_urls = ["https://example.com/callback"]
  logout_urls   = ["https://example.com/logout"]

  supported_identity_providers = ["COGNITO"]
}

resource "aws_cognito_user_pool_domain" "auth_domain" {
  domain       = "lambda-auth-${random_string.suffix.result}"
  user_pool_id = aws_cognito_user_pool.main.id
}

resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

resource "aws_secretsmanager_secret" "cognito_secret" {
  name = "cognito/app_client_secret_${terraform.workspace}_${replace(timestamp(), ":", "")}"
}

resource "aws_secretsmanager_secret_version" "cognito_secret_value" {
  secret_id     = aws_secretsmanager_secret.cognito_secret.id
  secret_string = jsonencode({
    client_id     = aws_cognito_user_pool_client.app_client.id,
    client_secret = aws_cognito_user_pool_client.app_client.client_secret
  })
}


output "client_id" {
  value = aws_cognito_user_pool_client.app_client.id
}

output "client_secret" {
  value = aws_cognito_user_pool_client.app_client.client_secret
  sensitive = true
}

output "token_url" {
  value = "https://${aws_cognito_user_pool_domain.auth_domain.domain}.auth.${var.aws_region}.amazoncognito.com/oauth2/token"
}
