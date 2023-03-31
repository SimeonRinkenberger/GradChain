import requests
import base64

INFURA_PROJECT_ID = "2Nia36psZhuJRKW5X9AxNzIOQ0q"
INFURA_PROJECT_SECRET = "204dc57525ec7ff705eae55165772478"
INFURA_API_URL = f"https://ipfs.infura.io:5001/api/v0/add?project_id={INFURA_PROJECT_ID}"

url = "https://firebasestorage.googleapis.com/v0/b/gradchain-55ffd.appspot.com/o/diplomas%2FFRMYr9ryoZZVkl8ADJTmfbX2hh13?alt=media&token=7486de5b-1c59-4f30-b436-61341d7c7b67"
file = requests.get(url, allow_redirects=True)

try:
    # Prepare the authentication header
    auth_header = f"Basic {base64.b64encode(f'{INFURA_PROJECT_ID}:{INFURA_PROJECT_SECRET}'.encode()).decode()}"

    # Send the request to upload the file to IPFS
    response = requests.post(INFURA_API_URL, headers={'Authorization': auth_header}, files={'file': file.content})

    # Check if the request was successful
    if response.status_code == 200:
        result = response.json()

        # Get the IPFS hash (CID) and file size
        ipfs_hash = result['Hash']

        print(f"Uploaded file to IPFS with CID: {ipfs_hash}")
        print(f"file can be found here: https://ipfs.io/ipfs/{ipfs_hash}")

    else:
        print(f"Error uploading file to IPFS: {response.status_code} {response.text}")
except Exception as e:
    print(f"Error uploading file to IPFS: {e}")
