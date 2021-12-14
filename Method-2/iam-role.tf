
resource "aws_iam_role" "ec2_rds" {
  name = "${var.ENV}-ec2-rds-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF

  tags = {
    project = "${var.ENV}-ec2-rds-role"
  }
}

resource "aws_iam_instance_profile" "ec2_rds_profile" {
  name = "${var.ENV}-ec2-rds-profile"
  role = aws_iam_role.ec2_rds.name
}

resource "aws_iam_role_policy" "ec2_rds_policy" {
  name = "${var.ENV}-ec2-rds-policy"
  role = aws_iam_role.ec2_rds.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "rds:*",
        "cloudwatch:DescribeAlarms",
        "cloudwatch:GetMetricStatistics",
        "ec2:DescribeAccountAttributes",
        "ec2:DescribeAvailabilityZones",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeSubnets",
        "ec2:DescribeVpcs",
        "sns:ListSubscriptions",
        "sns:ListTopics",
        "logs:DescribeLogStreams",
        "logs:GetLogEvents"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}