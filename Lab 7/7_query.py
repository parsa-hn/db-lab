import pymongo

client = pymongo.MongoClient("mongodb://localhost:27017/")
db = client["db-lab-7-twitter"]
collection = db['twitts']

collection.aggregate([{"$group" : {'_id':"$senderUsername", 'count':{'$sum':1}}}])


# for document in collection.find({'senderUsername': 'javadranjbar136'}):
#     print(document)