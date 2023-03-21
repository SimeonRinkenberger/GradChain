import boto3
import json
import uuid
from boto3.session import Session
from datetime import datetime
import pyqldb
from pyqldb.driver.qldb_driver import QldbDriver
# from amazon.ion import IonStruct
from botocore.config import Config

# Set up AWS credentials
aws_access_key_id = 'AKIAQT4KCDKGUUYSSXVH'
aws_secret_access_key = '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'
region_name = 'us-east-1'

# Set up the network and member information
network_id = 'n-XAZAGV72G5ADRIK3RZAZ7PHHQY'
member_id = '042702346893'
node_id = 'YOUR_NODE_ID'
chain_id = 'YOUR_CHAIN_ID'

# # Define the QLDB ledger and table names
# ledger_name = 'GradChain'
# table_name = 'Diplomas'
#
# session = Session()
#
# qldb_client = boto3.client('qldb',
#                              region_name=region_name,
#                              aws_access_key_id=aws_access_key_id,
#                              aws_secret_access_key=aws_secret_access_key)
#
# qldb_driver = session.client('qldb',
#                              region_name=region_name,
#                              aws_access_key_id=aws_access_key_id,
#                              aws_secret_access_key=aws_secret_access_key)
#

session = boto3.Session(
    aws_access_key_id=aws_access_key_id,
    aws_secret_access_key=aws_secret_access_key,
    region_name=region_name
)

client = boto3.client('managedblockchain',
                      region_name=region_name,
                      aws_access_key_id=aws_access_key_id,
                      aws_secret_access_key=aws_secret_access_key)

# get a list of all available networks
response = client.list_networks()
networks = response['Networks']
members = client.list_members(NetworkId=network_id)
member_id = members['Members'][0]['Id']

# Define the JSON document to add to the node
document = {
    'key1': 'value1',
    'key2': 'value2',
    'key3': {
        'nested_key1': 'nested_value1',
        'nested_key2': 'nested_value2'
    }
}

# Convert the document to a JSON string
document_str = json.dumps(document)

# Use the client to submit the JSON document to the node
response = client.invoke_network_insider(
    NetworkId=network_id,
    MemberId=member_id,
    NodeId=node_id,
    InvokeArgs={
        'ChaincodeId': 'your_chaincode_id',
        'Fcn': 'add_document',
        'Args': [document_str]
    }
)

# Print the response
print(response)























# # qldb_driver2 = QldbDriver(ledger_name)
# # for table in qldb_driver2.list_tables():
# #     print(table)
#
# # Try to connect to the ledger
# try:
#     ledger_name = 'GradChain'
#     response = qldb_client.describe_ledger(Name=ledger_name)
#     print(f"Connected to ledger '{ledger_name}' with status '{response['State']}'")
# except qldb_client.exceptions.ResourceNotFoundException:
#     print(f"Ledger '{ledger_name}' not found")
#
# # Create a new document to insert into the ledger
# document = {
#     "transaction_id": "1234567890",
#     "timestamp": str(datetime.now()),
#     "message": "Hello, World!"
# }
#
# qldb_session = boto3.session.Session(region_name=region_name)
# config = Config(connect_timeout=5, read_timeout=5)
#
# # with qldb_session.client('qldb-session', config=config) as session:
# response = qldb_session.client.ExecuteStatement(
#     LedgerName=ledger_name,
#     Statement=f'INSERT INTO {table_name} ?',
#     Parameters=[{'IonBinary': document.to_bytes()}]
#
#     )
#
#
#
# print(response)
#
# # cursor = qldb_driver.execute_statement("SELECT * FROM GRADCHAIN")
#
# # # Start a new transaction
# # with qldb_driver.start_transaction(ledger_name) as transaction:
# #     # Insert the document into the specified table
# #     statement = f"INSERT INTO {table_name} ?"
# #     response = transaction.execute_statement(statement, parameters=[document])
# #
# #     # Get the document ID of the inserted document
# #     document_id = list(response)[0].get("documentId")
# #
# #     # Get the hash of the inserted document
# #     statement = f"SELECT * FROM history({table_name}, {document_id}) AS h WHERE h.metadata.version = 1"
# #     response = transaction.execute_statement(statement)
# #
# #     # Create a digest of the document's hash
# #     digest = pyqldb.Digest(hash(response[0]["digest"]))
# #     signature = pyqldb.Signature(digest, session)
# #
# #     # Add the signature to the transaction
# #     transaction.add_signature(digest, signature)
# #
# #     # Commit the transaction to the ledger
# #     transaction.commit()
# #
# # print(f"Document added to ledger with ID '{document_id}'")
