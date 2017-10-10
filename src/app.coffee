pluralize = require('pluralize')

#sanitize json with singulay keys removed.
sanitizeJson = (jsonObj) ->
  if typeof jsonObj == 'object'
    for key of jsonObj
      if !!jsonObj[key] and typeof jsonObj[key] == 'object'
        jsonObj[key] = remove_key(key,jsonObj[key]) if jsonObj[key] instanceof Array
        sanitizeJson jsonObj[key]
    return jsonObj
  else
    return false

#remove singular key from json
remove_key = (key,value) ->
  formatted_array = []
  index = 0
  array_length = value.length
  while index < array_length
    if value[index] !instanceof Array && typeof value[index] == 'object'
      formatted_array.push(getValue(key,value[index]))
    else
      formatted_array.push(value[index])
    index++
  return formatted_array

#get value from json object
getValue = (key,item) ->
  singular_key = pluralize.singular(key)
  if typeof item[singular_key] != "undefined" && typeof item[singular_key] == 'object'
    return item[singular_key]
  else
    return item

module.exports = {
    sanitizeJson:sanitizeJson
}