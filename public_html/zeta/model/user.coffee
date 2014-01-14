###
  Docs:
  https://docs.z-infra.com/dev-device-api/latest/reference/users.html
###
namespace Zeta:Model:
  class User
    constructor: (name, email, password) ->
      @name = new Zeta.Model.Username(name)
      @email = new Zeta.Model.UserEmailAddress(email)
      @password = new Zeta.Model.UserPassword(password)
      @id = "-1"
      @phone = null
      @accent = []
      @picture = []

    optional:
      accent: []
      picture: []
      phone: ""
      phone_code: ""
      
    init: (data) =>
      @name = data.name
      @email = data.email
      @id = data.id
      @phone = data.phone
      @accent = data.accent
      @picture = data.picture

    get_registration_payload: =>
      payload = {}

      for key of @
        if @[key] instanceof Zeta.Model.UserProperty && @[key].valid
          payload[key] = @[key].value

      JSON.stringify payload

    has_valid_registration_data: ->
      if @name.valid && @email.valid && @password.valid
        true
      else
        false