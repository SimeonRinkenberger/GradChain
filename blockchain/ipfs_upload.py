from google.cloud import storage
from io import BytesIO
import base64
import requests
import json
from google.oauth2 import service_account

json_key_content = '''
{
  # this content is on the google cloudconsole but not here to keep the access keys private
}
'''

# parse JSON string to a dictionary
service_account_info = json.loads(json_key_content)
credentials = service_account.Credentials.from_service_account_info(service_account_info)


INFURA_PROJECT_ID = "2Nia36psZhuJRKW5X9AxNzIOQ0q"
INFURA_PROJECT_SECRET = "204dc57525ec7ff705eae55165772478"
INFURA_API_URL = f"https://ipfs.infura.io:5001/api/v0/add?project_id={INFURA_PROJECT_ID}"
BUCKET_NAME = "gradchain-55ffd.appspot.com"

def ipfs_upload(flutter_request):
    flutter_request_json = flutter_request.get_json()
    diplomaID = flutter_request_json['ID']
    path = f"diplomas/{diplomaID}"
    # file = requests.get(url, stream=True)

    client = storage.Client(credentials=credentials, project=service_account_info["gradchain"])
    bucket = client.get_bucket(BUCKET_NAME)
    blob = bucket.blob(path)

    diplomaFile = BytesIO()
    blob.download_to_file(diplomaFile)
    diplomaFile.seek(0)  # Move the cursor to the beginning of the file

    try:
        # Prepare the authentication header
        auth_header = f"Basic {base64.b64encode(f'{INFURA_PROJECT_ID}:{INFURA_PROJECT_SECRET}'.encode()).decode()}"

        response = requests.post(INFURA_API_URL, headers={'Authorization': auth_header}, files={'file': diplomaFile.getvalue()})

        # Check if the request was successful
        if response.status_code == 200:
            result = response.json()

            # Get the IPFS hash (CID)
            ipfs_hash = result['Hash']

            return ipfs_hash
        else:
            return "error"
    except Exception as e:
        return e
