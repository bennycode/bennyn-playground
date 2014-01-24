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

  open_websocket: () ->
    ws = new WebSocket "wss://#{Zeta.Service.URLs.get_host()}/await?access_token=#{Zeta.Storage.Session.get_access_token()}"
    ws.onopen = ->
      console.log 'Connection opened (WebSocket)'
    ws.onclose = ->
      console.log 'Connection closed (WebSocket)'
    ws.onmessage = (message) =>
      console.log JSON.stringify message
      console.log JSON.stringify message.data
#
)()