# StudyVerse Online Courses - DevOps Implementation

[![AWS](https://img.shields.io/badge/AWS-S3-orange)](https://aws.amazon.com/s3/)
[![Terraform](https://img.shields.io/badge/Terraform-1.5+-purple)](https://terraform.io)
[![Ansible](https://img.shields.io/badge/Ansible-2.9+-red)](https://ansible.com)
[![Nagios](https://img.shields.io/badge/Nagios-4.5+-blue)](https://nagios.org)

A comprehensive online learning platform built with modern DevOps practices, featuring Infrastructure as Code, automated deployment, and real-time monitoring.

## 🌐 Live Demo

**Website:** [http://studyverse-online-courses-prod-382ecd8a.s3-website-us-east-1.amazonaws.com/](http://studyverse-online-courses-prod-382ecd8a.s3-website-us-east-1.amazonaws.com/)

### Demo Credentials
- **User Login:** `user` / `user123`
- **Admin Login:** `admin` / `admin123`

## 🏗️ Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Terraform     │    │     Ansible     │    │     Nagios      │
│Infrastructure   │───▶│   Automation    │───▶│   Monitoring    │
│   as Code       │    │   & Deployment  │    │   & Alerting    │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         ▼                       ▼                       ▼
┌─────────────────────────────────────────────────────────────────┐
│                     AWS S3 Website Hosting                     │
│              StudyVerse Online Learning Platform               │
└─────────────────────────────────────────────────────────────────┘
```

## 🚀 Features

### 📚 Learning Platform
- **Interactive Course Catalog** - Browse available courses
- **User Authentication System** - Secure login/logout functionality
- **Admin Dashboard** - Administrative interface for platform management
- **Responsive Design** - Mobile and desktop compatibility
- **Modern UI/UX** - Clean, professional interface

### ⚙️ DevOps Implementation
- **Infrastructure as Code** - Terraform for AWS resource provisioning
- **Automated Deployment** - Ansible playbooks for CI/CD
- **Real-time Monitoring** - Nagios for 24/7 system monitoring
- **One-Command Deployment** - Streamlined deployment process
- **Environment Management** - Multi-environment support

## 🛠️ Technology Stack

| Layer | Technology | Purpose |
|-------|------------|---------|
| **Frontend** | HTML5, CSS3, JavaScript | User interface and interactions |
| **Hosting** | AWS S3 Static Website | Scalable web hosting |
| **Infrastructure** | Terraform | Infrastructure as Code |
| **Automation** | Ansible | Deployment and configuration |
| **Monitoring** | Nagios | System monitoring and alerting |
| **Version Control** | Git/GitHub | Source code management |

## 📁 Project Structure

```
Online-Courses/
├── 📄 Website Files
│   ├── courses.html          # Main landing page
│   ├── login.html           # Authentication page
│   ├── admin-dashboard.html # Admin interface
│   ├── style.css           # Main stylesheet
│   ├── auth.js             # Authentication logic
│   └── assets/             # Images and resources
├── 🏗️ Infrastructure
│   └── terraform/
│       ├── main.tf         # AWS S3 configuration
│       ├── variables.tf    # Environment variables
│       └── outputs.tf      # Resource outputs
├── 🤖 Automation
│   └── ansible/
│       ├── playbooks/      # Deployment automation
│       └── inventory/      # Environment configs
├── 📊 Monitoring
│   └── nagios/
│       ├── nagios.cfg      # Main configuration
│       └── objects/        # Service definitions
└── 📜 Scripts
    └── scripts/
        ├── sync-to-s3.sh   # Deployment script
        └── setup-*.sh      # Setup utilities
```

## 🚀 Quick Start

### Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform >= 1.0
- Ansible >= 2.9
- Git

### 1. Clone Repository

```bash
git clone https://github.com/Marri-Yaswanth/Online-Courses.git
cd Online-Courses
```

### 2. Deploy Infrastructure

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

### 3. Deploy Application

```bash
# Using Ansible
cd infrastructure/ansible
ansible-playbook playbooks/ansible-only-deploy.yml

# Or using sync script
cd deployment/scripts
./sync-to-s3.sh
```

### 4. Setup Monitoring

```bash
cd infrastructure/nagios
./setup-nagios-mac.sh  # For macOS
# Or follow Windows setup guide for Windows
```

## 📋 Installation Guides

### macOS Setup

```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install tools
brew install awscli terraform ansible nagios nagios-plugins

# Configure AWS
aws configure
```

### Windows Setup

```powershell
# Install Chocolatey (Run as Administrator)
Set-ExecutionPolicy Bypass -Scope Process -Force
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Install tools
choco install awscli terraform python -y
pip install ansible

# For Nagios (Docker method recommended)
choco install docker-desktop -y
docker run -d --name nagios -p 8080:80 jasonrivers/nagios:latest
```

### Linux Setup

```bash
# Ubuntu/Debian
sudo apt update
sudo apt install -y awscli terraform ansible nagios4 nagios-plugins-contrib

# Configure AWS
aws configure
```

## 🔧 Configuration

### Environment Variables

Create a `.env` file or set environment variables:

```bash
export AWS_REGION=us-east-1
export PROJECT_NAME=studyverse-online-courses
export ENVIRONMENT=prod
```

### Terraform Variables

Edit `terraform/variables.tf`:

```hcl
variable "aws_region" {
  default = "us-east-1"
}

variable "project_name" {
  default = "studyverse-online-courses"
}

variable "environment" {
  default = "prod"
}
```

## 📊 Monitoring

### Nagios Dashboard

Access monitoring at:
- **Local:** `http://localhost:8080/nagios`
- **Credentials:** `nagiosadmin` / `nagios`

### Monitored Services

- ✅ Website availability
- ⏱️ Response time (< 2s warning, < 5s critical)
- 🖥️ System resources (CPU, memory, disk)
- 🌐 HTTP accessibility
- 📈 Performance metrics

## 🔄 Deployment Process

### Automated Deployment

```bash
# Single command deployment
./scripts/sync-to-s3.sh
```

### Manual Deployment Steps

1. **Infrastructure:** `terraform apply`
2. **Application:** `ansible-playbook playbooks/ansible-only-deploy.yml`
3. **Verification:** Check Nagios dashboard
4. **Cleanup:** `ansible-playbook playbooks/ansible-cleanup.yml`

## 🛡️ Security

- **S3 Bucket Policies** - Restricted public access for web content only
- **IAM Roles** - Least privilege access principles
- **Input Validation** - Form validation and sanitization
- **HTTPS Ready** - CloudFront integration available
- **Access Logging** - AWS CloudTrail integration

## 📈 Performance

- **Deployment Time:** < 5 minutes
- **Response Time:** < 2 seconds average
- **Uptime Target:** 99.9%
- **Cost:** < $5/month for typical usage
- **Global CDN Ready** - CloudFront integration available

## 🧪 Testing

### Local Testing

```bash
# Test website locally
docker-compose up -d
open http://localhost:8080
```

### Deployment Testing

```bash
# Dry run deployment
./scripts/s3-dry-run.sh . studyverse-online-courses-prod-382ecd8a

# Verify deployment
ansible-playbook playbooks/verify-deployment.yml
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📚 Documentation

- [DevOps Setup Guide](DEVOPS_SETUP_GUIDE.md)
- [Complete Technical Documentation](COMPLETE_TECHNICAL_DOCUMENTATION.md)
- [Mac Installation Guide](MAC_INSTALLATION_GUIDE.md)
- [Quick Start Guide](QUICK_START.md)

## 🐛 Troubleshooting

### Common Issues

**Terraform Issues:**
```bash
# State lock issues
terraform force-unlock <LOCK_ID>

# Provider issues
terraform init -upgrade
```

**Ansible Issues:**
```bash
# Connection issues
ansible all -m ping -i inventory/hosts

# Verbose output
ansible-playbook playbooks/deploy.yml -vvv
```

**Nagios Issues:**
```bash
# Check configuration
nagios -v /path/to/nagios.cfg

# Restart service
sudo systemctl restart nagios
```

## 📊 Project Metrics

- **Lines of Code:** 2,000+
- **Configuration Files:** 25+
- **Automation Scripts:** 10+
- **Documentation Pages:** 15+
- **Deployment Time:** 3-5 minutes
- **Infrastructure Components:** 5+ AWS resources

## 🎯 Future Enhancements

### Short-term (1-3 months)
- [ ] SSL/TLS implementation via CloudFront
- [ ] Database integration for user management
- [ ] CI/CD pipeline with GitHub Actions
- [ ] Enhanced monitoring with CloudWatch

### Long-term (3-12 months)
- [ ] Multi-region deployment
- [ ] Auto-scaling capabilities
- [ ] Mobile application
- [ ] Advanced analytics dashboard

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Marri Yaswanth**
- GitHub: [@Marri-Yaswanth](https://github.com/Marri-Yaswanth)
- Project: [Online-Courses](https://github.com/Marri-Yaswanth/Online-Courses)

## 🙏 Acknowledgments

- AWS for cloud infrastructure
- Terraform for Infrastructure as Code
- Ansible for automation capabilities
- Nagios for monitoring solutions
- Open source community for tools and resources

---

⭐ **Star this repository if you found it helpful!**

📧 **Questions?** Open an issue or reach out via GitHub.

🚀 **Ready to deploy?** Follow the Quick Start guide above!