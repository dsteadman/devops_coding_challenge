from yaml import safe_load
from json import dumps
from chalice import Chalice, Response

app = Chalice(app_name='list_resources')

@app.route('/api/resources', methods=['GET'])
def index():
    with open('ebbcarbon.yaml', 'r') as yaml_file:
        contents = safe_load(yaml_file)

        return Response(body=dumps(contents["resources"],
                status_code=200,
                headers={'Content-Type': 'application/json'})
