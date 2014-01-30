Zeta = {} unless Zeta?
Zeta.Service = {} unless Zeta.Service?
Zeta.Service.AssetService = (->

  upload_image_jpeg: (values, callback) ->
    config = 
      url: Zeta.Service.URLs.create_access_token_url "/assets"
      contentType: values.contentType
      headers:
        "Content-Disposition": "zasset;conv_id=#{values.cid};md5=#{values.hash};width=#{values.width};height=#{values.height}"
      type: 'POST'
      data: values.binary
      processData: false
      on_done:
        callback  
  
    Zeta.Utils.RequestHandler.send_request config
#
)()