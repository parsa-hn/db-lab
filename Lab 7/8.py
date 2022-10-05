import requests
import json
import time
from pymongo import MongoClient
import tarfile
import os
client = MongoClient()
db = client['db-lab-8']
url = 'https://randomuser.me/api/'
api_sleep = 10
api_limit = 5000
total = 100000
#db.users.remove({})
fetched = db.users.count()
while fetched < total:
    response = requests.request('GET', url, params={'nat':'ir','results':api_limit})
    if response.status_code == requests.codes.ok:
        data = response.json()['results']
        try:
            db.users.insert_many(data)
        except Exception as e:
            print("Mongo insert exception: "+str(e))
        fetched = db.users.count()
    else:
        print("Response code error: "+str(response.status_code))
        print("Trying again")
    print(f'Fetched and inserted {fetched} users so far')
    print(f'Waiting for {api_sleep} seconds...')
    time.sleep(api_sleep)
fetched = db.users.count()
print(f'Successfully fetched and inserted {fetched} users into the db.')
with open('users.json', 'w') as file:
    file.write('[')
    for document in db.users.find({}, {'_id': False}):
        file.write(json.dumps(document))
        file.write(',')
    file.write(']')
with tarfile.open('users.tar.gz','w:gz') as tar:
    tar.add('users.json')
os.remove('users.json')