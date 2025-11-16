# 🚀 Quick Start Guide - StudyVerse DevOps Project

## For Your Mac Friend - 5 Minute Setup

### Step 1: Install Tools (One-time, 10 minutes)
```bash
# Install Homebrew (if not installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install required tools
brew install awscli ansible

# Configure AWS credentials
aws configure
# Enter your AWS Access Key ID
# Enter your AWS Secret Access Key  
# Region: us-east-1
# Output: json
```

### Step 2: Check Prerequisites
```bash
cd Online-Courses/scripts
chmod +x check-prerequisites.sh
./check-prerequisites.sh
```

### Step 3: Deploy Website (3 minutes)
```bash
cd ../ansible
ansible-playbook playbooks/ansible-only-deploy.yml
```

**That's it!** Your website is now live on AWS! 🎉

The output will show your website URL like:
```
Website URL: http://studyverse-online-courses-1234567890.s3-website-us-east-1.amazonaws.com
```

---

## What Just Happened?

Ansible automatically:
1. ✅ Created a unique S3 bucket
2. ✅ Uploaded all your website files
3. ✅ Configured static website hosting
4. ✅ Set public access permissions
5. ✅ Gave you a live URL

**Time saved:** 27 minutes (3 min vs 30 min manual)

---

## Optional: Add Monitoring (5 minutes)

```bash
cd ../nagios
chmod +x setup-nagios-mac.sh
./setup-nagios-mac.sh

# After deployment, update with your URL
./update-monitoring-url.sh YOUR_WEBSITE_URL

# Open dashboard
open http://localhost:8080/nagios
```

---

## Cleanup When Done

```bash
cd ../ansible
ansible-playbook playbooks/ansible-cleanup.yml
```

This removes all AWS resources and stops billing.

---

## Test Locally First (Optional)

```bash
cd scripts
./local-test.sh
# Opens website at http://localhost:8000
```

---

## Troubleshooting

### "AWS credentials not configured"
```bash
aws configure
# Enter your credentials
```

### "Command not found: ansible"
```bash
brew install ansible
```

### "Permission denied"
```bash
chmod +x *.sh
```

---

## Full Documentation

- **Complete Setup:** See `DEVOPS_SETUP_GUIDE.md`
- **Mac Checklist:** See `MAC_SETUP_CHECKLIST.md`
- **DevOps Details:** See `README_DEVOPS.md`

---

## Demo Flow (10 minutes)

1. **Deploy** (3 min): `ansible-playbook playbooks/ansible-only-deploy.yml`
2. **Verify** (2 min): `ansible-playbook playbooks/verify-deployment.yml`
3. **Monitor** (3 min): Show Nagios dashboard
4. **Cleanup** (2 min): `ansible-playbook playbooks/ansible-cleanup.yml`

---

**Questions?** Check the troubleshooting section in `DEVOPS_SETUP_GUIDE.md`

**Ready to impress?** Practice the demo flow 2-3 times before presenting! 🎯
