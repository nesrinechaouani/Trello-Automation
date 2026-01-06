from pymongo import MongoClient
import json
import os

# Environment variables
MONGO_URI = os.getenv("MONGO_URI")
MONGO_DB = os.getenv("MONGO_DB")
MONGO_COLLECTION = os.getenv("MONGO_COLLECTION")

# Global MongoDB client reused between Lambda calls
mongo_client = None

def get_mongo_client():
    global mongo_client
    if mongo_client is None:
        mongo_client = MongoClient(MONGO_URI, tls=True, serverSelectionTimeoutMS=20000)
    return mongo_client


def lambda_handler(event, context):
    print("Received event:", json.dumps(event))

    # Trello webhook validation (GET/HEAD)
    method = event["requestContext"]["http"]["method"]
    if method in ["GET", "HEAD"]:
        return {"statusCode": 200, "body": "OK"}

    # Parse incoming JSON
    try:
        body = json.loads(event.get("body", "{}"))
    except:
        return {"statusCode": 400, "body": "Invalid JSON"}

    action = body.get("action", {})
    if not action:
        return {"statusCode": 200, "body": "No action"}

    # Process only card updates
    if action.get("type") != "updateCard":
        return {"statusCode": 200, "body": "Ignored"}

    data = action.get("data", {})
    card = data.get("card", {})
    board = data.get("board", {})
    list_info = data.get("list", {}) 

    # Only archived cards
    if not card.get("closed"):
        return {"statusCode": 200, "body": "Not archived"}

    # Prepare document
    document = {
        "cardId": card.get("id"),
        "name": card.get("name"),
        #"description": card.get("desc"),
        "shortUrl": f"https://trello.com/c/{card.get('shortLink')}",
        "dateClosed": card.get("dateClosed") or action.get("date"),
        "boardId": board.get("id"),
        "boardName": board.get("name"),
        "listId": list_info.get("id"),
        "listName": list_info.get("name"),
        "archivedAt": action.get("date"),  # Trello action timestamp
     # User that archived the card
       # "archivedBy": {
        #    "id": action.get("memberCreator", {}).get("id"),
         #   "username": action.get("memberCreator", {}).get("username"),
        "archivedBy": action.get("memberCreator", {}).get("fullName")
        
    }

    # Insert into MongoDB
    try:
        client = get_mongo_client()
        db = client[MONGO_DB]
        collection = db[MONGO_COLLECTION]

        result = collection.insert_one(document)

        print("Inserted ID:", result.inserted_id)

        return {
            "statusCode": 200,
            "body": json.dumps({"status": "saved", "insertedId": str(result.inserted_id)})
        }

    except Exception as e:
        print("MongoDB error:", str(e))
        return {
            "statusCode": 500,
            "body": f"MongoDB error: {str(e)}"
        }
