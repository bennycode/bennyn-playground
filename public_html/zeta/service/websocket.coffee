Zeta = {} unless Zeta?
Zeta.Service = {} unless Zeta.Service?
Zeta.Service.WebSocket = (->

  ###
    @deprecated
  ###
  get_connection_url: (callback) ->
    config = 
      url: Zeta.Service.URLs.create_access_token_url "/self/device/push"
      type: 'POST'
      data:
        method: 'websocket'
        service: 'zeta'
      on_done:
        callback  
  
    Zeta.Utils.RequestHandler.send_json config

  ###
    @see http://cjihrig.com/blog/how-to-use-websockets/
    @see http://stackoverflow.com/questions/11089732/display-image-from-blob-using-javascript-and-websockets
  ###
  open_websocket: () ->
    socket = new WebSocket "wss://#{Zeta.Service.URLs.get_host()}/await?access_token=#{Zeta.Storage.Session.get_access_token()}"
    # socket.binaryType = "blob"
    
    socket.onopen = (event) ->
      console.log 'Connection opened (WebSocket)'
      
    socket.onclose = (event) ->
      console.log 'Connection closed (WebSocket)'
      code = event.code
      reason = event.reason
      wasClean = event.wasClean
      
    socket.onmessage = (event) ->
      if event.data instanceof ArrayBuffer
        console.log "ArrayBuffer"
      else if event.data instanceof Blob
        console.log "BLOB"
      else
        console.log "String"
      # arrayBuffer = msg.data
      # bytes = new Uint8Array arrayBuffer
      
      
#
)()