# Project Summary

## 📦 Repository Structure

```
trello-mongodb-archiver/
│
├── 📄 README.md                    # Main project documentation
├── 📄 LICENSE                      # MIT License
├── 📄 CONTRIBUTING.md             # Contribution guidelines
├── 📄 QUICKSTART.md               # 15-minute setup guide
├── 📄 .gitignore                  # Git ignore rules
├── 📄 .env.example                # Environment variables template
│
├── 📁 docs/                       # Documentation
│   ├── setup-guide.md            # Complete setup instructions
│   ├── api-reference.md          # API & data structures
│   └── architecture.png          # System diagram
│
├── 📁 src/                        # Source code
│   ├── lambda_function.py        # Main Lambda handler
│   └── requirements.txt          # Python dependencies
│
├── 📁 scripts/                    # Automation scripts
│   ├── deploy.sh                 # Deploy Lambda function
│   ├── register-webhook.sh       # Register Trello webhook
│   ├── test-webhook.sh           # Test webhook endpoint
│   └── show-structure.sh         # Display project structure
│
├── 📁 terraform/                  # Infrastructure as Code
│   ├── main.tf                   # Main Terraform config
│   ├── variables.tf              # Input variables
│   ├── outputs.tf                # Output values
│   └── README.md                 # Terraform documentation
│
└── 📁 .github/
    └── workflows/
        └── deploy.yml             # GitHub Actions CI/CD
```

## 🎯 What This Repository Provides

### ✅ Complete Infrastructure Setup
- AWS Lambda function with proper IAM roles
- API Gateway HTTP API with routes
- CloudWatch logging and monitoring
- Terraform configurations for IaC

### ✅ Production-Ready Code
- Error handling and logging
- Connection pooling for MongoDB
- Webhook validation
- Event filtering and processing

### ✅ Automation Scripts
- One-command deployment
- Webhook registration helper
- Testing utilities
- Structure visualization

### ✅ Comprehensive Documentation
- Quick start guide (15 min setup)
- Detailed setup instructions
- API reference with examples
- Troubleshooting guides

### ✅ CI/CD Pipeline
- GitHub Actions workflow
- Automated deployments
- Environment variable management

## 🚀 Deployment Options

### Option 1: Manual Deployment (Recommended for First Time)
```bash
# 1. Deploy Lambda
./scripts/deploy.sh

# 2. Configure API Gateway (via AWS Console)

# 3. Register webhook
./scripts/register-webhook.sh
```

### Option 2: Terraform (Infrastructure as Code)
```bash
cd terraform
terraform init
terraform apply
```

### Option 3: GitHub Actions (CI/CD)
- Push to main branch
- GitHub Actions automatically deploys
- Requires AWS credentials as secrets

## 📊 Key Features

1. **Real-time Card Archival**: Instant webhook trigger when cards are archived
2. **Normalized Data Storage**: Clean, structured data in MongoDB
3. **Comprehensive Metadata**: Captures card, board, list, and user info
4. **Error Handling**: Robust error handling with detailed logging
5. **Scalable**: Serverless architecture scales automatically
6. **Cost-Effective**: Runs on AWS free tier for moderate usage
7. **Monitored**: CloudWatch alarms for errors and throttling
8. **Documented**: Extensive documentation and examples

## 🔧 Customization Points

### Data Fields
Edit `src/lambda_function.py` to add/remove fields:
```python
document = {
    "cardId": card.get("id"),
    "name": card.get("name"),
    # Add custom fields here
    "customField": card.get("customField"),
}
```

### Event Filtering
Change which events to process:
```python
# Currently: only archived cards
if action.get("type") != "updateCard":
    return {"statusCode": 200, "body": "Ignored"}
```

### Database Schema
Add indexes for better performance:
```javascript
db.archived_cards.createIndex({ "boardId": 1, "archivedAt": -1 })
db.archived_cards.createIndex({ "archivedBy": 1 })
```

## 📈 Analytics Queries

Example MongoDB queries included in documentation:

- Cards archived per board
- Most active archivers
- Archive trends over time
- Cards by list/status

## 🔒 Security Features

- TLS encryption for MongoDB
- Environment variable management
- IAM role-based permissions
- Optional API key authentication
- CloudWatch audit logging

## 🧪 Testing

### Unit Tests (Future Enhancement)
```bash
pytest tests/
```

### Integration Tests
```bash
./scripts/test-webhook.sh YOUR_API_URL
```

### End-to-End Test
Archive a card in Trello and verify in MongoDB

## 📝 Environment Variables

Required in Lambda:
- `MONGO_URI` - MongoDB connection string
- `MONGO_DB` - Database name
- `MONGO_COLLECTION` - Collection name

Required for scripts:
- `TRELLO_API_KEY` - Trello API key
- `TRELLO_TOKEN` - Trello token
- `TRELLO_BOARD_ID` - Board to monitor
- `WEBHOOK_CALLBACK_URL` - API Gateway URL

## 🎓 Learning Resources

This repository demonstrates:
- Serverless architecture patterns
- Webhook integration patterns
- MongoDB data modeling
- AWS Lambda best practices
- Infrastructure as Code
- CI/CD with GitHub Actions

## 🤝 Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for:
- How to report bugs
- How to suggest features
- Pull request process
- Code style guidelines

## 📜 License

MIT License - see [LICENSE](LICENSE) file

## 🆘 Support

- **Issues**: GitHub Issues
- **Documentation**: `/docs` folder
- **Examples**: Code comments
- **Community**: GitHub Discussions (if enabled)

## 🎉 Getting Started

1. Read [QUICKSTART.md](QUICKSTART.md) for fast setup
2. Follow [docs/setup-guide.md](docs/setup-guide.md) for details
3. Check [docs/api-reference.md](docs/api-reference.md) for data structures
4. Run `./scripts/show-structure.sh` to see project layout

## 📦 What You'll Need

**Accounts** (all free tiers available):
- AWS (Lambda + API Gateway)
- MongoDB Atlas
- Trello
- GitHub (for CI/CD)

**Tools**:
- AWS CLI
- Python 3.9+
- Git
- Terraform (optional)

**Time**: 15-30 minutes for complete setup

---

**Built with ❤️ for developers who love automation**

Star ⭐ this repo if you find it useful!
