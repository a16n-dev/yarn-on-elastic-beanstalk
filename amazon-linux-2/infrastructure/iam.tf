data aws_iam_policy eb_policy {
  arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

resource "aws_iam_instance_profile" "eb_instance_profile" {
  role = aws_iam_role.eb_role.name
}

resource "aws_iam_role" "eb_role" {
  name = "ElasticBeanstalkInstanceProfileRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com",
        },
      },
    ],
  })
}

resource "aws_iam_policy_attachment" "eb_role_policy_attachment" {
  policy_arn = data.aws_iam_policy.eb_policy.arn
  roles      = [aws_iam_role.eb_role.name]
  name       = "eb_role_policy_attachment"
}