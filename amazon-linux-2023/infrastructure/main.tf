resource aws_s3_bucket build_artifacts {
  bucket_prefix = "eb-artifacts-"
  force_destroy = true
}

data archive_file nodejs_application {
  type        = "zip"
  source_dir  = "${path.module}/../nodejs-app"
  output_path = "${path.module}/tmp/nodejs.zip"
}

resource aws_s3_object default_deployment_object {
  bucket = aws_s3_bucket.build_artifacts.id
  key    = "nodejs.zip"
  source = data.archive_file.nodejs_application.output_path
}

resource aws_elastic_beanstalk_application_version default_deployment {
  name        = "default-deployment"
  application = aws_elastic_beanstalk_application.app.name
  bucket      = aws_s3_bucket.build_artifacts.id
  key         = aws_s3_object.default_deployment_object.id
}

resource aws_elastic_beanstalk_application app {
    name = "yarn-on-al2023"
}

resource aws_elastic_beanstalk_environment app_env {
  name                = "Example"
  description         = "Elastic Beanstalk Environment running AL2023, demostrating how to install dependencies with yarn"
  application         = aws_elastic_beanstalk_application.app.name
  tier                = "WebServer"
  solution_stack_name = "64bit Amazon Linux 2023 v6.0.4 running Node.js 18"
  version_label       = aws_elastic_beanstalk_application_version.default_deployment.name

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role"
    resource  = aws_iam_role.eb_role.arn
  }

  setting {
    namespace = "aws:ec2:instances"
    name      = "InstanceTypes"
    value     = "t3.micro"
    resource  = ""
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "SingleInstance"
    resource  = ""
  }
}

output url {
  value = aws_elastic_beanstalk_environment.app_env.endpoint_url
}