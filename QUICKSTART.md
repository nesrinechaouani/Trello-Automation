# Quick Start Guide

Get your Trello-MongoDB archiver up and running in 15 minutes!

## 🎯 Prerequisites Checklist

- [ ] AWS account
- [ ] Trello account with board access
- [ ] MongoDB Atlas account (free tier)
- [ ] AWS CLI installed
- [ ] Git installed

## 🚀 5-Step Setup

### Step 1: Clone & Configure (2 min)

```bash
# Clone repository
git clone https://github.com/yourusername/trello-mongodb-archiver.git
cd trello-mongodb-archiver

# Copy environment template
cp .env.example .env

# Edit with your credentials
nano .env
```

Fill in:
- `MONGO_URI` - From MongoDB Atlas connection string
- `TRELLO_API_KEY` - From https://trello.com/app-key
- `TRELLO_TOKEN` - Generate from API key page
- `TRELLO_BOARD_ID` - From your Trello board URL

### Step 2: Deploy Lambda (3 min)

```bash
# Make scripts executable (if not already)
chmod +x scripts/*.sh

# Deploy to AWS
./scripts/deploy.sh
```

The script will:
- ✓ Install Python dependencies
- ✓ Create deployment package
- ✓ Upload to Lambda
- ✓ Display function URL

### Step 3: Set Environment Variables (2 min)

In AWS Lambda console:
1. Go to your `trelloWebhookHandler` function
2. Configuration → Environment variables
3. Add:
   - `MONGO_URI`
   - `MONGO_DB` = `your_db03`
   - `MONGO_COLLECTION` = `archived_cards`

### Step 4: Get API Gateway URL (1 min)

In AWS API Gateway console:
1. Find your API (e.g., `trello-webhook-api`)
2. Copy the invoke URL
3. Your webhook URL = `{Invoke URL}/trello`

Example: `https://abc123.execute-api.eu-west-1.amazonaws.com/trello`

### Step 5: Register Webhook (2 min)

```bash
# Set environment variables (if using .env)
export TRELLO_API_KEY=your_key
export TRELLO_TOKEN=your_token
export TRELLO_BOARD_ID=your_board_id
export WEBHOOK_CALLBACK_URL=your_api_gateway_url/trello

# Register webhook
./scripts/register-webhook.sh
```

## ✅ Test It!

1. **Test Endpoint**:
   ```bash
   ./scripts/test-webhook.sh https://your-api-url/trello
   ```

2. **Test Archive**:
   - Open your Trello board
   - Create a test card
   - Archive the card
   - Check MongoDB for new document!

3. **View Logs**:
   ```bash
   aws logs tail /aws/lambda/trelloWebhookHandler --follow
   ```

## 🎉 You're Done!

Your integration is now live! Every time a card is archived:
1. Trello sends webhook event
2. Lambda processes and normalizes data
3. Card info stored in MongoDB

## 🔍 Verify Setup

### Check MongoDB

```javascript
// In MongoDB Compass or Shell
use your_db03
db.archived_cards.find().sort({ archivedAt: -1 }).limit(5)
```

### Check Lambda Logs

AWS Console → CloudWatch → Log Groups → `/aws/lambda/trelloWebhookHandler`

### Check Webhook Status

```bash
curl "https://api.trello.com/1/tokens/YOUR_TOKEN/webhooks?key=YOUR_KEY"
```

## 🆘 Troubleshooting

| Problem | Solution |
|---------|----------|
| Webhook not firing | Verify callback URL in webhook config |
| Lambda timeout | Check MongoDB connection string |
| 403 errors | Re-create API Gateway integration |
| No data in MongoDB | Check Lambda environment variables |

## 📚 Next Steps

- [ ] Set up CloudWatch alarms
- [ ] Create MongoDB indexes
- [ ] Add error notifications
- [ ] Customize data fields
- [ ] Build analytics dashboard

## 🔗 Useful Links

- [Full Setup Guide](docs/setup-guide.md)
- [API Reference](docs/api-reference.md)
- [Lambda Function Code](src/lambda_function.py)
- [Deployment Scripts](scripts/)

## 💡 Pro Tips

1. **Test locally first**: Set env vars and run Lambda function locally
2. **Use CloudWatch**: Monitor invocations and errors
3. **Create indexes**: Speed up MongoDB queries
4. **Version control**: Use Git tags for deployments
5. **Backup**: Export MongoDB data regularly

## 🎓 Learn More

- Read the full [Setup Guide](docs/setup-guide.md) for detailed instructions
- Check [API Reference](docs/api-reference.md) for data structures
- Explore [Terraform configs](terraform/) for IaC deployment

---

**Questions?** Open an issue on GitHub!

**Found a bug?** Please report it with logs and steps to reproduce.

**Want to contribute?** See [CONTRIBUTING.md](CONTRIBUTING.md)
