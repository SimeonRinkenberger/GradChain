# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/managedblockchain.html

import boto3

network_id = 'n-XAZAGV72G5ADRIK3RZAZ7PHHQY'
member_id = 'm-QUUX6YFU35A4LJWLLJWCFKK33Q'
node_id = 'nd-ZSXYEJZJENERNPR2BAXY6IBIXQ'
chain_id = 'YOUR_CHAIN_ID'
aws_access_key_id = 'AKIAQT4KCDKGUUYSSXVH'
aws_secret_access_key = '7AFM9d3ygjinqcC3OHipoh7w1xXdAI72ruFsauQc'
region_name = 'us-east-1'

client = boto3.client('managedblockchain',
                      region_name=region_name,
                      aws_access_key_id=aws_access_key_id,
                      aws_secret_access_key=aws_secret_access_key)

response = client.list_networks()
networks = response['Networks']
members = client.list_members(NetworkId=network_id)['Members']
# member_id = members['Members'][0]['Id']
nodes = client.list_nodes(NetworkId=network_id, MemberId=member_id, MaxResults=20)['Nodes']

# print the ARN and name of each network
for network in networks:
    print("Network ARN: " + network['Arn'])
    print("Network Name: " + network['Name'])
print()

# print the members
for member in members:
    print("Member name: " + member['Name'])
    print("Member ID: " + member['Id'])
print()

# print the nodes
for node in nodes:
    print("Node ID: " + node['Id'])
    print("Node status: " + node['Status'])
print()
