Zeta = {} unless Zeta?
Zeta.Utils = {} unless Zeta.Utils?
Zeta.Utils.RequestHandler = (->  
  
  send_request: (config) ->
    console.log "= Zeta.Utils.RequestHandler.send_request"
    console.log JSON.stringify config
  
    $.ajax
      url: config.url
      type: config.type
      crossDomain: true
    .done(config.on_success)
    .fail(config.on_error)
    .always(config.on_done)   

  send_json: (config) ->
    if typeof config.data isnt 'string'
      config.data = JSON.stringify config.data
  
    $.ajax
      url: config.url
      type: config.type
      crossDomain: true
      contentType: 'application/json; charset=utf-8'
      dataType: 'json'
      data: config.data
    .done(config.on_success)
    .fail(config.on_error)
    .always(config.on_done)    

#
)()