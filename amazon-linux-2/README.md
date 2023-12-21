# Running Yarn on Elastic Beanstalk (Node.js / Amazon Linux 2)
This repository demonstrates how to run [Yarn](https://yarnpkg.com/) on Elastic Beanstalk with Node.js running on **Amazon Linux 2**. If you're instead running **Amazon Linux 2023**, see the `/amazon-linux-2023` directory instead.

## Overview
`nodejs-app/` contains a sample express application configured to use yarn to install dependencies. All of the Elastic Beanstalk configuration is contained within the `.platform` directory

### Using in your own projects
Simply copy (or merge if you already have it) the `.platform` directory into your own project. If you modify any of the script files, make sure that both versions (`/hooks` and `/confighooks`) are updated.

### Quick Setup
`infrastructure/` contains a terraform application that deploys a sample Elastic Beanstalk application with the nodejs app.