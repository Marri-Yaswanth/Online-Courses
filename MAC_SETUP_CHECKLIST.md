# Mac Setup Checklist for StudyVerse DevOps Project

## ✅ Pre-Demo Setup (Do Once)

### 1. Install Homebrew
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
- [ ] Homebrew installed
- [ ] Run `brew --version` to verify

### 2. Install AWS CLI
```bash
brew install awscli
```
- [ ] AWS CLI installed
- [ ] Run `aws --version` to verify

### 3. Install Ansible
```bash
brew install ansible
```
- [ ] Ansible installed
- [ ] Run `ansible --version` to verify

### 4. Install Terraform (Optional)
```bash
brew install terraform
```
- [ ] Terraform installed
- [ ] Run `terraform --version` to verify

### 5. Install Docker (Optional - for local testing)
```bash
brew install --cask docker
```
- [ ] Docker installed
- [ ] Open Docker Desktop app
- [ ] Run `docker --version` to verify

### 6. Configure AWS Credentials
```bash
aws configure
```
Enter:
- [ ] AWS Access Key ID
- [ ] AWS Secret Access Key
- [ ] Default region: `us-east-1`
- [ ] Default output format: `json`

Verify:
```bash
aws sts get-caller-identity
```
- [ ] AWS credentials working

### 7. Setup Nagios (One-time)
```bash
cd Online-Courses/nagios
chmod +x setup-nagios-mac.sh
./setup-nagios-mac.sh
```
- [ ] Nagios installed
- [ ] Nagios running
- [ ] Can access http://localhost:8080/nagios

---

## 🎬 Demo Day Checklist

### Before Demo
- [ ] AWS credentials configured and tested
- [ ] Nagios running (`brew services list | grep nagios`)
- [ ] No existing deployments (`aws s3 ls | grep studyverse`)
- [ ] Terminal ready in `Online-Courses` directory
- [ ] Browser tabs ready:
  - [ ] Nagios dashboard (http://localhost:8080/nagios)
  - [ ] AWS S3 Console (optional)

### Demo Flow (10 minutes)

#### Part 1: Ansible Deployment (3 min)
```bash
cd ansible
ansible-playbook playbooks/ansible-only-deploy.yml
```
- [ ] Show deployment output
- [ ] Copy website URL from output
- [ ] Open website URL in browser
- [ ] Show website is live

#### Part 2: Verification (2 min)
```bash
ansible-playbook playbooks/verify-deployment.yml
```
- [ ] Show verification checks passing
- [ ] Explain what's being verified

#### Part 3: Monitoring (3 min)
```bash
cd ../nagios
./update-monitoring-url.sh YOUR_WEBSITE_URL
```
- [ ] Open Nagios dashboard
- [ ] Show real-time monitoring
- [ ] Explain checks (HTTP, response time, content)
- [ ] Show service status

#### Part 4: Cleanup (2 min)
```bash
cd ../ansible
ansible-playbook playbooks/ansible-cleanup.yml
```
- [ ] Show cleanup output
- [ ] Verify resources removed
- [ ] Explain cost savings

### After Demo
- [ ] Cleanup any remaining resources
- [ ] Stop Nagios if not needed (`brew services stop nagios`)

---

## 🔧 Troubleshooting Checklist

### If AWS Commands Fail
- [ ] Check credentials: `aws sts get-caller-identity`
- [ ] Reconfigure: `aws configure`
- [ ] Check IAM permissions (S3 full access needed)

### If Ansible Fails
- [ ] Check AWS CLI works: `aws s3 ls`
- [ ] Check Ansible version: `ansible --version`
- [ ] Check Python version: `python3 --version`

### If Nagios Not Working
- [ ] Check if running: `brew services list`
- [ ] Restart: `brew services restart nagios`
- [ ] Check logs: `tail -f /usr/local/var/log/nagios/nagios.log`
- [ ] Verify config: `sudo nagios -v /usr/local/etc/nagios/nagios.cfg`

### If Website Not Accessible
- [ ] Wait 30 seconds for S3 propagation
- [ ] Check bucket exists: `aws s3 ls`
- [ ] Check files uploaded: `aws s3 ls s3://YOUR_BUCKET_NAME/`
- [ ] Check bucket policy: `aws s3api get-bucket-policy --bucket YOUR_BUCKET_NAME`

---

## 📝 Demo Script Notes

### Key Points to Mention

**Ansible Benefits:**
- Deploys in 3 minutes vs 30 minutes manual
- Repeatable and consistent
- Infrastructure as Code
- Easy cleanup

**Monitoring Benefits:**
- Real-time availability tracking
- Performance metrics
- Instant alerts
- Professional dashboard

**Skills Demonstrated:**
- Cloud infrastructure (AWS S3)
- Automation (Ansible)
- Monitoring (Nagios)
- DevOps best practices
- Infrastructure as Code

### Questions You Might Get

**Q: Why Ansible instead of manual deployment?**
A: Automation reduces deployment time by 90%, eliminates human error, and provides consistent, repeatable deployments.

**Q: Why S3 for hosting?**
A: S3 is cost-effective, scalable, highly available, and perfect for static websites. Can add CloudFront CDN for global distribution.

**Q: What about security?**
A: Using IAM roles, bucket policies, and can add CloudFront with SSL/TLS for HTTPS. Public access is intentional for demo website.

**Q: How much does this cost?**
A: S3 hosting is very cheap - typically $0.50-2/month for small sites. First 12 months free tier available.

**Q: Can this scale?**
A: Yes! S3 automatically scales. Can add CloudFront CDN for global distribution and better performance.

---

## 🎯 Practice Runs

Before demo day, practice the complete flow:

### Practice Run 1
- [ ] Complete deployment
- [ ] Time each phase
- [ ] Note any issues

### Practice Run 2
- [ ] Smooth deployment
- [ ] Practice explanations
- [ ] Test Q&A responses

### Practice Run 3
- [ ] Full demo with timing
- [ ] Record if possible
- [ ] Final polish

---

## 📦 Backup Plan

If something goes wrong during demo:

### Plan A: Live Demo
- Use Ansible for deployment
- Show real-time monitoring

### Plan B: Pre-deployed
- Deploy before demo
- Show monitoring and management
- Explain deployment process

### Plan C: Local Demo
- Use Docker for local hosting
- Show Ansible playbooks
- Explain cloud deployment

---

## ✨ Success Criteria

- [ ] Website deploys successfully
- [ ] Monitoring shows green status
- [ ] Demo completes in 10 minutes
- [ ] Can answer questions confidently
- [ ] Cleanup works properly

---

**Good luck with your demo! 🚀**
