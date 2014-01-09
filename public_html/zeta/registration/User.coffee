###
  https://docs.z-infra.com/dev-device-api/latest/reference/users.html
###

namespace Zeta:
  Registration:
  class User
    constructor: (name, email, password) ->
      @name = new Zeta.Registration.UserProperty(name)
      @email = new Zeta.Registration.UserEmailAddress(email)
      @password = new Zeta.Registration.UserPassword(password)

    optional: (
      accent: []
      picture: []
      phone: ""
      phone_code: ""
    )

    getRegistrationPayload: =>
      payload = {}
      for key of @
        if @[key] instanceof Zeta.Registration.UserProperty && @[key].isValid()
          payload[key] = @[key].value
      JSON.stringify payload

    hasValidRegistrationData: ->
      if @.name.isValid() && @.email.isValid() && @.password.isValid()
        true
      else
        false