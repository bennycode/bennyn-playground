Zeta = {} unless Zeta?
Zeta.Service = {} unless Zeta.Service?
Zeta.Service.AssetService = (->
  test: (length, md5, binary) ->
    $.ajax
      contentType: "image/jpeg"
      crossDomain: true
      data: binary
      processData: false
      headers:
        "Content-Disposition": "zasset;conv_id=3edb9e0d-294c-4edb-b2d7-8686aab01b0a;md5="+md5
      url: Zeta.Service.URLs.create_access_token_url "/assets"
      type: 'POST'
    .always( (data, textStatus, jqXHR) ->
      console.log JSON.stringify data
    )  

)()