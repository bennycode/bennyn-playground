Zeta = {} unless Zeta?
Zeta.Service = {} unless Zeta.Service?
Zeta.Service.AssetService = (->

  download_asset: (asset_id, conversation_id) ->

    config = 
      url: Zeta.Service.URLs.create_access_token_url "/assets/#{asset_id}?conv_id=#{conversation_id}"
      type: 'GET'
      on_done: ->
        console.log "DONE"
      
    Zeta.Utils.RequestHandler.send_request config
  

  ###
    1. Generate and send "inline" preview picture
    2. Send "real" picture
    3. "correlation_id" should be the same for "inline" and "real" picture
    4. Tag should be different for these two images ("preview" & "medium")
  ###
  upload_asset: (values, callback) ->
    console.log "Uploading asset type: #{values.contentType}"
  
    config = 
      url: Zeta.Service.URLs.create_access_token_url "/assets"
      contentType: values.contentType
      headers:
        "Content-Disposition": "zasset;conv_id=#{values.cid};md5=#{values.hash};width=#{values.width};height=#{values.height};original_width=#{values.width};original_height=#{values.height};inline=false;public=true;correlation_id=#{Zeta.Utils.Misc.create_random_uuid()};tag=medium;nonce=#{Zeta.Utils.Misc.create_random_uuid()}"
      type: 'POST'
      data: values.binary
      processData: false
      on_done:
        callback  
  
    Zeta.Utils.RequestHandler.send_request config
#
)()