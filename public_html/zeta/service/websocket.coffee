Zeta = {} unless Zeta?
Zeta.Service = {} unless Zeta.Service?
Zeta.Service.WebSocket = (->

  blob_reader = new FileReader()
  blob_reader.onload = ->
    console.log blob_reader.result

  ###
    @see http://cjihrig.com/blog/how-to-use-websockets/
    @see http://stackoverflow.com/questions/11089732/display-image-from-blob-using-javascript-and-websockets
  ###
  open_websocket: () ->
    socket = new WebSocket "wss://#{Zeta.Service.URLs.get_host()}/await?access_token=#{Zeta.Storage.Session.get_access_token()}"
    socket.binaryType = "blob"
    
    socket.onopen = (event) ->
      console.log 'Connection opened (WebSocket)'
      
    socket.onclose = (event) ->
      console.log 'Connection closed (WebSocket)'
      code = event.code
      reason = event.reason
      wasClean = event.wasClean
      
    socket.onmessage = (event) ->
      if event.data instanceof Blob
        blob_reader.readAsText event.data
      
#
)()