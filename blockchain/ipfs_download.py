import requests
import sys
import base64

INFURA_PROJECT_ID = "2Nia36psZhuJRKW5X9AxNzIOQ0q"
INFURA_PROJECT_SECRET = "204dc57525ec7ff705eae55165772478"
INFURA_GATEWAY_URL = f"https://ipfs.infura.io:5001/api/v0/cat?project_id={INFURA_PROJECT_ID}"

def download_from_ipfs(cid, output_file):
    try:
        # Prepare the authentication header
        auth_header = f"Basic {base64.b64encode(f'{INFURA_PROJECT_ID}:{INFURA_PROJECT_SECRET}'.encode()).decode()}"

        # Send the request to download the file from IPFS
        response = requests.post(f"{INFURA_GATEWAY_URL}&arg={cid}", headers={'Authorization': auth_header}, stream=True)

        # Check if the request was successful
        if response.status_code == 200:
            with open(output_file, 'wb') as file:
                for chunk in response.iter_content(chunk_size=8192):
                    file.write(chunk)

            print(f"Downloaded file from IPFS with CID: {cid}")
            print(f"Saved to: {output_file}")
        else:
            print(f"Error downloading file from IPFS: {response.status_code} {response.text}")
            sys.exit(1)
    except Exception as e:
        print(f"Error downloading file from IPFS: {e}")
        sys.exit(1)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python ipfs_download.py <cid> <output_file>")
        sys.exit(1)

    cid = sys.argv[1]
    output_file = sys.argv[2]
    download_from_ipfs(cid, output_file)
