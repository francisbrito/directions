# Helper functions

# Imports
fs = require 'fs'

# Sends a response back to the client.
sendResponse = (status, type, length, content, response) ->
  # Write response header
  response.writeHead status,
    'Content-Type': type
    'Content-Length': length

  # Append response content
  response.end content

# Rudimentary body parse.
parseBody = (body) ->
  parsedBody = {}

  fields = body.split '&'

  for field in fields
    parts = field.split '='

    parts.forEach (part, index) ->
      # Assume any of the two parts can be 'right'
      key = value = part

      # Then fix key, value values.
      # Even values are keys, odds ones are values.
      if index % 2 is 0
        value = parts[index + 1]
      else
        key = parts[index - 1]

      # `x-www-form-urlencoded` is an old version of URL encoding
      # meaning JavaScript's native decodeURIComponent can be used to decode it.
      # then we just monkey-patch it for other characters.

      value = decodeURIComponent(value.split('+').join ' ')
      parsedBody[key] = value
  
  return parsedBody

# Retrieves body content from a request.
getBodyFrom = (request, fn) ->
  # Holds full body.
  body = ''

  request.on 'data', (chunk) ->
    # Add data chunks.
    body += chunk

  request.on 'end', ->
    # Send it to callback
    fn body

# Serves a file with a given mime-type.
serve = (filePath, mimeType, response) ->
  fs.readFile filePath, (err, content) ->
    # This function assumes files exist before serving them, so if it's unable to read them it's
    # an error.
    if err
      msg = "Unable to read #{filePath}. :("

      sendResponse 500, 'text/plain', msg.length, msg, response
    else
      sendResponse 200, mimeType, content.length, content, response

exports.sendResponse = sendResponse
exports.getBodyFrom  = getBodyFrom
exports.parseBody    = parseBody
exports.serve         = serve
