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
  
  ###    
    An MD5 value is always 22 (useful) characters long in Base64 notation.
    To bring the total up to 24 characters (3 Byte) we fill it up with 2 more
    characters (==).
  ###
  encode_base64_md5: (content) ->
    "#{b64_md5 content}=="
  
  encode_sha256: (text) ->
    sha_object = new jsSHA text, "TEXT"
    sha_object.getHash "SHA-256", "HEX"
    
  encode_base64: (text) ->
    window.btoa text
#
)()