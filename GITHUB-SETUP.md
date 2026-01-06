# 🚀 GitHub Repository Setup Guide

## Creating Your Repository

### Step 1: Create New Repository on GitHub

1. Go to [GitHub](https://github.com/new)
2. Fill in repository details:
   - **Repository name**: `trello-mongodb-archiver`
   - **Description**: `Serverless integration to automatically archive Trello cards to MongoDB using AWS Lambda`
   - **Visibility**: Public or Private
   - **Don't initialize** with README, .gitignore, or license (we already have them)

### Step 2: Initialize Local Repository

```bash
# Navigate to your project directory (where you extracted these files)
cd trello-mongodb-archiver

# Initialize git repository
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit: Complete Trello-MongoDB archiver integration"

# Add remote origin (replace with your GitHub URL)
git remote add origin https://github.com/YOUR_USERNAME/trello-mongodb-archiver.git

# Push to GitHub
git branch -M main
git push -u origin main
```

### Step 3: Configure GitHub Secrets (for CI/CD)

If you want to use GitHub Actions for automated deployment:

1. Go to your repository on GitHub
2. Settings → Secrets and variables → Actions
3. Click "New repository secret"
4. Add the following secrets:

| Secret Name | Value | Description |
|------------|-------|-------------|
| `AWS_ACCESS_KEY_ID` | Your AWS access key | For AWS CLI authentication |
| `AWS_SECRET_ACCESS_KEY` | Your AWS secret key | For AWS CLI authentication |
| `AWS_REGION` | `eu-west-1` | Your AWS region |
| `LAMBDA_FUNCTION_NAME` | `trelloWebhookHandler` | Your Lambda function name |
| `MONGO_URI` | `mongodb+srv://...` | Your MongoDB connection string |
| `MONGO_DB` | `lookinglass03` | Your database name |
| `MONGO_COLLECTION` | `archived_cards` | Your collection name |

### Step 4: Enable GitHub Actions

1. Go to the "Actions" tab in your repository
2. Enable workflows
3. The workflow will run automatically on:
   - Push to main branch
   - Changes to `src/**` files
   - Manual trigger via "Run workflow" button

### Step 5: Add Repository Topics

Add relevant topics to make your repo discoverable:
- `trello`
- `mongodb`
- `aws-lambda`
- `serverless`
- `webhook`
- `automation`
- `integration`

### Step 6: Create Repository Description

Update your repository's About section with:
```
🔄 Serverless Trello-MongoDB integration using AWS Lambda. Automatically archives Trello cards to MongoDB with webhook triggers. Includes Terraform configs, deployment scripts, and comprehensive documentation.
```

### Step 7: Configure Branch Protection (Optional)

For team projects:
1. Settings → Branches → Add rule
2. Branch name pattern: `main`
3. Enable:
   - Require pull request reviews
   - Require status checks to pass
   - Require branches to be up to date

## 📁 What's Included in This Repository

```
trello-mongodb-archiver/
├── 📄 README.md              # Main documentation
├── 📄 QUICKSTART.md          # 15-minute setup guide
├── 📄 PROJECT-SUMMARY.md     # Project overview
├── 📄 CONTRIBUTING.md        # Contribution guidelines
├── 📄 LICENSE                # MIT License
├── 📄 .gitignore            # Git ignore rules
├── 📄 .env.example          # Environment template
│
├── 📁 docs/                 # Documentation
├── 📁 src/                  # Lambda source code
├── 📁 scripts/              # Deployment scripts
├── 📁 terraform/            # Infrastructure as Code
└── 📁 .github/workflows/    # GitHub Actions
```

## 🎯 Next Steps After Pushing

1. **Add a Star** ⭐ to your own repo (optional but fun!)

2. **Update README badges** (optional):
   ```markdown
   ![AWS Lambda](https://img.shields.io/badge/AWS-Lambda-orange)
   ![MongoDB](https://img.shields.io/badge/Database-MongoDB-green)
   ![Python](https://img.shields.io/badge/Python-3.11-blue)
   ![License](https://img.shields.io/badge/License-MIT-yellow)
   ```

3. **Create a Release**:
   - Go to Releases → Draft a new release
   - Tag version: `v1.0.0`
   - Release title: `Initial Release`
   - Description: Feature list

4. **Enable Discussions** (optional):
   - Settings → General → Features
   - Check "Discussions"

5. **Create Issue Templates**:
   - Settings → Features → Issues → Set up templates
   - Add bug report and feature request templates

## 🔧 Customizing for Your Project

Before pushing, you may want to customize:

1. **Update README.md**:
   - Replace placeholder URLs with your actual repository URL
   - Add your name/organization
   - Update screenshots if you have custom UI

2. **Update .env.example**:
   - Add your specific configuration needs
   - Remove any sensitive information

3. **Customize Lambda Function**:
   - Add your specific data fields
   - Modify event processing logic
   - Add custom error handling

4. **Update Terraform Variables**:
   - Set your default AWS region
   - Adjust resource names
   - Add custom tags

## 📊 Repository Insights

After a few commits, check:
- **Insights → Traffic**: View repository traffic
- **Insights → Commits**: View commit history
- **Insights → Network**: See branch structure
- **Insights → Community**: Check community standards

## 🎓 Best Practices

1. **Write Descriptive Commits**:
   ```bash
   git commit -m "Add MongoDB index for faster queries"
   ```

2. **Use Branches for Features**:
   ```bash
   git checkout -b feature/add-card-description
   # Make changes
   git commit -m "Add card description to MongoDB schema"
   git push origin feature/add-card-description
   # Create pull request on GitHub
   ```

3. **Tag Releases**:
   ```bash
   git tag -a v1.0.0 -m "First stable release"
   git push origin v1.0.0
   ```

4. **Keep Documentation Updated**:
   - Update README when adding features
   - Document breaking changes
   - Add examples for new functionality

## 🚨 Security Reminders

- ✅ **Never commit** `.env` files with credentials
- ✅ **Use GitHub Secrets** for sensitive data
- ✅ **Review** .gitignore before first commit
- ✅ **Rotate credentials** if accidentally committed
- ✅ **Enable** branch protection for production

## 🤝 Collaboration

To collaborate with others:

1. **Invite Collaborators**:
   - Settings → Collaborators
   - Add by GitHub username

2. **Set Up Code Reviews**:
   - Require pull request reviews
   - Assign reviewers automatically

3. **Use Project Boards**:
   - Projects → New project
   - Add issues and track progress

## 📝 Commit Message Examples

Good commit messages:
- `feat: Add support for card labels in MongoDB`
- `fix: Resolve MongoDB connection timeout issue`
- `docs: Update setup guide with Terraform instructions`
- `refactor: Improve error handling in Lambda function`
- `test: Add unit tests for event processing`
- `chore: Update dependencies to latest versions`

## 🎉 You're All Set!

Your repository is now ready to:
- ✅ Be deployed to production
- ✅ Accept contributions
- ✅ Be shared with the community
- ✅ Be discovered by other developers

## 📞 Support

If you need help:
- Read the [QUICKSTART.md](QUICKSTART.md)
- Check [docs/setup-guide.md](docs/setup-guide.md)
- Review [PROJECT-SUMMARY.md](PROJECT-SUMMARY.md)
- Open an issue on GitHub

---

**Happy Coding! 🚀**

Remember to star ⭐ your repository and share it with others who might find it useful!
