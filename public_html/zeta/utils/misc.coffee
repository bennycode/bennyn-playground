Zeta = {} unless Zeta?
Zeta.Registration = {} unless Zeta.Registration?
Zeta.Registration.Utils = (->
  ###
    TODO: Should be done on the server-side?
    Because the PhoneFormat.js file is pretty big.
  
    @param {string} phone_number "01722290229"
    @param {string} country_code "DE"
    @returns {string} "+491722290229" (E164 format)
    @see http://www.phoneformat.com/
  ###
  convert_phone_number_to_e164: (phone_number, country_code) ->
    window.formatE164 ("" + country_code).toUpperCase(), "" + phone_number
#
)()