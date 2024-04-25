from yaml import safe_load
from json import dumps

def handler(event, context):
    with open('ebbcarbon.yaml', 'r') as yaml_file:
        contents = safe_load(yaml_file)

        return {
                "statusCode": 200,
                "headers": {
                    "Content-Type": "application/json"
                    },
                "body": dumps(contents["resources"])
                }
