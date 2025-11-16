# StudyVerse Online Courses - Complete DevOps Setup Guide for Mac

## 🎯 Project Overview

This project demonstrates professional DevOps practices by automating deployment and monitoring of the StudyVerse Online Courses website using:

- **Ansible**: Fast automated deployment to AWS S3 (3-4 minutes)
- **Terraform**: Infrastructure as Code for scalable AWS architecture
- **Nagios**: Real-time website monitoring and alerting
- **AWS S3 + CloudFront**: Scalable, global website hosting

---

## 📋 Prerequisites for Mac

### 1. Install Homebrew (if not installed)
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Install Required Tools
```bash
# Install AWS CLI
brew install awscli

# Install Ansible
brew install ansible

# Install Terraform (optional for full demo)
brew install terraform

# Install Docker (for local testing)
brew install --cask docker
```

### 3. Configure AWS Credentials
```bash
aws configure
# Enter your AWS Access Key ID
# Enter your AWS Secret Access Key
# Default region: us-east-1
# Default output format: json
```

### 4. Verify Installation
```bash
aws --version
ansible --version
terraform --version
docker --version
```

---

## 🚀 Quick Start - Ansible Deployment (Fastest)

### Deploy Website in 3 Minutes

```bash
cd Online-Courses/ansible

# Deploy website to AWS S3
ansible-playbook playbooks/ansible-only-deploy.yml

# Output will show:
# ✅ Bucket created
# ✅ Files uploaded
# ✅ Website URL: http://studyverse-online-courses-XXXXX.s3-website-us-east-1.amazonaws.com
```

### Verify Deployment
```bash
# Check if website is accessible
ansible-playbook playbooks/verify-deployment.yml
```

### Cleanup Resources
```bash
# Remove all deployed resources
ansible-playbook playbooks/ansible-cleanup.yml

# Or cleanup specific bucket
ansible-playbook playbooks/ansible-cleanup.yml -e "bucket_name=YOUR_BUCKET_NAME"
```

---

## 🏗️ Terraform Deployment (Production-Grade)

### Initialize Terraform
```bash
cd Online-Courses/terraform

# Initialize Terraform
terraform init

# Preview changes
terraform plan

# Deploy infrastructure
terraform apply
```

### What Terraform Creates
- S3 bucket with unique name
- Static website hosting configuration
- CloudFront CDN distribution
- Public access policies
- SSL/TLS certificates

### Get Outputs
```bash
# View deployment URLs
terraform output

# Outputs:
# - bucket_name
# - bucket_website_url (HTTP)
# - cloudfront_url (HTTPS with CDN)
```

### Destroy Infrastructure
```bash
terraform destroy
```

---

## 📊 Nagios Monitoring Setup

### Install and Configure Nagios
```bash
cd Online-Courses/nagios

# Run setup script
chmod +x setup-nagios-mac.sh
./setup-nagios-mac.sh
```

### Update Monitoring URL
After deploying your website, update Nagios with the actual URL:

```bash
# Update with your deployed website URL
chmod +x update-monitoring-url.sh
./update-monitoring-url.sh studyverse-online-courses-XXXXX.s3-website-us-east-1.amazonaws.com
```

### Access Nagios Dashboard
```bash
# Open in browser
open http://localhost:8080/nagios

# Default credentials:
# Username: nagiosadmin
# Password: (set during installation)
```

### What Nagios Monitors
- ✅ Website availability (HTTP checks)
- ✅ Response time (performance)
- ✅ Content verification (checks for "StudyVerse")
- ✅ SSL certificate status
- ✅ Page load performance

### Nagios Commands
```bash
# Check status
brew services list | grep nagios

# Restart Nagios
brew services restart nagios

# Stop Nagios
brew services stop nagios

# View logs
tail -f /usr/local/var/log/nagios/nagios.log
```

---

## 🧪 Local Testing with Docker

### Build and Run Locally
```bash
cd Online-Courses

# Build Docker image
docker build -t studyverse-courses .

# Run container
docker-compose up -d

# Access locally
open http://localhost:8080
```

### Stop Local Server
```bash
docker-compose down
```

---

## 📁 Project Structure

