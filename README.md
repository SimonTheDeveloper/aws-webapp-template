# AWS WebApp Template

![Template](https://img.shields.io/badge/template-use%20this%20template-brightgreen)
![AWS](https://img.shields.io/badge/AWS-CDK-orange)
![React](https://img.shields.io/badge/Frontend-React-blue)
![FastAPI](https://img.shields.io/badge/Backend-FastAPI-green)

![Template](https://img.shields.io/badge/template-use%20this%20template-brightgreen)
![AWS](https://img.shields.io/badge/AWS-CDK-orange)
![React](https://img.shields.io/badge/Frontend-React-blue)
![FastAPI](https://img.shields.io/badge/Backend-FastAPI-green)

## Description
A complete web application template that helps you build and deploy modern web apps to Amazon Web Services (AWS). This template includes everything you need to create a professional web application with a user interface (React) and a backend server (FastAPI) that can handle user requests and store data.

**Perfect for:** Small businesses, startups, or developers who want to create web applications without starting from scratch.

## What You'll Get

This template provides a complete web application with:

### User Interface (Frontend)
- Modern, responsive web interface that works on desktop and mobile
- Professional styling with Tailwind CSS
- Automatically optimized for fast loading
- Hosted on Amazon's global content delivery network for fast access worldwide

### Server & Database (Backend)
- Python-based server that handles user requests
- Database for storing your application data
- Secure user authentication (optional)
- Automatic scaling when you have more users

### Cloud Infrastructure
- Professional hosting on Amazon Web Services (AWS)
- Automatic deployment when you make code changes
- Monitoring and logging to track how your app is performing
- Secure setup following industry best practices

### Developer Tools
- Automated testing to catch bugs before they reach users
- Easy local development environment
- Pre-configured code quality tools
- Step-by-step deployment process

## Before You Start

### What You'll Need
1. **A computer** with internet access (Windows, Mac, or Linux)
2. **Basic familiarity** with using a web browser and downloading software
3. **An AWS account** (Amazon's cloud service - we'll help you set this up)
4. **A GitHub account** (free code hosting service - sign up at github.com)
5. **About 2-3 hours** for initial setup (most of this is waiting for downloads and installations)

### Don't Worry If You're New To:
- Programming or coding
- Using the command line/terminal
- Cloud services like AWS
- Git or GitHub

This guide will walk you through everything step by step.

## Getting Started with This Template

### Step 1: Create Your Project
1. **On GitHub**, click the green "Use this template" button at the top of this page
2. **Give your project a name** (like "my-awesome-app")
3. **Choose if you want it public or private** (public means others can see it, private means only you can)
4. **Click "Create repository from template"**

### Step 2: Download Your Project
1. **Copy the repository URL** from your new project page (click the green "Code" button and copy the HTTPS URL)
2. **Open your terminal/command prompt:**
   - **On Windows:** Press `Windows key + R`, type `cmd`, press Enter
   - **On Mac:** Press `Cmd + Space`, type "Terminal", press Enter
   - **On Linux:** Press `Ctrl + Alt + T`
3. **Navigate to where you want your project** (like your Desktop):
   ```sh
   cd Desktop
   ```
4. **Clone your project:**
   ```sh
   git clone https://github.com/YOUR-USERNAME/YOUR-PROJECT-NAME.git
   ```
   (Replace with your actual GitHub username and project name)
5. **Enter your project folder:**
   ```sh
   cd YOUR-PROJECT-NAME
   ```

## Requirements

Before you can run your web application, you need to install some tools on your computer. Think of these like the ingredients you need before cooking a meal:

### Essential Tools
- **Python 3.9 or newer** - The programming language that powers your backend server
- **Node.js 16 or newer** - Tools for building modern web interfaces
- **Poetry** - Helps manage Python dependencies (we'll install this for you)
- **AWS CDK** - Tools for setting up your cloud infrastructure (we'll install this too)
- **AWS CLI** - Command line tools for Amazon Web Services

## Setup Guide

### Option 1: Easy Setup (Recommended for Beginners)

We've created an automated setup script that does most of the work for you:

1. **Make sure you're in your project directory** (you should already be there from Step 2 above)

2. **Run the setup script:**
   ```sh
   ./setup.sh
   ```
   
This script will:
- Check if you have the required tools installed
- Install missing tools automatically
- Set up your project configuration
- Give you clear next steps

### Option 2: Manual Setup (For Advanced Users)

If you prefer to install everything yourself or the automatic script doesn't work:

1. **Install Poetry**  
   Open a terminal and run:
   ```sh
   curl -sSL https://install.python-poetry.org | python3 -
   ```

2. **Install Python dependencies using Poetry**  
   ```sh
   poetry install
   ```

3. **Create a `.env` file**  
   Copy the example file and add your AWS credentials:
   ```sh
   cp .env.example .env
   ```
   Then edit `.env` with your actual AWS credentials:
   ```env
   AWS_ACCESS_KEY_ID=your_access_key_id
   AWS_SECRET_ACCESS_KEY=your_secret_access_key
   AWS_DEFAULT_REGION=your_default_region
   ```

   > **Tip:** For CI/CD, use GitHub Secrets instead of storing credentials in `.env`.

4. **Install Node.js and AWS CDK CLI**  
   Ensure you have Node.js 16.x or later and AWS CDK CLI installed:
   ```sh
   npm install -g aws-cdk@2.166.0
   ```

5. **Install frontend dependencies and build the React app**  
   ```sh
   cd frontend
   npm install
   npm run build
   cd ..
   ```

6. **Set up your Amazon Web Services (AWS) account:**
   
   **What is AWS?** Amazon Web Services is like renting space on Amazon's computers to run your web application, instead of buying your own servers.
   
   **Steps:**
   - Go to [aws.amazon.com](https://aws.amazon.com) and click "Create an AWS Account"
   - Follow the signup process (you'll need a credit card, but we'll use free services)
   - Once logged in, you'll need to find your "Account ID" (a 12-digit number)
   
7. **Configure AWS on your computer:**
   ```sh
   aws configure
   ```
   When prompted, enter:
   - Your AWS Access Key (from your AWS account security credentials)
   - Your AWS Secret Key (from your AWS account security credentials)  
   - Your preferred region (like `us-east-1` for US East or `eu-west-1` for Europe)

8. **Prepare AWS for your application (this step sets up the foundation):**
   ```sh
   cdk bootstrap aws://YOUR-ACCOUNT-NUMBER/YOUR-REGION
   ```
   Replace `YOUR-ACCOUNT-NUMBER` with your 12-digit AWS account ID and `YOUR-REGION` with your chosen region.

9. **Deploy your application to the cloud:**
   ```sh
   cdk deploy
   ```
   This step uploads your application to AWS and makes it available on the internet. It might take 10-15 minutes the first time.

10. **Test your application locally (optional):**
    ```sh
    poetry run uvicorn backend.main:app --reload
    ```
    This runs your application on your computer so you can test it before it goes live.

---

## What Gets Deployed

This template creates the following AWS resources:

- **S3 Bucket**: Hosts the React frontend as a static website
- **CloudFront Distribution**: CDN for global content delivery
- **ECS Cluster**: Container orchestration for the backend
- **ECS Service**: Runs the FastAPI application
- **Application Load Balancer**: Routes traffic to the backend
- **DynamoDB Table**: Database for application data (optional)
- **CloudWatch Logs**: Centralized logging
- **IAM Roles**: Secure access between services

## Frontend

- The React app is deployed to S3 via CDK.  
- After deployment, access your app using the S3 static website URL output by CDK.

---

## GitHub Actions AWS Credentials

This template uses the [aws-actions/configure-aws-credentials](https://github.com/aws-actions/configure-aws-credentials) action in the workflow:

```yaml
- name: Configure AWS credentials
  uses: aws-actions/configure-aws-credentials@v2
  with:
    role-to-assume: arn:aws:iam::<YOUR_ACCOUNT_ID>:role/GitHubActionsECRPushRole
    aws-region: <YOUR_REGION>
    role-session-name: github-actions-session
```

Replace the `role-to-assume` and `aws-region` values with your own.

---

## GitHub Actions IAM Role

This template expects you to have an IAM role in AWS named `GitHubActionsECRPushRole` that GitHub Actions can assume for deploying infrastructure and pushing to ECR (if needed).

### Example Trust Relationship for GitHub Actions OIDC

When creating the `GitHubActionsECRPushRole` IAM role, set the following trust relationship to allow GitHub Actions from your repository to assume the role via OIDC:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "arn:aws:iam::<YOUR_ACCOUNT_ID>:oidc-provider/token.actions.githubusercontent.com"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "token.actions.githubusercontent.com:sub": "repo:YOUR_GITHUB_USERNAME/YOUR_REPOSITORY_NAME:ref:refs/heads/main",
          "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
        }
      }
    }
  ]
}
```

- Replace `<YOUR_ACCOUNT_ID>` with your AWS account number.
- Update the `repo:...` value if you fork or rename the repository, or want to allow other branches.

> For more details, see [Configuring OpenID Connect in AWS](https://docs.github.com/en/actions/deployment/security-hardening-your-deployments/about-security-hardening-with-openid-connect).

### Required IAM Policies

Attach the following policies to your `GitHubActionsECRPushRole`:

#### 1. **AmazonEC2ContainerRegistryPowerUser** (AWS managed)

Allows GitHub Actions to push and pull images to Amazon ECR.

#### 2. **CDKDeployWideAccess** (Custom Inline Policy)

Example policy:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "cloudformation:*",
        "s3:*",
        "ec2:*",
        "ecr:*",
        "ecs:*",
        "logs:*",
        "iam:PassRole",
        "dynamodb:*",
        "ssm:GetParameter"
      ],
      "Resource": "*"
    }
  ]
}
```

> **Note:**  
> The above permissions allow full access to the main AWS services used by this template. You may further restrict them for production use.

---

## Troubleshooting

### Common Issues

**CDK Bootstrap Error**
```
Error: This stack uses assets, so the toolkit stack must be deployed to the environment
```
Solution: Run `cdk bootstrap aws://ACCOUNT-NUMBER/REGION`

**GitHub Actions Permission Denied**
```
Error: User is not authorized to perform: sts:AssumeRoleWithWebIdentity
```
Solution: Check your IAM role trust relationship and ensure the repository name is correct

**Frontend Not Loading**
- Check that the S3 bucket has static website hosting enabled
- Verify CloudFront distribution is deployed
- Check browser console for CORS errors

**Backend API Errors**
- Check ECS service logs in CloudWatch
- Verify the load balancer health checks are passing
- Ensure security groups allow traffic on the correct ports

### Getting Help

- Check the [Issues](../../issues) page for common problems
- Review AWS CloudFormation events in the AWS Console
- Use `cdk diff` to see what changes will be made before deploying

---

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on contributing to this template.

---

## License

This template is available as open source under the terms of the [MIT License](LICENSE).

---

## Post-Template Setup

After creating your repository from this template:

### 1. Set Up Branch Protection (Recommended)
1. Go to **Settings** → **Branches**
2. Add rule for `main` branch:
   - Require a pull request before merging
   - Require status checks to pass before merging
   - Restrict deletions

### 2. Configure Repository Secrets
Add these secrets in **Settings** → **Secrets and variables** → **Actions**:
- `AWS_ACCOUNT_ID`: Your AWS account ID
- `AWS_REGION`: Your preferred AWS region

---

With these permissions and the trust relationship, your GitHub Actions workflow will be able to deploy infrastructure and push images as needed.
