"# AWS WebApp Template

## Description
A full-stack web application template with AWS infrastructure, featuring a React frontend and FastAPI backend deployed using AWS CDK.

## Features

### Frontend
- ⚛️ React application with modern build tools
- 🎨 Tailwind CSS for styling
- 📦 Deployed to S3 with CloudFront CDN
- 🔧 ESLint configuration for code quality

### Backend
- 🐍 FastAPI Python web framework
- 🗄️ Database integration ready
- 🐳 Docker containerization
- ☁️ Deployed to AWS ECS Fargate

### Infrastructure
- 🏗️ AWS CDK for Infrastructure as Code
- 🔄 GitHub Actions CI/CD pipeline
- 🔐 IAM roles with least privilege access
- 📊 CloudWatch logging and monitoring
- 🌐 Custom domain support ready

### Development Experience
- 📝 Poetry for Python dependency management
- 🔄 Hot reload for local development
- 🧪 Testing setup included
- 📋 Pre-configured linting and formatting

## Getting Started with This Template

1. **Create a new repository from this template**
   - Click the "Use this template" button on GitHub
   - Create your new repository
   - Clone your new repository locally

2. **Customize the project**
   - Update the repository name references in `.github/workflows/deploy.yml`
   - Replace placeholder values with your actual AWS account ID and region
   - Modify the application code to fit your needs
   - Update this README with your project-specific information

## Customization Checklist

After creating your repository from this template, update the following:

### GitHub Actions Workflow (`.github/workflows/deploy.yml`)
- [ ] Replace `<YOUR_ACCOUNT_ID>` with your AWS account ID
- [ ] Replace `<YOUR_AWS_REGION>` with your preferred AWS region
- [ ] Update `<YOUR_TABLE_NAME>` and `<YOUR_BUCKET_NAME>` with your resource names

### Environment Configuration
- [ ] Copy `.env.example` to `.env` and add your AWS credentials
- [ ] Update the trust relationship in your IAM role with your repository name

## Requirements
- Python 3.9+
- Poetry (version 1.1.0 or later)
- Node.js (version 16.x or later)
- AWS CDK CLI (version 2.166.0)
- AWS CLI (configured with appropriate credentials)

## Setup

### Quick Start

For a guided setup, run the setup script:
```sh
./setup.sh
```

### Manual Setup

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

6. **Configure AWS CLI**  
   ```sh
   aws configure
   ```

7. **Bootstrap the AWS environment**  
   ```sh
   cdk bootstrap aws://ACCOUNT-NUMBER/REGION
   ```
   Replace `ACCOUNT-NUMBER` and `REGION` with your AWS account and region.

8. **Deploy using CDK**  
   ```sh
   cdk deploy
   ```

9. **Generate stub data (Optional)**  
   ```sh
   poetry run python backend/load_flight_data.py
   ```

10. **Run the FastAPI server locally**  
    ```sh
    poetry run uvicorn backend.main:app --reload
    ```

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
   - ☑️ Require a pull request before merging
   - ☑️ Require status checks to pass before merging
   - ☑️ Restrict deletions

### 2. Configure Repository Secrets
Add these secrets in **Settings** → **Secrets and variables** → **Actions**:
- `AWS_ACCOUNT_ID`: Your AWS account ID
- `AWS_REGION`: Your preferred AWS region

---

With these permissions and the trust relationship, your GitHub Actions workflow will be able to deploy infrastructure and push images as needed."
