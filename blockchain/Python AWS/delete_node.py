# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/managedblockchain.html

import boto3

network_id = 'n-XAZAGV72G5ADRIK3RZAZ7PHHQY'
member_id = 'm-QUUX6YFU35A4LJWLLJWCFKK33Q'
chain_id = 'YOUR_CHAIN_ID'
aws_access_key_id = 'AKIAQT4KCDKGUUYSSXVH'
aws_secret_access_key = '7AFM9d3ygjinqcC3OHipoh7w1xXdAI72ruFsauQc'
region_name = 'us-east-1'

client = boto3.client('managedblockchain',
                      region_name=region_name,
                      aws_access_key_id=aws_access_key_id,
                      aws_secret_access_key=aws_secret_access_key)

response = client.delete_node(
    NetworkId=network_id,
    MemberId=member_id,
    NodeId='nd-7FXPVDMZYVGJRHC2SQ5EULH2NQ'
)
