# The difrent search types that can be in the html request
<!---
## 0) [search_type]
[describtion]
## Example:
JSON:
```
[JSON example]
```
### Field describtions
* "type": is the search type, it has to be [search_type]
* "[field name]": [field describt]
* "priorety": is the priorety of this search(currently un used)
--->
## 1) value
this search type searches for an attribute that has the exact value that is describt in the field "value"
### Example:
JSON:
```
{
  "name": "param_name",
  "value": "abc",
  "priorety": "search_priorety",
  "type": "value"
}
```
### Field describtions
* "type": is the search type, it has to be value
* "name": is the name of the parameter that has to be searched by
* "value": is the value of the parameter that has to be searched by
* "priorety": is the priorety of this search(currently un used)

## 2) values
seqarches the parts with the list of values that is given
## Example:
JSON:
```
{
  "name": "param_name",
  "values": ["v1", "v2", "vn"],
  "priorety": "search_priorety",
  "type": "values"
}
```
### Field describtions
* "type": is the search type, it has to be values
* "name": is the name of the parameter that has to be searched by
* "values": is an list of values that the parameter(name) could have, it must have one of them
* "priorety": is the priorety of this search(currently un used)

## 3) from_to
seqarches the parts with the range
## Example:
JSON:
```
{
  "name": "param_name",
  "from": "param_from_value",
  "to": "param_to_value",
  "priorety": "search_priorety",
  "type": "from_to"
}
```
### Field describtions
* "type": is the search type, it has to be from_to
* "name": is the name of the parameter that has to be searched by
* "from": is the start value of the range that the parameter(name) coulde be in, it should be smaler then "to"
* "to": is the last value of the range that the parameter(name) coulde be in, it should be bigger then "from"
* "priorety": is the priorety of this search(currently un used)
