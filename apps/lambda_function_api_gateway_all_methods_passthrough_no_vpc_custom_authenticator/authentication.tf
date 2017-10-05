resource "aws_iam_role" "invocation_role" {
  name = "api_gateway_auth_invocation"
  path = "/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "apigateway.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "invocation_policy" {
  name = "default"
  role = "${aws_iam_role.invocation_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "lambda:InvokeFunction",
      "Effect": "Allow",
      "Resource": "${var.authorizer_arn}"
    }
  ]
}
EOF
}

resource "aws_api_gateway_authorizer" "app_authorizer" {
  name                   = "${var.app_name}-authorizer"
  rest_api_id            = "${aws_api_gateway_rest_api.app.id}"
  authorizer_uri         = "${var.authorizer_uri}"
  authorizer_credentials = "${aws_iam_role.invocation_role.arn}"
  authorizer_result_ttl_in_seconds = "${var.authorize_cache_ttl}"
  type = "${var.authorizer_type}"
}

