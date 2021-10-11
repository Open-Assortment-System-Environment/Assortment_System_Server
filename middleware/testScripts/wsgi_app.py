import json

def application(environ, start_response):
    # Set Status to base OK
    # https://en.wikipedia.org/wiki/List_of_HTTP_status_codes
    # https://de.wikipedia.org/wiki/HTTP-Statuscode
    status = '200 OK'

    # Read reqest
    data_in_bytes = environ['wsgi.input'].read()
    data_in_string = data_in_bytes.decode('utf-8')

    # Creat Output Variable
    data_out_string = ''

    # DO Stufe

    # Pars request data as JSON
    data_in_json = json.loads(json.loads(data_in_string))


    # Find request type
    if not('request' in data_in_json): # Check if ther is a request objekt
        status = '400 Bad Request'
        data_out_string = json.dumps({'error':'No request structure'})

    elif(data_in_json['request']['request_type'] == 'search'): # An search request
        f = open("/Src/pythonWSGI_API/wsgi-scripts/out-search-parts.json")
        data_json = json.loads(f.read())
        data_out_string = str(data_json)

    elif(data_in_json['request']['request_type'] == 'get_all'): # An request for alle the bae info(returns by the parts alle der id's, names, etc.(defined in the parts table) of all the parts)
        f = open("/Src/pythonWSGI_API/wsgi-scripts/out-get-parts-all.json")
        data_json = json.loads(f.read())
        #data_out_string = str(data_json)
        data_out_string = str((str(data_json['result']['parts'][0]['weight']) == 0))

    else: # When nothing mathing was found retun bad request
        status = '400 Bad Request'
        data_out_string = json.dumps({'error':'This request_type dous not exist'})


    # End Do Stufe

    # Encode Output Variable
    data_out_string = data_out_string + '\n'
    data_out_bytes = data_out_string.encode('utf-8')

    # Creat Headers
    headers = [('Content-type', 'application/json'),
               ('Out-Content-Length', str(len(data_out_string))),
               ('In-Content-Length', str(len(data_in_string))),
               ('Request-Methode', environ['REQUEST_METHOD'])]
    start_response(status, headers)

    return [data_out_bytes]
