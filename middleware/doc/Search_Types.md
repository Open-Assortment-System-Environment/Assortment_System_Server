# The difrent search types that can be in the html request
## 1) value
this search type searches for an attribute that has the exact value that is describt in the field "value"
### Example:
```
{
  "name": "param_name",
  "value": "abc",
  "priorety": "search_priorety",
  "type": "value"
}
```
### Field describtion
* "name": is the name of the parameter that has to be searched by
* "value": is the value of the parameter that has to be searched by
* "priorety": is the priorety of this search(currently un used)
* "type": is the search type, it has to value

## 2)