```
Online-Courses/
├── ansible/
│   ├── ansible.cfg                    # Ansible configuration
│   ├── inventory/hosts                # Inventory file
│   └── playbooks/
│       ├── ansible-only-deploy.yml    # Deploy to AWS
│       ├── ansible-cleanup.yml        # Cleanup resources
│       └── verify-deployment.yml      # Verify deployment
├── terraform/
│   ├── main.tf                        # Main infrastructure
│   ├── variables.tf                   # Input variables
│   └── outputs.tf                     # Output values
├── nagios/
│   ├── objects/
│   │   └── studyverse-website.cfg     # Website monitoring config
│   ├── setup-nagios-mac.sh            # Setup script
│   └── update-monitoring-url.sh       # Update URL script
├── Website files (HTML, CSS, JS, images)
└── DEVOPS_SETUP_GUIDE.md              # This file
```

---

## 🎬 Complete Demo Workflow

### Phase 1: Deploy with Ansible (3 minutes)
```bash
cd ansible
ansible-playbook playbooks/ansible-only-deploy.yml
# Note the website URL from output
```

### Phase 2: Setup Monitoring (5 minutes)
```bash
cd ../nagios
./setup-nagios-mac.sh
./update-monitoring-url.sh YOUR_WEBSITE_URL
open http://localhost:8080/nagios
```

### Phase 3: Verify Everything Works
```bash
cd ../ansible
ansible-playbook playbooks/verify-deployment.yml
```

### Phase 4: Show Monitoring Dashboard
- Open Nagios dashboard
- Show real-time checks
- Demonstrate alerts

### Phase 5: Cleanup (1 minute)
```bash
ansible-playbook playbooks/ansible-cleanup.yml
```

**Total Demo Time: 10 minutes**

---

## 🔧 Troubleshooting

### AWS Credentials Issues
```bash
# Check credentials
aws sts get-caller-identity

# Reconfigure if needed
aws configure
```

### Ansible Connection Issues
```bash
# Test AWS connectivity
aws s3 ls

# Verify Ansible installation
ansible --version
```

### Nagios Not Starting
```bash
# Check configuration
sudo nagios -v /usr/local/etc/nagios/nagios.cfg

# Check logs
tail -f /usr/local/var/log/nagios/nagios.log

# Restart service
brew services restart nagios
```

### Website Not Accessible
```bash
# Check bucket policy
aws s3api get-bucket-policy --bucket YOUR_BUCKET_NAME

# Check public access block
aws s3api get-public-access-block --bucket YOUR_BUCKET_NAME

# Verify files uploaded
aws s3 ls s3://YOUR_BUCKET_NAME/
```

---

## 💡 Key Features & Benefits

### Automation Benefits
- ⚡ Deploy in 3 minutes vs 30 minutes manual
- 🔄 Repeatable and consistent deployments
- 📝 Infrastructure as Code documentation
- 🚀 Zero-downtime deployments possible

### Monitoring Benefits
- 👀 Real-time availability tracking
- ⏱️ Performance metrics
- 🚨 Instant alerts on issues
- 📊 Historical data and trends

### Professional Skills Demonstrated
- Cloud infrastructure (AWS)
- Configuration management (Ansible)
- Infrastructure as Code (Terraform)
- Monitoring and alerting (Nagios)
- Containerization (Docker)
- CI/CD concepts

---

## 📚 Additional Resources

### AWS S3 Static Website Hosting
- [AWS S3 Documentation](https://docs.aws.amazon.com/s3/)
- [Static Website Hosting Guide](https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html)

### Ansible
- [Ansible Documentation](https://docs.ansible.com/)
- [AWS Modules](https://docs.ansible.com/ansible/latest/collections/amazon/aws/)

### Terraform
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [S3 Bucket Resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)

### Nagios
- [Nagios Documentation](https://www.nagios.org/documentation/)
- [Nagios Plugins](https://www.nagios.org/downloads/nagios-plugins/)

---

## 🎯 Next Steps

1. **Practice the demo flow** multiple times
2. **Customize monitoring checks** for your needs
3. **Add CloudFront** for global CDN
4. **Implement CI/CD** with Jenkins/GitHub Actions
5. **Add automated testing** to deployment pipeline
6. **Set up email alerts** in Nagios
7. **Create custom dashboards** for metrics

---

## 📞 Support

For issues or questions:
1. Check the troubleshooting section
2. Review AWS CloudWatch logs
3. Check Nagios logs
4. Verify AWS credentials and permissions

---

**Built with ❤️ for DevOps Excellence**
