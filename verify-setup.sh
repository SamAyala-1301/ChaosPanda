#!/bin/bash
echo "=== ChaosPanda Setup Verification ==="
echo ""

# Check each tool
tools=("brew" "git" "aws" "terraform" "kubectl" "docker" "jq" "helm")
for tool in "${tools[@]}"; do
    if command -v $tool &> /dev/null; then
        version=$($tool --version 2>&1 | head -n 1)
        echo "✅ $tool: $version"
    else
        echo "❌ $tool: NOT FOUND"
    fi
done

echo ""
echo "=== AWS Configuration ==="
if aws sts get-caller-identity &> /dev/null; then
    echo "✅ AWS credentials configured"
    aws sts get-caller-identity
else
    echo "❌ AWS credentials NOT configured"
fi

echo ""
echo "=== Docker Status ==="
if docker ps &> /dev/null; then
    echo "✅ Docker is running"
else
    echo "❌ Docker is NOT running (start Docker Desktop)"
fi
