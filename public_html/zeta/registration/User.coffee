###
  Docs:
  https://docs.z-infra.com/dev-device-api/latest/reference/users.html
###

namespace Zeta:Registration:
  class User
    constructor: (name, email, password) ->
      @name = new Zeta.Registration.UserProperty(name)
      @email = new Zeta.Registration.UserEmailAddress(email)
      @password = new Zeta.Registration.UserPassword(password)

    optional:
      accent: []
      picture: []
      phone: ""
      phone_code: ""

    get_registration_payload: =>
      payload = {}
      for key of @
        if @[key] instanceof Zeta.Registration.UserProperty && @[key].is_valid()
          payload[key] = @[key].value
      JSON.stringify payload

    has_valid_registration_data: ->
      if @name.is_valid() && @email.is_valid() && @password.is_valid()
        true
      else
        false