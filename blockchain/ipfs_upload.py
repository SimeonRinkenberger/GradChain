from google.cloud import storage
from io import BytesIO
import base64
import requests
import json
from google.oauth2 import service_account

json_key_content = '''
{
  "type": "service_account",
  "project_id": "gradchain-55ffd",
  "private_key_id": "ff8be08653a846353b4f47e84013d551dc655164",
  "private_key": "-----BEGIN PRIVATE KEY-----\\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDGzXe+G7kWyFsh\\nM7qsllnbIPpCQN0S38KoPbiOPIMNhKaXgAToQjrreIywi+A3s9zP7CLmYmNkfTf2\\nkgoB/LR69uulMot0jNrilp8q9r3FI7p18DjBDijhqhDt54UiIQyitioq7OrQTbQY\\nV0LZ0TICn8z6Rl3j4IBx0AaTUDOpQUMYzUSnWPexSDy44Bd8YRWZaaJCpnnTVAGs\\nLPgbiS09QuMGQaXkKADDMITfLNfLSIr4ZwXY2GUztQunT0Ko3nE/aPwSqSLijF0J\\nWWIf2nj0rbtu3h38xzmR48OClsKn6o80noyXkKeNi8WqbLkD+c9y4zA6g+lfJvyq\\n/s5fxqAjAgMBAAECggEARjdxKSzqiVD32vjF4Mpz71EtAzScwNtWigzOwDJASYiG\\nPLFjSlOGMwAPlRW6eoIlJi0twHiUyXvuxcCcF0qVxm6rGVyKY/6SGwD/M/IVYel2\\nJMzVht6E8vuZ4iVpYP4SU/AKYcHvR+aCCyza+EsKomGlyOoMpH15cHl8sRBdRtSd\\nZ6/TayNJ586K0hLYwfnW7I7Dcu1lW38v5zeWNlGTLO1oZsCJLgNxow8/FEuRkWjm\\nfqy0J01tj0Jd88hccTEmdBlJFVRb7Rr60M6cag32XwepTyH4ywru3s3M27Tv1uKJ\\ndPB7Cp++pIEM43apALAhS8QJAZfW6B+rnOkK4Wh44QKBgQD60hxOq8/ipJm8EfQq\\nd7HYW6QwzNh3b2Blv/1AF6xCDaP+r4HUX57pnZxbKXHB+tNg/UYYOr4YdscLO4XW\\nWOciFIlqEFfYZQGS0fjqxR4/p3lkRmhzzHM7OJ10nLOijPDGTwjhJQ9kd+U7yooe\\nINEr61oyBywzGewfFiWySUdFwwKBgQDK6GD0iL8c7EAOKxHfdhfblkMI8K7hEylQ\\nridaYuZRwHuUsSlWhNJaO9ZaQVEXpoD3LaQHjr7mZCfj60WXXGVa9EOsaZBxh+aB\\n3gtgoBRpxobj8qhUSKxQ1V2xFZEoR8M4CLoYLBMmjzFCWkCpN3Punn8dI1uZcyMa\\nARG28Cq2IQKBgQDCL7eQxP4+tzb631+NHXxISLL2wTF6TnVwcVKts2Y/AXaNMO4w\\nMRPERK0P+ydCimHqvkvtaFVSdWsm7B9zUwMnZIT648pPE+xC8mNnx9Lib1PRaZ1m\\nwcwY9n0ZElUVLU8gCYKTZPDk1NpaDzYdm0S2XxFGmD0FFzWy35+xx3/xpwKBgA78\\nKmzkzHhuWiyxsZg3OHvXFQxL+h5VM+/pbK6YLzpKZNYOX2csV/yh/qqbuElu2odm\\nr35/ZEnPi8KhVXpgMHwPHhBVm31G9BcTNvPj3p4RM1USTqwq0c8GcuzpEtdOtXQl\\n8NhoKOHoIVMtJylYFw/AVNLqEZG7lxQMkCpagk0BAoGAcLstFOKijf87zqno346s\\nVXXlsabOlFox5ScR0f+ULX7ikDvDF4iBKk3OSj/FN1P1PARo+O9mteljQ8f24p9g\\nLFTJOuIFgd2WlWNtFjd7aI8Kjvwj83lOImOzy/+dV6nce3ClKg41oMcck6X56EHn\\nSgJb3WoDTGyuaTiHnDsknHI=\\n-----END PRIVATE KEY-----\\n",
  "client_email": "storage-viewer@gradchain-55ffd.iam.gserviceaccount.com",
  "client_id": "116802014986302264716",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/storage-viewer%40gradchain-55ffd.iam.gserviceaccount.com"
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
