Zeta = {} unless Zeta?
Zeta.Utils = {} unless Zeta.Utils?
Zeta.Utils.Misc = (->
  ###
    @param {string} phone_number "01722290229"
    @param {string} country_code "DE"
    @returns {string} "+491722290229" (E164 format)
    @see http://www.phoneformat.com/
  ###
  convert_phone_number_to_e164: (phone_number, country_code) ->
    window.formatE164 ("" + country_code).toUpperCase(), "" + phone_number
  ###
    @see http://en.wikipedia.org/wiki/Universally_unique_identifier#Version_4_.28random.29
    @see https://github.com/LiosK/UUID.js
  ###
  create_random_uuid: ->
    UUID.genV4().hexString

  get_content_type_from_data_url: (data_url) ->
    data_url.split(",")[0].split(":")[1].split(";")[0]
  
  encode_sha256: (text) ->
    sha_object = new jsSHA text, "TEXT"
    sha_object.getHash "SHA-256", "HEX"
    
  encode_base64: (text) ->
    window.btoa text
  
  ###
  Creates a base64-encoded MD5 checksum of an array buffer.
  ###
  encode_base64_md5_array_buffer_view: (array_buffer_view) ->
    md5_hash = SparkMD5.ArrayBuffer.hash(array_buffer_view.buffer)
    md5_hash_hex = md5_hash.b16decode()
    @.encode_base64(md5_hash_hex)    

  create_thumbnail_base64: (image, size, format) ->
    canvas = document.createElement 'canvas'
    canvas.width  = image.width  * size / Math.max(image.width, image.height)
    canvas.height = image.height * size / Math.max(image.width, image.height)
    ctx = canvas.getContext '2d'
    ctx.drawImage image, 0, 0, image.width, image.height, 0, 0, canvas.width, canvas.height
    canvas.toDataURL format

  create_thumbnail_array_buffer_view: (image, size, format) ->
    data_url = @create_thumbnail_base64 image, size, format
    data = window.atob(data_url.split(",")[1])
    length = data.length
    buffer = new ArrayBuffer(length)
    uInt8Array = new Uint8Array(buffer)
    i = 0

    while i < length
      uInt8Array[i] = data.charCodeAt(i)
      ++i
    
    uInt8Array

  create_thumbnail_blob: (image, size, format) ->
    data_url = @create_thumbnail_base64 image, size, format
    data = window.atob(data_url.split(",")[1])
    length = data.length
    buffer = new ArrayBuffer(length)
    uInt8Array = new Uint8Array(buffer)
    i = 0

    while i < length
      uInt8Array[i] = data.charCodeAt(i)
      ++i

    new Blob([buffer],
      type: format
    )
#
)()