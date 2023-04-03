import base64
import requests

INFURA_PROJECT_ID = "2Nia36psZhuJRKW5X9AxNzIOQ0q"
INFURA_PROJECT_SECRET = "204dc57525ec7ff705eae55165772478"
INFURA_API_URL = f"https://ipfs.infura.io:5001/api/v0/add?project_id={INFURA_PROJECT_ID}"

def ipfs_upload(request):

  # For more information about CORS and CORS preflight requests, see
  # https://developer.mozilla.org/en-US/docs/Glossary/Preflight_request
  # for more information.

  headers = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST',
    'Access-Control-Allow-Headers': 'Content-Type'
  }

  # Set CORS headers for the preflight request
  if request.method == 'OPTIONS':
      # Allows GET requests from any origin with the Content-Type
      # header and caches preflight response for an 3600s
      headers.update({
        'Access-Control-Allow-Methods': 'GET',
        'Access-Control-Allow-Headers': 'Content-Type',
        'Access-Control-Max-Age': '3600'
      })

      return ('', 204, headers)
  else:
    flutter_request_json = request.get_json()
    url = flutter_request_json['url']
    file = requests.get(url, stream=True)

    
    # Prepare the authentication header
    auth_header = f"Basic {base64.b64encode(f'{INFURA_PROJECT_ID}:{INFURA_PROJECT_SECRET}'.encode()).decode()}"

    # Send the request to upload the file to IPFS
    response = requests.post(INFURA_API_URL, headers={'Authorization': auth_header}, files={'file': file.content})

    # Check if the request was successful
    if response.status_code == 200:
      result = response.json()

      # Get the IPFS hash (CID)
      ipfs_hash = result['Hash']

      bChainUrl = f'https://ipfs.io/ipfs/{ipfs_hash}'
      return (bChainUrl, 200, headers)
      
    else:
      return ('error', 500, headers)