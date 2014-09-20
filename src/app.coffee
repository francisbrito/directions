# Library imports
http = require 'http'
path = require 'path'
fs   = require 'fs'
url  = require 'url'

core    = require '../src/core'
helpers = require '../src/helpers'

sendResponse = helpers.sendResponse
getBodyFrom  = helpers.getBodyFrom
parseBody    = helpers.parseBody
serve        = helpers.serve
notFound     = helpers.notFound

findMatchesIn = core.findMatchesIn

# Application configuration.
projectPath = path.join path.dirname(fs.realpathSync(__filename)), '../'

# Static file directory.
statics = path.join projectPath, 'public'

# Listen port.
port    = process.env.PORT or 3000

# Route map
# TODO: Teach server to serve static files. Hardcoding stuff sucks.
routes =
  '/':
    filePath: "#{statics}/index.html"
    mimeType: 'text/html'
  '/css/bootstrap.css':
    filePath: "#{statics}/css/bootstrap.css"
    mimeType: 'text/css'
  '/css/bootstrap-theme.css':
    filePath: "#{statics}/css/bootstrap-theme.css"
    mimeType: 'text/css'

app = http.createServer((request, response) ->
  if request.method is 'GET'
    urlPath = url.parse(request.url).path

    if urlPath is '/favicon.ico'
      sendResponse 203, 'text/plain', 0, null, response
    else
      route = routes[urlPath]

      # If route is not on route map, then return 404.
      return notFound response if not route

      {filePath, mimeType} = route

      serve filePath, mimeType, response
  else if request.method is 'POST'
      getBodyFrom request, (body) ->
        # If no body was passed it's a bad request.
        if not body
          msg = 'Request had no body.'

          return sendResponse 400, 'text/plain', msg.length, msg, response

        # Just return text body for now.
        body = parseBody(body)

        # Retrieve text parameter from body.
        text = body['text-body']

        # If no text was passed it's a bad request.
        if not text
          msg = '`text-body` is missing.'
          return sendResponse 400, 'text/plain', msg.length, msg, response

        # Find directions and distances
        matches = findMatchesIn text

        json = JSON.stringify matches

        sendResponse 200, 'application/json', json.length, json, response
  else
    msg = "Can't #{request.method} here."

    sendResponse 405, 'text/plain', msg.length, msg, response
)

exports.app = app
exports.port = port
