import yaml

filename = ["config.yaml", ]
parameter = "username"
replace_to = "different_username"

with open("config.yaml", 'r') as stream:
    try:
        data = yaml.safe_load(stream)
    except yaml.YAMLError as exc:
        print(exc)

data["database"][parameter] = replace_to

with open("modified.yaml", 'w') as stream:
    try:
        yaml.dump(data, stream, default_flow_style=False)
    except yaml.YAMLError as exc:
        print(exc)