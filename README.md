# Trello Card Archiver to MongoDB

![Architecture Diagram](docs/architecture.png)

A serverless integration that automatically archives Trello cards to MongoDB when they are closed, using AWS Lambda, API Gateway, and Trello Webhooks.

## 🏗️ Architecture

```
Trello Board → Webhook → API Gateway → Lambda Function → MongoDB Atlas
```

### Components

1. **Trello Layer**: Monitors card archival events
2. **AWS Integration Layer**: API Gateway + Lambda for event processing
3. **Database Layer**: MongoDB Atlas for persistent storage

## ✨ Features

- ✅ Automatic webhook registration with Trello
- ✅ Real-time card archival tracking
- ✅ Normalized data storage in MongoDB
- ✅ Serverless architecture (no infrastructure to maintain)
- ✅ Efficient connection pooling for Lambda
- ✅ Comprehensive error handling

## 📋 Prerequisites

- AWS Account with Lambda and API Gateway access
- Trello Account with API credentials
- MongoDB Atlas cluster
- Python 3.9+ (for local development)

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/trello-mongodb-archiver.git
cd trello-mongodb-archiver
```

### 2. Deploy Lambda Function

1. Package the function with dependencies:
   ```bash
   cd src
   pip install -r requirements.txt -t .
   zip -r ../function.zip .
   ```

2. Upload to AWS Lambda or use the AWS CLI:
   ```bash
   aws lambda update-function-code \
     --function-name trelloWebhookHandler \
     --zip-file fileb://function.zip
   ```

### 3. Configure Environment Variables

Set these in your Lambda function configuration:

| Variable | Description | Example |
|----------|-------------|---------|
| `MONGO_URI` | MongoDB connection string | `mongodb+srv://user:pass@cluster.mongodb.net/` |
| `MONGO_DB` | Database name | `your_db` |
| `MONGO_COLLECTION` | Collection name | `archived_cards` |
| `WEBHOOK_CALLBACK_URL` | API Gateway URL | `https://xxxxx.execute-api.region.amazonaws.com/trello` |

### 4. Set Up API Gateway

1. Create an HTTP API in API Gateway
2. Add route: `ANY /trello`
3. Integrate with your Lambda function
4. Deploy and note the invoke URL

### 5. Register Trello Webhook

```bash
curl -X POST "https://api.trello.com/1/webhooks/?key=YOUR_KEY&token=YOUR_TOKEN" \
  -d "callbackURL=https://YOUR_API_GATEWAY_URL/trello" \
  -d "idModel=YOUR_BOARD_ID" \
  -d "description=Archive cards to MongoDB" \
  -d "active=true"
```

## 📊 Data Schema

Each archived card is stored with the following structure:

```json
{
  "cardId": "string",
  "name": "string",
  "shortUrl": "string",
  "dateClosed": "ISO date",
  "boardId": "string",
  "boardName": "string",
  "listId": "string",
  "listName": "string",
  "archivedAt": "ISO date",
  "archivedBy": "string"
}
```

## 🔄 Workflow

1. **Card Archived**: User archives a card in Trello (`closed=true`)
2. **Webhook Fired**: Trello sends POST request to API Gateway
3. **Lambda Triggered**: API Gateway invokes Lambda function
4. **Data Processing**: Lambda extracts and normalizes card data
5. **Storage**: Document inserted into MongoDB collection

## 🧪 Testing

### Test API Gateway Connection

```bash
curl -X POST -H "Content-Type: application/json" \
  -d '{"test":"hello"}' \
  https://YOUR_API_GATEWAY_URL/trello
```

### Test Webhook Response

```bash
curl -X GET https://YOUR_API_GATEWAY_URL/trello
```

Should return `200 OK`.

## 🛠️ Development

### Local Testing

1. Install dependencies:
   ```bash
   cd src
   pip install -r requirements.txt
   ```

2. Set environment variables:
   ```bash
   export MONGO_URI="your_mongodb_uri"
   export MONGO_DB="your_db"
   export MONGO_COLLECTION="archived_cards"
   ```

3. Run tests:
   ```bash
   python -m pytest tests/
   ```

## 🔐 Security Best Practices

- ✅ Store credentials in AWS Secrets Manager
- ✅ Use environment variables for configuration
- ✅ Enable TLS for MongoDB connections
- ✅ Restrict API Gateway access with API keys (optional)
- ✅ Use IAM roles for Lambda execution

## 📈 Monitoring

- View Lambda logs in CloudWatch
- Monitor MongoDB Atlas metrics
- Set up CloudWatch alarms for errors

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details

## 📧 Support

For issues and questions, please open an issue in the GitHub repository.

---

**Built with ❤️ using AWS Lambda, Trello API, and MongoDB Atlas**
