import requests
import sys
import base64
import os

INFURA_PROJECT_ID = "2Nia36psZhuJRKW5X9AxNzIOQ0q"
INFURA_PROJECT_SECRET = "204dc57525ec7ff705eae55165772478"
INFURA_API_URL = f"https://ipfs.infura.io:5001/api/v0/add?project_id={INFURA_PROJECT_ID}"

def upload_to_ipfs(file_path):
    try:
        # Prepare the authentication header
        auth_header = f"Basic {base64.b64encode(f'{INFURA_PROJECT_ID}:{INFURA_PROJECT_SECRET}'.encode()).decode()}"

        # Read the file as binary data
        with open(file_path, 'rb') as file:
            file_data = file.read()

        # Send the request to upload the file to IPFS
        response = requests.post(INFURA_API_URL, headers={'Authorization': auth_header}, files={'file': file_data})

        # Check if the request was successful
        if response.status_code == 200:
            result = response.json()

            # Get the IPFS hash (CID) and file size
            ipfs_hash = result['Hash']
            file_size = os.path.getsize(file_path)

            print(f"Uploaded file to IPFS with CID: {ipfs_hash}")
            print(f"File size: {file_size} bytes")

            return ipfs_hash
        else:
            print(f"Error uploading file to IPFS: {response.status_code} {response.text}")
            sys.exit(1)
    except Exception as e:
        print(f"Error uploading file to IPFS: {e}")
        sys.exit(1)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python ipfs_upload.py <file_path>")
        sys.exit(1)

    file_path = sys.argv[1]
    upload_to_ipfs(file_path)
