Zeta = {} unless Zeta?
Zeta.Utils = {} unless Zeta.Utils?
Zeta.Utils.RequestHandler = (->  
  
  send_request: (config) ->
    $.ajax
      url: config.url
      type: config.type
      crossDomain: true
      data: config.data
    .done(config.on_success)
    .fail(config.on_error)
    .always(config.on_done)   

  send_json: (config) ->
    if typeof config.data isnt 'string'
      config.data = JSON.stringify config.data
  
    $.ajax
      contentType: 'application/json; charset=utf-8'
      crossDomain: true
      data: config.data
      dataType: 'json'
      type: config.type
      url: config.url
    .done(config.on_success)
    .fail(config.on_error)
    .always(config.on_done)    

#
)()