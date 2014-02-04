Zeta = {} unless Zeta?
Zeta.Service = {} unless Zeta.Service?
Zeta.Service.AssetService = (->

  ###
    PRIVATE
  ###

  parse_image = (file, callback) ->
    console.log "parse_image"
  
    ajax = null
  
    payload =
      content_type: null
      conv_id: Zeta.Storage.Session.current_conversation_id
      correlation_id: Zeta.Utils.Misc.create_random_uuid()
      nonce: Zeta.Utils.Misc.create_random_uuid()
      tag: "medium"
      inline: false
      public: false
      data: null
      hash: null      
      width: null
      height: null
    
    send_image_to_server_callback = ->
      console.log "send_image_to_server_callback"
      
      if ajax.readyState is 4
        # {"code":409,"message":"Duplicate asset.","label":"client-error"}
        response = JSON.parse ajax.responseText
        console.log "Response message: #{response.message}"
        callback?()
    
    send_image_to_server = ->
      console.log "send_image_to_server"
      
      ajax = new XMLHttpRequest()
      ajax.open "POST", Zeta.Service.URLs.create_access_token_url "/assets", true
      ajax.setRequestHeader "Content-Type", payload.content_type
      ajax.setRequestHeader "Content-Disposition", "zasset;conv_id=#{payload.conv_id};md5=#{payload.hash}"
      ajax.onreadystatechange = send_image_to_server_callback
      ajax.send payload.data
      
    parse_image_dimension_callback = ->
      console.log "parse_image_dimension_callback"
      
      payload.width = @width
      payload.height = @height
      
      console.log "Height: #{payload.height}"
      send_image_to_server()
    
    parse_image_dimension = (data_url) ->
      console.log "parse_image_dimension"
      
      image = new Image()
      image.onload = parse_image_dimension_callback
      image.src = data_url
    
    parse_image_properties_callback = (event) ->
      console.log "parse_image_properties_callback"
      data_url = event.target.result
      
      payload.contentType = Zeta.Utils.Misc.get_content_type_from_data_url data_url
      
      parse_image_dimension(data_url)
  
    parse_image_properties = (file) ->
      console.log "parse_image_properties"
      
      dataURLReader = new FileReader()
      dataURLReader.onloadend = parse_image_properties_callback
      dataURLReader.readAsDataURL(file)
      
    parse_image_data_callback = (event) ->
      console.log "parse_image_data_callback"
      array_buffer = event.target.result
      array_buffer_view = new Uint8Array(array_buffer)
      
      payload.data = array_buffer_view
      payload.hash = Zeta.Utils.Misc.encode_base64_md5_array_buffer_view(array_buffer_view)

      parse_image_properties(file)
    
    parse_image_data = (file) ->
      console.log "parse_image_data"
      reader = new FileReader()
      reader.onloadend = parse_image_data_callback
      reader.readAsArrayBuffer file     

    parse_image_data file

  ###
    PUBLIC
  ###

  upload_image: (file, callback) ->
    # 1. Upload thumbnail (max. 30 KB)
    # inline = true, correlation_id = "xyz", tag = "preview"
    
    # 2. Upload full picture (max. 5 MB)
    # inline = false, correlation_id = "xyz", tag = "medium"    
    after_preview_upload = ->
      parse_image file, callback
    
    after_preview_upload()

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