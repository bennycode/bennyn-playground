Zeta.Registration.RequestHandler = (->
  postData: (url, data, onSuccess, onError) ->
    payload = data

    $.ajax url,
      type: 'POST'
      crossDomain: true,
      contentType: 'application/json; charset=utf-8'
      dataType: 'json'
      data: payload
      error: onError
      success: onSuccess)()