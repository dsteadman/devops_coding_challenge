import sys
import yaml
import json

def handler(event, context):
    with open('ebbcarbon.yaml', 'r') as yaml_file:
        contents = yaml.safe_load(yaml_file)

        return {
                "statusCode": 200,
                "headers": {
                    "Content-Type": "application/json"
                    },
                "body": contents
                }
