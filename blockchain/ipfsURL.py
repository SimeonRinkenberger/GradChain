import requests
import os
from multiformats_cid import make_cid


projectId = "2NeMxsfMrWf7CUm0EGm7JKTgMa4"
projectSecret = "28ff2fb5c76ea0bc1dc86c5ddf970cda"
endpoint = "https://ipfs.infura.io:5001"

### Create an array for file ###
dir_name = '/Users/Owner/OneDrive/Documents/School/EGR302/files/'

items = {}
for f in os.listdir(dir_name):
    item = open(dir_name + f, 'rb')
    items[f] = item

### ADD FILE TO IPFS AND SAVE THE HASH ###
response1 = requests.post(endpoint + '/api/v0/add', files=items, auth=(projectId, projectSecret))
print(response1)
hash = response1.text.split(",")[1].split(":")[1].replace('"','')
print(hash)
newHash = make_cid(hash)
print("https://ipfs.io/ipfs/"+str(newHash.to_v1()))
# print(is_cid(str(newHash.to_v1())))
print()
