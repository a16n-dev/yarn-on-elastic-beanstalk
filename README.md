# Using Yarn on Elastic Beanstalk
This repo demonstrates how to use [Yarn](https://yarnpkg.com/) on Elastic Beanstalk with Node.js. It contains two sample applications, one for Amazon Linux 2 and one for Amazon Linux 2023, so you will need to choose the one that matches your environment.

## Deploying the sample applications
Both applications have Terraform configuration in the `/infrastucture` directory, which are set up to deploy the sample application on AWS.
> Note that while the resources specified in the Terraform configuration are free-tier eligible, you may still incur charges if you exceed the free tier limits. See the [AWS Free Tier](https://aws.amazon.com/free/) page for more information.