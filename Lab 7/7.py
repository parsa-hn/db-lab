import pymongo
import requests
from types import SimpleNamespace

url = 'https://www.sahamyab.com/guest/twiter/list?v=0.1'
client = pymongo.MongoClient("mongodb://localhost:27017/")

db = client["db-lab-7-twitter"]

collection = db['twitts']

docCount = 0

while docCount < 100:
    try:
        response = requests.get(url, timeout=10)
        jsonData = response.json()

        for document in jsonData['items']:
            document['_id'] = document.pop('id')
            if (collection.find({'_id': document['_id']}).count() > 0):
                continue
            collection.insert_one(document)
            docCount += 1
            
    except BaseException as e:
        print('Failed to do: ' + str(e))