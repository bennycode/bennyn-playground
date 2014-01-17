Zeta = {} unless Zeta?
Zeta.Utils = {} unless Zeta.Utils?
Zeta.Utils.RequestHandler = (->  
  
  send_request: (config) ->
  
    $.ajax
      contentType: config.contentType
      crossDomain: true
      data: config.data
      dataType: config.dataType
      type: config.type
      url: config.url
    .done(config.on_success)
    .fail(config.on_error)
    .always(config.on_done)   

  send_json: (config) ->
  
    if typeof config.data isnt 'string'
      config.data = JSON.stringify config.data
  
    config.contentType = 'application/json; charset=utf-8'
    config.dataType = 'json'  
    
    @send_request config

#
)()