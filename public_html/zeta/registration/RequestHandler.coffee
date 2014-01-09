Zeta.Registration.RequestHandler = (->
  postData: (url, data, onSuccess, onError) ->
    $.ajax
      url: url
      type: 'POST'
      crossDomain: true
      contentType: 'application/json; charset=utf-8'
      dataType: 'json'
      data: data
      error: onError
      success: onSuccess
)()