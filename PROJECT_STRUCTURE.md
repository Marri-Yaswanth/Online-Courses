# StudyVerse Project Structure

## 📁 Organized Project Layout

```
Online-Courses/
├── 📄 Root Files
│   ├── README.md                    # Main project documentation
│   ├── .gitignore                   # Git ignore rules
│   ├── .dockerignore               # Docker ignore rules
│   └── PROJECT_STRUCTURE.md        # This file
│
├── 🌐 Source Code (src/)
│   ├── 📄 HTML Files
│   │   ├── courses.html            # Main landing page
│   │   ├── login.html              # Authentication page
│   │   └── admin-dashboard.html    # Admin interface
│   │
│   ├── 🎨 Stylesheets (css/)
│   │   ├── style.css               # Main stylesheet
│   │   ├── login.css               # Login page styles
│   │   └── admin.css               # Admin dashboard styles
│   │
│   ├── ⚡ JavaScript (js/)
│   │   ├── script.js               # Main JavaScript
│   │   ├── auth.js                 # Authentication logic
│   │   └── admin.js                # Admin functionality
│   │
│   └── 🖼️ Assets (assets/)
│       ├── images/                 # Course images, backgrounds
│       │   ├── course 1.jpeg
│       │   ├── course 2.jpeg
│       │   ├── background1.jpeg
│       │   └── ...
│       ├── logos/                  # Brand logos and icons
│       │   ├── studyverse-high-resolution-logo.png
│       │   ├── logo 1.png
│       │   └── ...
│       └── icons/                  # UI icons
│           └── icons8-graduate-48.png
│
├── 🏗️ Infrastructure (infrastructure/)
│   ├── 🔧 Terraform (terraform/)
│   │   ├── main.tf                 # AWS S3 configuration
│   │   ├── variables.tf            # Environment variables
│   │   ├── outputs.tf              # Resource outputs
│   │   ├── .terraform.lock.hcl     # Provider lock file
│   │   └── terraform.tfstate       # State file (local)
│   │
│   ├── 🤖 Ansible (ansible/)
│   │   ├── playbooks/              # Automation playbooks
│   │   │   ├── ansible-only-deploy.yml
│   │   │   ├── verify-deployment.yml
│   │   │   ├── ansible-cleanup.yml
│   │   │   └── s3-sync.yml
│   │   ├── inventory/              # Environment configs
│   │   │   └── hosts
│   │   ├── ansible.cfg             # Ansible configuration
│   │   └── deployment-info.txt     # Deployment notes
│   │
│   └── 📊 Nagios (nagios/)
│       ├── nagios.cfg              # Main Nagios config
│       ├── cgi.cfg                 # CGI configuration
│       ├── objects/                # Service definitions
│       │   └── studyverse-website.cfg
│       ├── setup-nagios-mac.sh     # macOS setup script
│       └── update-monitoring-url.sh # URL update script
│
├── 🚀 Deployment (deployment/)
│   ├── 📜 Scripts (scripts/)
│   │   ├── sync-to-s3.sh           # Main deployment script
│   │   ├── sync-specific-bucket.sh # Bucket-specific sync
│   │   ├── s3-dry-run.sh           # Preview changes
│   │   ├── check-prerequisites.sh   # Environment check
│   │   ├── local-test.sh           # Local testing
│   │   └── nagios-port-forward.sh  # Port forwarding
│   │
│   └── 🐳 Docker (docker/)
│       ├── Dockerfile              # Container definition
│       ├── docker-compose.yml      # Multi-container setup
│       └── nginx.conf              # Nginx configuration
│
├── 🧪 Tests (tests/)
│   ├── smoke-test.sh               # Basic functionality tests
│   ├── package-lock.json           # NPM dependencies
│   └── Jenkinsfile                 # CI/CD pipeline
│
└── 📚 Documentation (docs/)
    ├── README_DEVOPS.md            # DevOps specific guide
    ├── DEVOPS_SETUP_GUIDE.md       # Setup instructions
    ├── MAC_INSTALLATION_GUIDE.md   # macOS specific guide
    ├── MAC_SETUP_CHECKLIST.md      # macOS checklist
    ├── COMPLETE_TECHNICAL_DOCUMENTATION.md
    ├── DOCUMENTATION_INDEX.md      # Documentation index
    ├── QUICK_START.md              # Quick start guide
    ├── START_HERE.md               # Getting started
    ├── ARCHITECTURE_DIAGRAM.txt    # System architecture
    ├── PROJECT_SUMMARY.txt         # Project summary
    └── PROJECT_REPORT_FORMATTED.docx # Final report
```

## 🎯 Benefits of This Structure

### ✅ **Separation of Concerns**
- **Source code** (`src/`) - All website files
- **Infrastructure** (`infrastructure/`) - DevOps configurations
- **Deployment** (`deployment/`) - Automation scripts
- **Documentation** (`docs/`) - All project documentation
- **Tests** (`tests/`) - Testing and CI/CD files

### ✅ **Scalability**
- Easy to add new components
- Clear file organization
- Modular structure
- Environment separation

### ✅ **Maintainability**
- Logical file grouping
- Easy to find specific files
- Clear naming conventions
- Consistent organization

### ✅ **Professional Standards**
- Industry-standard project layout
- Clear separation of assets
- Organized documentation
- Proper version control structure

## 🔄 Migration Impact

### Updated File Paths
- **CSS:** `style.css` → `css/style.css`
- **JavaScript:** `script.js` → `js/script.js`
- **Images:** `logo.png` → `assets/logos/logo.png`
- **Scripts:** `sync-to-s3.sh` → `deployment/scripts/sync-to-s3.sh`

### Updated References
- HTML files updated to use new asset paths
- Deployment scripts updated for new source directory
- Documentation moved to dedicated docs folder

## 🚀 Usage After Restructuring

### Deployment
```bash
# From project root
cd deployment/scripts
./sync-to-s3.sh
```

### Infrastructure
```bash
# Terraform
cd infrastructure/terraform
terraform apply

# Ansible
cd infrastructure/ansible
ansible-playbook playbooks/ansible-only-deploy.yml
```

### Local Development
```bash
# Docker
cd deployment/docker
docker-compose up -d

# Access at http://localhost:8080
```

This structure follows industry best practices and makes the project more professional and maintainable! 🎉