Zeta.Registration.RequestHandler = (->
  post_json: (url, data, on_success, on_error) ->
    if typeof data isnt 'string'
      data = JSON.stringify data
  
    $.ajax
      url: url
      type: 'POST'
      crossDomain: true
      contentType: 'application/json; charset=utf-8'
      dataType: 'json'
      data: data
      error: on_error
      success: on_success
)()