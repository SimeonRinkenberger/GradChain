import base64
import requests

INFURA_PROJECT_ID = "2Nia36psZhuJRKW5X9AxNzIOQ0q"
INFURA_PROJECT_SECRET = "204dc57525ec7ff705eae55165772478"
INFURA_API_URL = f"https://ipfs.infura.io:5001/api/v0/add?project_id={INFURA_PROJECT_ID}"

def ipfs_upload(flutter_request):
  flutter_request_json = flutter_request.get_json()
  url = flutter_request_json['url']
  file = requests.get(url, stream=True)

  try:
    # Prepare the authentication header
    auth_header = f"Basic {base64.b64encode(f'{INFURA_PROJECT_ID}:{INFURA_PROJECT_SECRET}'.encode()).decode()}"

    # Send the request to upload the file to IPFS
    response = requests.post(INFURA_API_URL, headers={'Authorization': auth_header}, files={'file': file.content})

    # Check if the request was successful
    if response.status_code == 200:
      result = response.json()

      # Get the IPFS hash (CID)
      ipfs_hash = result['Hash']

      return f'https://ipfs.io/ipfs/{ipfs_hash}'
    else:
      return "error"
  except Exception as e:
    return e