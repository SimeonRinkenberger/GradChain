# https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/managedblockchain.html
# Only allowed 2 nodes on standard

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

# Create a node on the blockchain
response = client.create_node(
    NetworkId=network_id,
    MemberId=member_id,
    NodeConfiguration={
        'InstanceType': 'bc.t3.small',
        'AvailabilityZone': 'us-east-1a',
        'LogPublishingConfiguration': {
            'Fabric': {
                'ChaincodeLogs': {
                    'Cloudwatch': {
                        'Enabled': True
                    }
                },
                'PeerLogs': {
                    'Cloudwatch': {
                        'Enabled': True
                    }
                }
            }
        },
        'StateDB': 'LevelDB'
    },
    Tags={
        'string': 'string'
    }
)

print(response)
print("Node created at NodeId=" + response['NodeId'])

# Instance types
# Instance	   vCPUs	mem (GiB)
# bc.t3.small	2	              2.0
# bc.t3.medium	2	              4.0
# bc.t3.large	2	              8.0
# bc.t3.xlarge	4	            16.0
# bc.m5.large	2	              8.0
# bc.m5.xlarge	4	            16.0
# bc.m5.2xlarge	8	            32.0
# bc.m5.4xlarge	16	            64.0
# bc.c5.large	2	              4.0
# bc.c5.xlarge	4	              8.0
# bc.c5.2xlarge	8	            16.0
# bc.c5.4xlarge	16	            32.0
