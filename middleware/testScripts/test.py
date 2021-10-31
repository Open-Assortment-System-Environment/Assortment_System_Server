# importing the requests library
import requests
import json

# api-endpoint
URL = "http://127.0.0.1:8080/api/json"

# defining a params dict for the parameters to be sent to the API
#f = open("in-search-parts.json")
#f = open("in-get-parts-all.json")
f = open("in-search-parts-test.json")

#PARAMS = json.loads(f.read())
#print(PARAMS)

data_json = json.loads(f.read())

# sending get request and saving the response as response object
r = requests.post(url = URL, json = data_json)#json.dumps(data_json)

# extracting data in json format
#data = r.json()


# printing the output
print(r.text)
#r_json = json.loads(r.text)
#print(r_json['error'])

open("out.html", "wb").write(r.content);


print('\033[1mStatus:\033[0m ', r.status_code)
#print(r.headers, '\n\n')
headers = str(r.headers).replace('\',', '\n')
headers = str(headers).replace('{', '')
headers = str(headers).replace('}', '')
headers = str(headers).replace(' ', '')
headers = str(headers).replace('\':', ':\033[0m ')
headers = str(headers).replace(' \'', ' ')
headers = str(headers).replace('\'', '\033[1m')
print(headers)
print("\033[0m")
