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

name = 'John'
description = 'test'

response = client.create_member(
    # ClientRequestToken='string',
    InvitationId='string',
    NetworkId=network_id,
    MemberConfiguration={
        'Name': name,
        'Description': description,
        'FrameworkConfiguration': {
            'Fabric': {
                'AdminUsername': name,
                'AdminPassword': 'Aws1234!'
            }
        }
        # , 'LogPublishingConfiguration': {
        #     'Fabric': {
        #         'CaLogs': {
        #             'Cloudwatch': {
        #                 'Enabled': False
        #             }
        #         }
        #     }
        # },
        # 'Tags': {
        #     'string': 'string'
        # },
        # 'KmsKeyArn': 'string'
    }
)

print(response)
