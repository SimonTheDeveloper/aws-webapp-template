#!/bin/bash

# AWS WebApp Template Setup Script
echo "🚀 Setting up AWS WebApp Template..."

# Check if required tools are installed
echo "📋 Checking prerequisites..."

# Check Python
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 is required but not installed."
    exit 1
fi

# Check Node.js
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is required but not installed."
    exit 1
fi

# Check if .env file exists
if [ ! -f ".env" ]; then
    echo "📝 Creating .env file from template..."
    cp .env.example .env
    echo "⚠️  Please edit .env file with your AWS credentials before proceeding."
fi

# Install Poetry if not installed
if ! command -v poetry &> /dev/null; then
    echo "📦 Installing Poetry..."
    curl -sSL https://install.python-poetry.org | python3 -
    export PATH="$HOME/.local/bin:$PATH"
fi

# Install Python dependencies
echo "📦 Installing Python dependencies..."
cd backend
poetry install
cd ..

# Install Node.js dependencies for root
echo "📦 Installing Node.js dependencies..."
npm install

# Install frontend dependencies
echo "📦 Installing frontend dependencies..."
cd frontend
npm install
cd ..

# Install AWS CDK if not installed
if ! command -v cdk &> /dev/null; then
    echo "🛠️  Installing AWS CDK..."
    npm install -g aws-cdk
fi

echo "✅ Setup complete!"
echo ""
echo "📋 Next steps:"
echo "1. Edit .env file with your AWS credentials"
echo "2. Update .github/workflows/deploy.yml with your AWS account details"
echo "3. Configure AWS CLI: aws configure"
echo "4. Bootstrap CDK: cdk bootstrap aws://ACCOUNT-NUMBER/REGION"
echo "5. Deploy: cdk deploy"
echo ""
echo "🔗 For detailed instructions, see README.md"
