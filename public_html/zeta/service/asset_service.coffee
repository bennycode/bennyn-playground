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
      conv_id: Zeta.Storage.Session.current_conversation_id
      correlation_id: Zeta.Utils.Misc.create_random_uuid()
      public: false
      thumbnail:
        tag: "preview"
        inline: true
        nonce: Zeta.Utils.Misc.create_random_uuid()
        content_type: null
        data: null
        hash: null
        width: null
        height: null
      image:
        tag: "medium"
        inline: false
        nonce: Zeta.Utils.Misc.create_random_uuid()
        content_type: null
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
      
      cd = "zasset;conv_id=#{payload.conv_id};md5=#{payload.image.hash};width=#{payload.image.width};height=#{payload.image.height};original_width=#{payload.image.width};original_height=#{payload.image.height};inline=#{payload.image.inline};public=#{payload.public};correlation_id=#{payload.correlation_id};tag=#{payload.image.tag};nonce=#{payload.image.nonce}"
      console.log "Image:"
      console.log cd      
      
      ajax = new XMLHttpRequest()
      ajax.open "POST", Zeta.Service.URLs.create_access_token_url "/assets", true
      ajax.setRequestHeader "Content-Type", payload.image.content_type
      ajax.setRequestHeader "Content-Disposition", cd
      ajax.onreadystatechange = send_image_to_server_callback
      ajax.send payload.image.data
    
    send_thumbnail_to_server_callback = ->
      console.log "send_thumbnail_to_server_callback"
      
      if ajax.readyState is 4
        send_image_to_server()
    
    send_thumbnail_to_server = ->
      console.log "send_thumbnail_to_server"
      
      cd = "zasset;conv_id=#{payload.conv_id};md5=#{payload.thumbnail.hash};width=#{payload.thumbnail.width};height=#{payload.thumbnail.height};original_width=#{payload.image.width};original_height=#{payload.image.height};inline=#{payload.thumbnail.inline};public=#{payload.public};correlation_id=#{payload.correlation_id};tag=#{payload.thumbnail.tag};nonce=#{payload.thumbnail.nonce}"
      console.log "Thumbnail:"
      console.log cd
      
      ajax = new XMLHttpRequest()
      ajax.open "POST", Zeta.Service.URLs.create_access_token_url "/assets", true
      ajax.setRequestHeader "Content-Type", payload.thumbnail.content_type
      ajax.setRequestHeader "Content-Disposition", cd
      ajax.onreadystatechange = send_thumbnail_to_server_callback
      ajax.send payload.thumbnail.data    
    
    create_thumbnail = (image) ->
      console.log "create_thumbnail"
      
      size = 128
      width = image.width  * size / Math.max(image.width, image.height)
      height = image.height * size / Math.max(image.width, image.height)
      content_type = 'image/webp'
      
      array_buffer_view = Zeta.Utils.Misc.create_thumbnail_array_buffer_view image, size, content_type

      payload.thumbnail.tag = "preview"
      payload.thumbnail.inline = true
      payload.thumbnail.data = array_buffer_view
      payload.thumbnail.hash = Zeta.Utils.Misc.encode_base64_md5_array_buffer_view array_buffer_view
      payload.thumbnail.content_type = content_type
      payload.thumbnail.width = parseInt width, 10
      payload.thumbnail.height = parseInt height, 10
      
      console.log "Thumbnail dimension: #{payload.thumbnail.width}x#{payload.thumbnail.height}"      
      
      #send_image_to_server()
      send_thumbnail_to_server()
    
    parse_image_dimension_callback = ->
      console.log "parse_image_dimension_callback"      
      
      payload.image.width = @width
      payload.image.height = @height            
      
      console.log "Image dimension: #{payload.image.width}x#{payload.image.height}"
      
      create_thumbnail @
      #send_image_to_server()
    
    parse_image_dimension = (data_url) ->
      console.log "parse_image_dimension"
      
      image = new Image()
      image.onload = parse_image_dimension_callback
      image.src = data_url
    
    parse_image_properties_callback = (event) ->
      console.log "parse_image_properties_callback"
      data_url = event.target.result
      
      payload.image.content_type = Zeta.Utils.Misc.get_content_type_from_data_url data_url
      
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
      
      console.log "Image"
      console.log array_buffer_view
      
      payload.image.tag = "medium"
      payload.image.inline = false
      payload.image.data = array_buffer_view
      payload.image.hash = Zeta.Utils.Misc.encode_base64_md5_array_buffer_view array_buffer_view      

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