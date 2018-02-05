variable "region" {
  default = "eu-west-1"
}

variable "enable" {
  default = true
}

# resource
variable "resource_path" {}
variable "resource_http_method" {
  default = "ANY"
}

# api_gateway_rest_api
variable "api_gateway_rest_api_id" {}
variable "api_gateway_rest_api_root_resource_id" {}

# api_gateway_integration
variable "api_gateway_integration_type" {
  default = "AWS_PROXY"
}
variable "api_gateway_integration_method" {
  default = "POST"
}
variable "api_gateway_integration_uri" {
}
variable "api_gateway_integration_credentials" {
}