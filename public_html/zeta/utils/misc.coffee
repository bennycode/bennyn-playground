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
#
)()